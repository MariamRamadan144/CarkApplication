import 'dart:developer';
import 'dart:io';
import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../../core/api_service.dart';
import '../../../../core/services/notification_service.dart';
import '../models/user_model.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit() : super(AuthInitial()) {
    // Load user data when cubit is created
    loadUserData();
  }

  final ImagePicker imagePicker = ImagePicker();
  final NotificationService _notificationService = NotificationService();
  UserModel? userModel;
  String idImagePath = '';
  String licenceImagePath = '';
  String profileImage = '';

  File? frontIdImage;
  File? backIdImage;

  // Save user data to SharedPreferences
  Future<void> _saveUserData(UserModel user) async {
    final prefs = await SharedPreferences.getInstance();
    final userData = {
      'id': user.id,
      'first_name': user.firstName,
      'last_name': user.lastName,
      'email': user.email,
      'phone_number': user.phoneNumber,
      'national_id': user.national_id,
      'role': user.role,
      'fcm_token': user.fcmToken,
    };
    await prefs.setString('user_data', jsonEncode(userData));
  }

  // Load user data from SharedPreferences
  Future<void> loadUserData() async {
    final prefs = await SharedPreferences.getInstance();
    final userDataString = prefs.getString('user_data');
    if (userDataString != null) {
      final userData = jsonDecode(userDataString);
      userModel = UserModel.fromJson(userData);
    }
  }

  // Save FCM token for current user
  Future<void> saveFcmToken() async {
    if (userModel != null) {
      try {
        final fcmToken = await _notificationService.getFcmToken();
        if (fcmToken != null) {
          // Update user model with FCM token
          userModel = userModel!.copyWith(fcmToken: fcmToken);
          
          // Save to SharedPreferences
          await _saveUserData(userModel!);
          
          // Save to Firestore
          await _notificationService.saveFcmTokenToUser(userModel!.id, fcmToken);
          
          print('FCM token saved for user: ${userModel!.id}');
        } else {
          print('Failed to get FCM token for user: ${userModel!.id}');
        }
      } catch (e) {
        print('Error saving FCM token: $e');
        // Don't throw the error to avoid crashing the app
      }
    } else {
      print('User model is null, cannot save FCM token');
    }
  }

  // Enhanced FCM token saving with retry mechanism
  Future<void> saveFcmTokenWithRetry({int maxRetries = 3}) async {
    if (userModel == null) {
      print('User model is null, cannot save FCM token');
      return;
    }

    for (int attempt = 1; attempt <= maxRetries; attempt++) {
      try {
        final fcmToken = await _notificationService.getFcmToken();
        if (fcmToken != null) {
          // Update user model with FCM token
          userModel = userModel!.copyWith(fcmToken: fcmToken);
          
          // Save to SharedPreferences
          await _saveUserData(userModel!);
          
          // Save to Firestore
          await _notificationService.saveFcmTokenToUser(userModel!.id, fcmToken);
          
          print('FCM token saved successfully for user: ${userModel!.id} (attempt $attempt)');
          return; // Success, exit the retry loop
        } else {
          print('Failed to get FCM token for user: ${userModel!.id} (attempt $attempt)');
        }
      } catch (e) {
        print('Error saving FCM token (attempt $attempt): $e');
        if (attempt == maxRetries) {
          print('Failed to save FCM token after $maxRetries attempts');
        } else {
          // Wait before retrying
          await Future.delayed(Duration(seconds: attempt * 2));
        }
      }
    }
  }

  Future<void> login({required String email, required String password}) async {
    try {
      emit(LoginLoading());
      final response =  await ApiService().post("login/", {
        "email" : email,
        "password" : password
      });
      final data = response.data;

      // final userData = data['user']; // أو response.data مباشرة
      // final token = data['token'];

      final accessToken = data['access'];
      final refreshToken = data['refresh'];

      final prefs = await SharedPreferences.getInstance();
      await prefs.setString('access_token', accessToken);
      await prefs.setString('refresh_token', refreshToken);

      // Map to UserModel (بعد ما تضيف fromJson تحت)
      //userModel = UserModel.fromJson(userData);
      //userModel = UserModel.fromJson(response["data"]);

      // Save FCM token after successful login
      await saveFcmToken();

      emit(LoginSuccess("Congrats"));
    }
    catch(error)
    {

      emit(LoginFailure("Error"));
    }
  }

  // Future<void> signup(String firstname, String lastname, String email,
  //     String phone, String password, String id) async {
  //   emit(SignUpLoading());
  //   await Future.delayed(const Duration(seconds: 5), () {
  //     emit(SignUpSuccess("Signup successfully"));
  //   });
  // }

  Future<void> signup(String firstname, String lastname, String email,
    //   String phone, String password, String id) async {
    // emit(SignUpLoading());
    // await Future.delayed(const Duration(seconds: 2));
    // log("firstname: $firstname, lastname: $lastname, email: $email, phone: $phone, password: $password , id : $id");
    // emit(SignUpSuccess("Signup successful"));
   String phone, String password,String national_id) async {
    try {
      emit(SignUpLoading());
      final response = await ApiService().post("register/", {
        "first_name": firstname,
        "last_name": lastname,
        "email": email,
        "phone_number": phone,
        "password": password,
        "national_id": national_id,
      });
      final data = response.data;

      // تأكد إذا كان السيرفر بيرجع التوكن أو بيانات المستخدم
      if (response.statusCode == 201) {

        userModel = UserModel.fromJson(data); //  خزّن بيانات المستخدم
        
        // Save user data to SharedPreferences
        await _saveUserData(userModel!);

        // Save FCM token after successful signup
        await saveFcmToken();

        // هنا ممكن تبدأ عملية رفع الصور بعد نجاح التسجيل
        // await uploadIdImage(...)
        // await uploadLicenceImage(...)

        await Future.delayed(const Duration(seconds: 2));
        emit(SignUpSuccess("Signup successful"));
      }
    }catch(e){
      emit(SignUpFailure("Something went wrong. Please try again."));
    }
    log("firstname: $firstname, lastname: $lastname, email: $email, phone: $phone, password: $password , id : $national_id");

    //log("firstname: $firstname, lastname: $lastname, email: $email, phone: $phone, password: $password");
  }

  Future<void> uploadIdImage({required bool isFront}) async {
    emit(UploadIdImageLoading());
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.camera);
    if (pickedFile != null) {
      if (isFront) {
        frontIdImage = File(pickedFile.path);
      } else {
        backIdImage = File(pickedFile.path);
      }
      emit(UploadIdImageSuccess());
    } else {
      emit(UploadIdImageFailure("No image selected"));
    }
  }

  Future<void> uploadLicenceImage() async {
    emit(UploadLicenceImageLoading());
    final pickedFile = await imagePicker.pickImage(source: ImageSource.camera);
    if (pickedFile != null) {
      licenceImagePath = pickedFile.path;
      emit(UploadLicenceImageSuccess());
    } else {
      if (licenceImagePath.isEmpty) {
        emit(UploadLicenceImageFailure("No image selected"));
      } else {
        emit(UploadLicenceImageSuccess());
      }
    }
  }

  Future<void> editProfile(
      {required String firstname,
      required String lastname,
      required String email,
      required String phoneNumber,
      required String national_id}) async {
    emit(EditProfileLoading());
    await Future.delayed(const Duration(seconds: 2), () async {
      userModel = UserModel(
        id: userModel?.id ?? DateTime.now().millisecondsSinceEpoch.toString(),
        firstName: firstname,
        lastName: lastname,
        email: email,
        phoneNumber: phoneNumber,
        national_id: national_id,
        role: userModel?.role ?? 'renter',
      );
      
      // Save updated user data to SharedPreferences
      await _saveUserData(userModel!);
      
      emit(EditProfileSuccess("Profile updated successfully"));
    });
  }

  Future<void> uploadProfileImage() async {
    emit(UploadProfileScreenImageLoading());
    final pickedFile = await imagePicker.pickImage(source: ImageSource.camera);
    if (pickedFile != null) {
      profileImage = pickedFile.path;
      emit(UploadProfileScreenImageSuccess());
    } else {
      if (profileImage.isEmpty) {
        emit(UploadProfileScreenImageFailure("No image selected"));
      } else {
        emit(UploadProfileScreenImageSuccess());
      }
    }
  }

  // Toggle user role between renter and owner
  void toggleRole() {
    // This is a simple implementation - you might want to store role in UserModel
    // For now, we'll just emit a state change
    emit(AuthInitial());
  }

  // Switch to owner mode and navigate to add car
  Future<void> switchToOwner() async {
    if (userModel != null) {
      // Update user role to owner
      userModel = userModel!.copyWith(role: 'owner');
      
      // Save updated user data to SharedPreferences
      await _saveUserData(userModel!);
      
      emit(AuthInitial());
    }
  }

  // Switch back to renter mode
  Future<void> switchToRenter() async {
    if (userModel != null) {
      // Update user role to renter
      userModel = userModel!.copyWith(role: 'renter');
      
      // Save updated user data to SharedPreferences
      await _saveUserData(userModel!);
      
      emit(AuthInitial());
    }
  }

  // Logout user
  Future<void> logout() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('user_data');
    await prefs.remove('access_token');
    await prefs.remove('refresh_token');
    userModel = null;
    emit(AuthInitial());
  }
}
