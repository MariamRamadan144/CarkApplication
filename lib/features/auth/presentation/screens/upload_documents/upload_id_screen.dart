import 'package:flutter/material.dart';
import 'document_upload_screen.dart';
import 'document_upload_flow.dart';

class UploadIdScreen extends StatelessWidget {
  const UploadIdScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return DocumentUploadScreen(
      documentType: DocumentType.IDFront,
      onNext: (type, file) {
        Navigator.pop(context, true); // Or handle as needed
      },
    );
  }
}
