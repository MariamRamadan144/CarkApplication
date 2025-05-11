import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:test_cark/config/routes/screens_name.dart';
import 'package:test_cark/core/utils/assets_manager.dart';
import '../../../../../core/utils/text_manager.dart';
import '../../cubits/auth_cubit.dart';
import '../../widgets/auth_options_text.dart';
import '../../widgets/login_custom_widgets/login_form.dart';
import '../../widgets/login_custom_widgets/login_header.dart';


class LoginScreen extends StatefulWidget {
  LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  late final TextEditingController _emailController;

  late final TextEditingController _passwordController;

  late final GlobalKey<FormState> _formKey;

  @override
  void initState() {
    _emailController = TextEditingController();
    _passwordController = TextEditingController();
    _formKey = GlobalKey<FormState>();
    super.initState();
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.sizeOf(context).width;
    // 1
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const LoginHeader(),

              // Login form
              LoginForm(
                emailController: _emailController,
                passwordController: _passwordController,
                formKey: _formKey,
              ),

              SizedBox(height: 0.02.sh),

              // Signup or login
              const AuthOptionsText(
                text1: TextManager.no_account_question,
                text2: TextManager.sign_up_text,
                screenName: ScreensName.signup,
              ),

              SizedBox(height: 0.2.sh),

              // Car Image
              Image.asset(
                AssetsManager.carLoginScreen,
                width: screenWidth,
                fit: BoxFit.contain,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
