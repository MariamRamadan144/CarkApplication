import 'package:flutter/material.dart';

class InstructionText extends StatelessWidget {
  final String text;
  const InstructionText({required this.text, super.key});

  @override
  Widget build(BuildContext context) {

    return Text(
      text,
      style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
      textAlign: TextAlign.center,
    );
  }
}
