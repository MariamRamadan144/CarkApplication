import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit() : super(AuthInitial());

  Future<void> login(String email, String password) async {
    emit(AuthLoading());
    // Simulate a network call
    await Future.delayed(const Duration(seconds: 5), () {
      emit(AuthSuccess("Login successfully"));
    });
  }
  Future <void> signup(String firstname, String lastname, String email, String phone, String password) async {
    emit(AuthLoading());
    // Simulate a network call
    await Future.delayed(const Duration(seconds: 5), () {
      emit(AuthSuccess("Signup successfully"));
    });
  }
}
