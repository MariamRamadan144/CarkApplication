import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

///DONE
/// A simple widget to display instruction text in the document upload flow.
class InstructionText extends StatelessWidget {
  final String text;
  const InstructionText({required this.text, super.key});

  @override
  Widget build(BuildContext context) {

    return Text(
      text,
      style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.w500),
      textAlign: TextAlign.center,
    );
  }
}
