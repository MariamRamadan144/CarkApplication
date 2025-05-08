import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:test_cark/core/utils/text_manager.dart';

class CustomTextField extends StatelessWidget {
  final TextEditingController controller;
  final IconData icon;
  final String hintText;
  final bool obscureText;
  final String? Function(String)? validator;
  final bool isRequired;

  const CustomTextField({
    super.key,
    required this.controller,
    required this.icon,
    required this.hintText,
    this.obscureText = false,
    this.validator,
    this.isRequired = true,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      obscureText: obscureText,
      validator: (value) {
        return defaultValidator(value) ?? validator?.call(value!);
      },
      decoration: InputDecoration(
        prefixIcon: Icon(icon),
        hintText: hintText.tr(),
      ),
    );
  }

  String? defaultValidator(String? value) {
    if (isRequired && value!.isEmpty) {
      return TextManager.fieldIsRequired.tr();
    }
    return null;
  }
}
