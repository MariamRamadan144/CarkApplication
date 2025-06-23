import 'dart:developer';
import 'dart:io';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:test_cark/features/auth/presentation/cubits/auth_cubit.dart';
import '../../../../../core/utils/custom_toast.dart';
import '../../../../../core/utils/text_manager.dart';
import '../../../../../core/widgets/custom_elevated_button.dart';
import '../../../../../core/widgets/custom_text_form_field.dart';
import '../../screens/upload_documents/document_upload_flow.dart';
import '../profile_custom_widgets/licence_image_widget.dart';
import 'id_image_upload_widget.dart';


class SignupForm extends StatelessWidget {
  const SignupForm({
    super.key,
    required this.formKey,
    required this.firstnameController,
    required this.lastnameController,
    required this.emailController,
    required this.phoneController,
    required this.passwordController,
    required this.nationalIdController,
    required this.headerText,
  });

  final String headerText;
  final GlobalKey<FormState> formKey;
  final TextEditingController firstnameController;
  final TextEditingController lastnameController;
  final TextEditingController emailController;
  final TextEditingController phoneController;
  final TextEditingController passwordController;
  final TextEditingController nationalIdController;

  // Email Validator
  String? _validateEmail(String value) {
    final emailRegex = RegExp(r'^[^@]+@[^@]+\.[^@]+');
    if (!emailRegex.hasMatch(value)) return TextManager.email_invalid.tr();
    return null;
  }

  // Phone Number Validator
  String? _validatePhone(String value) {
    final phoneRegex = RegExp(r'^01[0-9]{9}$');
    if (!phoneRegex.hasMatch(value)) return TextManager.phone_invalid.tr();
    return null;
  }

  // Password Validator
  String? _validatePassword(String value) {
    if (value.length < 6) return TextManager.password_too_short.tr();
    return null;
  }

  // National ID Validator
  String? _validateNationalId(String value) {
    final nationalIdRegex = RegExp(
        r"^([23])\d{2}(0[1-9]|1[0-2])(0[1-9]|[12]\d|3[01])(0[1-4]|1[1-9]|2[1-9]|3[1-5]|88)\d{5}$");
    if (!nationalIdRegex.hasMatch(value))
      return TextManager.national_id_invalid.tr();
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Create Account Text
          Text(
            headerText.tr(),
            style: const TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),

          SizedBox(height: 0.02.sh),

          // First Name Field
          CustomTextFormField(
            controller: firstnameController,
            prefixIcon: Icons.person,
            hintText: TextManager.first_name_hint,
          ),

          SizedBox(height: 0.02.sh),

          // Last Name Field
          CustomTextFormField(
            controller: lastnameController,
            prefixIcon: Icons.person,
            hintText: TextManager.last_name_hint,
          ),

          SizedBox(height: 0.02.sh),

          // Email Field
          CustomTextFormField(
            controller: emailController,
            prefixIcon: Icons.email,
            hintText: TextManager.email_hint,
            validator: _validateEmail,
          ),

          SizedBox(height: 0.02.sh),

          // Phone Number Field
          CustomTextFormField(
            controller: phoneController,
            prefixIcon: Icons.phone,
            hintText: TextManager.phone_hint,
            validator: _validatePhone,
          ),

          SizedBox(height: 0.02.sh),
          // Password Field
          CustomTextFormField(
            controller: passwordController,
            prefixIcon: Icons.lock,
            hintText: TextManager.password_hint,
            obscureText: true,
            validator: _validatePassword,
          ),

          SizedBox(height: 0.02.sh),
          // Password Field
          CustomTextFormField(
            controller: nationalIdController,
            prefixIcon: Icons.perm_identity,
            hintText: TextManager.national_id_hint,
            // validator: _validatePassword,
          ),

          SizedBox(height: 0.03.sh),

          // const CustomImagePicker(label: TextManager.upload_your_id,),

          SizedBox(height: 0.03.sh),

          // Upload ID Images
          // const IdImageUploadWidget(),

          SizedBox(height: 0.03.sh),

          // Upload Licence Image Button
          // const LicenceImageWidget(),

          SizedBox(
            height: 0.03.sh,
          ),
          // Signup Button
          BlocConsumer<AuthCubit, AuthState>(
            listener: (context, state) {
              if (state is SignUpSuccess) {
                showCustomToast(state.message, false);
                // Navigate to DocumentUploadFlow after successful signup
                Navigator.of(context).pushReplacement(
                  MaterialPageRoute(
                    builder: (_) => const DocumentUploadFlow(),
                  ),
                );
              } else if (state is SignUpFailure) {
                showCustomToast(state.error, true);
              }
            },
            builder: (context, state) {
              final authCubit = context.read<AuthCubit>();
              if (state is SignUpLoading) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
              return CustomElevatedButton(
                text: TextManager.sign_up_text,
                onPressed: () {
                  if (formKey.currentState!.validate()) {
                    authCubit.signup(
                      firstnameController.text,
                      lastnameController.text,
                      emailController.text,
                      phoneController.text,
                      passwordController.text,
                    );
                  }
                },
              );
            },
          ),
        ],
      ),
    );
  }
}
