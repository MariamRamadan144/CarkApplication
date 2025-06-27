import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter/material.dart';
import '../../features/notifications/presentation/models/notification_model.dart';

class NotificationService {
  static final NotificationService _instance = NotificationService._internal();
  factory NotificationService() => _instance;
  NotificationService._internal();

  late FirebaseMessaging _messaging;
  late FlutterLocalNotificationsPlugin _localNotifications;

  Future<void> init() async {
    await Firebase.initializeApp();
    _messaging = FirebaseMessaging.instance;
    _localNotifications = FlutterLocalNotificationsPlugin();
    await _initLocalNotifications();
    await _initFCM();
  }

  Future<void> _initLocalNotifications() async {
    const AndroidInitializationSettings androidSettings = AndroidInitializationSettings('@mipmap/ic_launcher');
    const InitializationSettings initSettings = InitializationSettings(android: androidSettings);
    await _localNotifications.initialize(initSettings);
  }

  Future<void> _initFCM() async {
    NotificationSettings settings = await _messaging.requestPermission();
    if (settings.authorizationStatus == AuthorizationStatus.authorized) {
      FirebaseMessaging.onMessage.listen(_onMessage);
      FirebaseMessaging.onMessageOpenedApp.listen(_onMessageOpenedApp);
    }
  }

  void _onMessage(RemoteMessage message) {
    if (message.notification != null) {
      _showLocalNotification(message.notification!);
    }
  }

  void _onMessageOpenedApp(RemoteMessage message) {
    // Handle notification tap
  }

  Future<void> _showLocalNotification(RemoteNotification notification) async {
    const AndroidNotificationDetails androidDetails = AndroidNotificationDetails(
      'default_channel',
      'Default',
      importance: Importance.max,
      priority: Priority.high,
    );
    const NotificationDetails details = NotificationDetails(android: androidDetails);
    await _localNotifications.show(
      notification.hashCode,
      notification.title,
      notification.body,
      details,
    );
  }

  Future<String?> getFcmToken() async {
    return await _messaging.getToken();
  }

  // Save FCM token to user's profile in Firestore
  Future<void> saveFcmTokenToUser(String userId, String fcmToken) async {
    try {
      await FirebaseFirestore.instance
          .collection('users')
          .doc(userId)
          .update({'fcm_token': fcmToken});
      print('FCM token saved for user: $userId');
    } catch (e) {
      print('Error saving FCM token: $e');
    }
  }

  // Get FCM token for a specific user
  Future<String?> getUserFcmToken(String userId) async {
    try {
      final doc = await FirebaseFirestore.instance
          .collection('users')
          .doc(userId)
          .get();
      return doc.data()?['fcm_token'];
    } catch (e) {
      print('Error getting FCM token for user $userId: $e');
      return null;
    }
  }

  // Get all renter FCM tokens
  Future<List<String>> getAllRenterFcmTokens() async {
    try {
      final querySnapshot = await FirebaseFirestore.instance
          .collection('users')
          .where('role', isEqualTo: 'renter')
          .get();
      
      List<String> tokens = [];
      for (var doc in querySnapshot.docs) {
        final token = doc.data()['fcm_token'];
        if (token != null && token.isNotEmpty) {
          tokens.add(token);
        }
      }
      return tokens;
    } catch (e) {
      print('Error getting renter FCM tokens: $e');
      return [];
    }
  }

  // Send notification when a new car is added (to all renters)
  Future<void> sendNewCarNotification({
    required String carBrand,
    required String carModel,
    required String ownerName,
  }) async {
    try {
      // Get all renter FCM tokens
      final renterTokens = await getAllRenterFcmTokens();
      
      if (renterTokens.isEmpty) {
        print('No renter FCM tokens found');
        return;
      }

      // Create notification data for FCM
      final notificationData = {
        'title': '🚗 New Car Available!',
        'body': 'A new car has been added for rent!',
        'type': 'new_car',
        'car_brand': carBrand,
        'car_model': carModel,
        'owner_name': ownerName,
      };

      // Send to all renters (in a real app, this would be done via backend)
      for (String token in renterTokens) {
        await _sendFcmNotification(token, notificationData);
      }

      // Also save to Firestore for in-app notifications
      await _saveNewCarNotificationToFirestore(carBrand, carModel, ownerName);
      
      print('New car notification sent to ${renterTokens.length} renters');
    } catch (e) {
      print('Error sending new car notification: $e');
    }
  }

  // Send notification when a car is booked (to car owner)
  Future<void> sendCarBookedNotification({
    required String ownerId,
    required String renterName,
    required String carBrand,
    required String carModel,
  }) async {
    try {
      // Get owner's FCM token
      final ownerToken = await getUserFcmToken(ownerId);
      
      if (ownerToken == null) {
        print('Owner FCM token not found for user: $ownerId');
        return;
      }

      // Create notification data for FCM
      final notificationData = {
        'title': '✅ Car Booked!',
        'body': 'Your car has been booked by $renterName.',
        'type': 'car_booked',
        'renter_name': renterName,
        'car_brand': carBrand,
        'car_model': carModel,
      };

      // Send FCM notification
      await _sendFcmNotification(ownerToken, notificationData);

      // Also save to Firestore for in-app notifications
      await _saveCarBookedNotificationToFirestore(ownerId, renterName, carBrand, carModel);
      
      print('Car booked notification sent to owner: $ownerId');
    } catch (e) {
      print('Error sending car booked notification: $e');
    }
  }

  // Helper method to send FCM notification (simulated - in real app this would be via backend)
  Future<void> _sendFcmNotification(String token, Map<String, dynamic> data) async {
    // In a real implementation, this would be done via your backend server
    // For now, we'll simulate the notification by showing a local notification
    await _showLocalNotification(RemoteNotification(
      title: data['title'],
      body: data['body'],
    ));
    
    print('FCM notification would be sent to token: $token');
    print('Notification data: $data');
  }

  // Save new car notification to Firestore for all renters
  Future<void> _saveNewCarNotificationToFirestore(String carBrand, String carModel, String ownerName) async {
    try {
      // Get all renter user IDs
      final querySnapshot = await FirebaseFirestore.instance
          .collection('users')
          .where('role', isEqualTo: 'renter')
          .get();
      
      // Create notification for each renter
      for (var doc in querySnapshot.docs) {
        final renterId = doc.id;
        await FirebaseFirestore.instance.collection('notifications').add({
          'userId': renterId,
          'title': '🚗 New Car Available!',
          'body': 'A new $carBrand $carModel has been added for rent by $ownerName.',
          'type': 'renter',
          'timestamp': FieldValue.serverTimestamp(),
          'read': false,
          'notification_type': 'new_car',
          'car_brand': carBrand,
          'car_model': carModel,
        });
      }
    } catch (e) {
      print('Error saving new car notification to Firestore: $e');
    }
  }

  // Save car booked notification to Firestore for owner
  Future<void> _saveCarBookedNotificationToFirestore(String ownerId, String renterName, String carBrand, String carModel) async {
    try {
      await FirebaseFirestore.instance.collection('notifications').add({
        'userId': ownerId,
        'title': '✅ Car Booked!',
        'body': 'Your $carBrand $carModel has been booked by $renterName.',
        'type': 'owner',
        'timestamp': FieldValue.serverTimestamp(),
        'read': false,
        'notification_type': 'car_booked',
        'renter_name': renterName,
        'car_brand': carBrand,
        'car_model': carModel,
      });
    } catch (e) {
      print('Error saving car booked notification to Firestore: $e');
    }
  }

  // Add a notification to Firestore for a user
  Future<void> sendNotificationToUser({
    required String userId,
    required String title,
    required String body,
    required String type, // 'booking', 'payment', 'car', 'general'
  }) async {
    await FirebaseFirestore.instance.collection('notifications').add({
      'userId': userId,
      'title': title,
      'body': body,
      'type': type,
      'timestamp': FieldValue.serverTimestamp(),
      'read': false,
    });
  }

  // Send booking notifications for both renter and owner
  Future<void> sendBookingNotifications({
    required String renterId,
    required String ownerId,
    required String carName,
  }) async {
    try {
      // Get user names for better notification messages
      final renterDoc = await FirebaseFirestore.instance.collection('users').doc(renterId).get();
      final ownerDoc = await FirebaseFirestore.instance.collection('users').doc(ownerId).get();
      
      final renterName = renterDoc.data()?['first_name'] ?? 'A renter';
      final ownerName = ownerDoc.data()?['first_name'] ?? 'The owner';

      // Notification for renter
      final renterNotification = NotificationModel(
        id: '', // Will be set by Firestore
        userId: renterId,
        title: 'Booking Requested',
        body: 'Your booking has been requested.',
        timestamp: DateTime.now(),
        type: 'renter',
      );

      // Notification for owner
      final ownerNotification = NotificationModel(
        id: '', // Will be set by Firestore
        userId: ownerId,
        title: 'New Booking Request',
        body: 'You have a new booking request for your car $carName from $renterName.',
        timestamp: DateTime.now(),
        type: 'owner',
      );

      // Save to Firestore
      await FirebaseFirestore.instance.collection('notifications').add(renterNotification.toMap());
      await FirebaseFirestore.instance.collection('notifications').add(ownerNotification.toMap());

      // Send FCM notifications
      await sendCarBookedNotification(
        ownerId: ownerId,
        renterName: renterName,
        carBrand: carName.split(' ').first,
        carModel: carName.split(' ').skip(1).join(' '),
      );

      print('Booking notifications sent successfully');
      print('Renter notification: ${renterNotification.toString()}');
      print('Owner notification: ${ownerNotification.toString()}');
    } catch (e) {
      print('Error sending booking notifications: $e');
    }
  }

  // Get notifications for a specific user and type
  Stream<List<NotificationModel>> getNotificationsForUser(String userId, String type) {
    return FirebaseFirestore.instance
        .collection('notifications')
        .where('userId', isEqualTo: userId)
        .where('type', isEqualTo: type)
        .orderBy('timestamp', descending: true)
        .snapshots()
        .map((snapshot) => snapshot.docs
            .map((doc) => NotificationModel.fromFirestore(doc))
            .toList());
  }

  // Get all notifications for a user (both types)
  Stream<List<NotificationModel>> getAllNotificationsForUser(String userId) {
    return FirebaseFirestore.instance
        .collection('notifications')
        .where('userId', isEqualTo: userId)
        .orderBy('timestamp', descending: true)
        .snapshots()
        .map((snapshot) => snapshot.docs
            .map((doc) => NotificationModel.fromFirestore(doc))
            .toList());
  }

  // Mark notification as read
  Future<void> markNotificationAsRead(String notificationId) async {
    await FirebaseFirestore.instance
        .collection('notifications')
        .doc(notificationId)
        .update({'read': true});
  }
} 