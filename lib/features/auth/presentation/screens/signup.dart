import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_cark/core/utils/assets_manager.dart';
import 'package:test_cark/core/utils/text_manager.dart';
import 'package:test_cark/features/auth/presentation/cubits/auth_cubit.dart';
import '../../../../core/widgets/custom_text_field.dart';
import 'login_screen.dart';

/// clean
/// 1-upload images -> code in comments
/// 2-snack bar color
/// 3-colors , fonts and padding

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _firstnameController = TextEditingController();
  final TextEditingController _lastnameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  String? _validateEmail(String value) {
    final emailRegex = RegExp(r'^[^@]+@[^@]+\.[^@]+');
    if (!emailRegex.hasMatch(value)) return TextManager.email_invalid.tr();
    return null;
  }

  String? _validatePhone(String value) {
    final phoneRegex = RegExp(r'^01[0-9]{9}$');
    if (!phoneRegex.hasMatch(value)) return TextManager.phone_invalid.tr();
    return null;
  }

  String? _validatePassword(String value) {
    if (value.length < 6) return TextManager.password_too_short.tr();
    return null;
  }

  @override
  void dispose() {
    _firstnameController.dispose();
    _lastnameController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.sizeOf(context).width;
    final screenHeight = MediaQuery.sizeOf(context).height;

    return BlocProvider(
      create: (context) => AuthCubit(),
      child: Scaffold(
        body: SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(
                horizontal: screenWidth * 0.08, vertical: screenHeight * 0.02),
            child: SingleChildScrollView(
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset(AssetsManager.carSignUp,
                            height: screenHeight * 0.05),
                        SizedBox(width: screenWidth * 0.02),
                        Image.asset(AssetsManager.carkSignUp,
                            height: screenHeight * 0.03),
                      ],
                    ),
                    SizedBox(height: screenHeight * 0.02),
                    Text(
                      TextManager.create_account.tr(),
                      style: const TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: screenHeight * 0.02),
                    CustomTextField(
                      controller: _firstnameController,
                      icon: Icons.person,
                      hintText: TextManager.first_name_hint,
                    ),
                    CustomTextField(
                      controller: _lastnameController,
                      icon: Icons.person,
                      hintText: TextManager.last_name_hint,
                    ),
                    CustomTextField(
                      controller: _emailController,
                      icon: Icons.email,
                      hintText: TextManager.email_hint,
                      validator: _validateEmail,
                    ),
                    CustomTextField(
                      controller: _phoneController,
                      icon: Icons.phone,
                      hintText: TextManager.phone_hint,
                      validator: _validatePhone,
                    ),
                    CustomTextField(
                      controller: _passwordController,
                      icon: Icons.lock,
                      hintText: TextManager.password_hint,
                      obscureText: true,
                      validator: _validatePassword,
                    ),
                    SizedBox(height: screenHeight * 0.03),
                    Center(
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xff120A53),
                          padding: EdgeInsets.symmetric(
                              horizontal: screenWidth * 0.3,
                              vertical: screenHeight * 0.02),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content:
                                    Text(TextManager.registration_success.tr()),
                              ),
                            );
                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                  content: Text(
                                      TextManager.registration_failed.tr())),
                            );
                          }
                        },
                        child: Text(
                          TextManager.register_button.tr(),
                          style: const TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w700,
                              fontSize: 15),
                        ),
                      ),
                    ),
                    SizedBox(height: screenHeight * 0.02),
                    Center(
                      child: GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => LoginScreen(),
                            ),
                          );
                        },
                        child: RichText(
                          text: TextSpan(
                            style: const TextStyle(
                                color: Colors.black, fontSize: 16),
                            children: [
                              TextSpan(
                                  text: TextManager.already_have_account.tr()),
                              TextSpan(
                                text: TextManager.login_text.tr(),
                                style: const TextStyle(
                                  color: Color(0xff120A53),
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
