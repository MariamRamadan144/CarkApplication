import 'dart:developer';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import '../models/user_model.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit() : super(AuthInitial());

  final ImagePicker imagePicker = ImagePicker();
  UserModel? userModel;
  String idImagePath = '';
  String licenceImagePath = '';
  String profileImage = '';

  File? frontIdImage;
  File? backIdImage;

  Future<void> login({required String email, required String password}) async {
    emit(LoginLoading());
    // Simulate a network call
    await Future.delayed(const Duration(seconds: 5), () {
      // Set default user with role 'renter' - users start as renters
      userModel = UserModel(
        id: '1',
        firstName: 'Demo',
        lastName: 'User',
        email: email,
        phoneNumber: '01000000000',
        role: 'renter',
      );
      emit(LoginSuccess("Login successfully"));
    });
  }

  // Future<void> signup(String firstname, String lastname, String email,
  //     String phone, String password) async {
  //   emit(SignUpLoading());
  //   await Future.delayed(const Duration(seconds: 5), () {
  //     emit(SignUpSuccess("Signup successfully"));
  //   });
  // }

  Future<void> signup(String firstname, String lastname, String email,
      String phone, String password, String id) async {
    emit(SignUpLoading());
    await Future.delayed(const Duration(seconds: 2));
    log("firstname: $firstname, lastname: $lastname, email: $email, phone: $phone, password: $password , id : $id");
    userModel = UserModel(
      id: id,
      firstName: firstname,
      lastName: lastname,
      email: email,
      phoneNumber: phone,
      role: 'renter',
    );
    emit(SignUpSuccess("Signup successful"));
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
      required id}) async {
    emit(EditProfileLoading());
    await Future.delayed(const Duration(seconds: 5), () {
      userModel = UserModel(
        firstName: firstname,
        lastName: lastname,
        email: email,
        phoneNumber: phoneNumber,
        id: id,
      );
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

  void toggleRole() {
    if (userModel != null) {
      final newRole = userModel!.role == 'renter' ? 'owner' : 'renter';
      userModel = UserModel(
        id: userModel!.id,
        firstName: userModel!.firstName,
        lastName: userModel!.lastName,
        email: userModel!.email,
        phoneNumber: userModel!.phoneNumber,
        role: newRole,
      );
      emit(AuthRoleChanged(newRole));
    }
  }
}
