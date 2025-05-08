import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_cark/config/routes/screens_name.dart';
import 'package:test_cark/core/utils/assets_manager.dart';
import '../../../../core/utils/text_manager.dart';
import '../cubits/auth_cubit.dart';
import '../widgets/login_form.dart';

/// clean
// set color : color: Theme.of(context).colorScheme.secondary, > get the mode then access the color from colorScheme then get the color


class LoginCubitTest extends StatefulWidget {
  LoginCubitTest({super.key});

  @override
  State<LoginCubitTest> createState() => _LoginCubitTestState();
}

class _LoginCubitTestState extends State<LoginCubitTest> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.sizeOf(context).width;
    double screenHeight = MediaQuery.sizeOf(context).height;
    // 1
    return BlocProvider(
      create: (context) => AuthCubit(),
      child: Scaffold(
          body: SafeArea(
        child: SingleChildScrollView(
          child: SizedBox(
            height: screenHeight,
            // 2
            child: BlocBuilder<AuthCubit, AuthState>(
              builder: (context, state) {
                final authCubit = context.read<AuthCubit>();
                if(state is AuthLoading){
                  return Center(
                    child: CircularProgressIndicator(
                      color: Theme.of(context).colorScheme.primary,
                    ),
                  );
                }
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(
                        top: screenHeight * 0.05,
                        left: screenWidth * 0.05,
                      ),
                      child: Text(
                        TextManager.login_now.tr(),
                        style: TextStyle(
                          fontSize: screenWidth * 0.07,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: screenWidth * 0.05,
                        vertical: screenHeight * 0.015,
                      ),
                      child: Text(
                        TextManager.login_intro_message.tr(),
                        style: TextStyle(
                          fontWeight: FontWeight.w500,
                          color: Theme.of(context).colorScheme.secondary,
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: screenWidth * 0.05),
                      child: LoginForm(
                        emailController: _emailController,
                        passwordController: _passwordController,
                        onLoginPressed: () {
                            authCubit.login(_emailController.text, _passwordController.text);
                          // Handle login logic
                        },
                      ),
                    ),
                    SizedBox(height: screenHeight * 0.02),
                    Center(
                      child: RichText(
                        text: TextSpan(
                          children: [
                            TextSpan(
                              text:
                              "${TextManager.no_account_question.tr()} ",
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: screenWidth * 0.04,
                              ),
                            ),
                            TextSpan(
                              recognizer: TapGestureRecognizer()
                                ..onTap = () {
                                  Navigator.pushNamed(
                                      context, ScreensName.signup);
                                },
                              text: TextManager.sign_up_text.tr(),
                              style: TextStyle(
                                color:
                                Theme.of(context).colorScheme.primary,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    const Spacer(),
                    Image.asset(
                      AssetsManager.carLoginScreen,
                      //  "assets/images/login/car(Login_screen).png"
                      width: screenWidth,
                      fit: BoxFit.contain,
                    ),
                  ],
                );
              },
            ),
          ),
        ),
      )),
    );
  }
}
