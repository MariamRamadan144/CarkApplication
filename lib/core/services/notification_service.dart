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

  // Add a notification to Firestore for a user
  Future<void> sendNotificationToUser({
    required String userId,
    required String title,
    required String body,
    required String type, // 'booking', 'payment', 'car', 'general'
  }) async {
    await FirebaseFirestore.instance.collection('Notification').add({
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
        body: 'You have a new booking request for your car $carName.',
        timestamp: DateTime.now(),
        type: 'owner',
      );

      // Save to Firestore
      await FirebaseFirestore.instance.collection('notifications').add(renterNotification.toMap());
      await FirebaseFirestore.instance.collection('notifications').add(ownerNotification.toMap());

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