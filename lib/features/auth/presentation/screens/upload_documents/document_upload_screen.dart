// lib/presentation/screens/upload_documents/document_upload_screen.dart
import 'dart:io';
import 'package:flutter/material.dart';
import '../../widgets/image_upload_widget.dart';
import 'document_upload_flow.dart';

class DocumentUploadScreen extends StatefulWidget {
  final DocumentType documentType;
  final void Function(DocumentType, File) onNext;

  const DocumentUploadScreen({
    super.key,
    required this.documentType,
    required this.onNext,
  });

  @override
  State<DocumentUploadScreen> createState() => _DocumentUploadScreenState();
}

class _DocumentUploadScreenState extends State<DocumentUploadScreen> {
  File? _selectedFile;

  void _onImageSelected(File? file) {
    setState(() {
      _selectedFile = file;
    });
  }

  String _getLabelForType(DocumentType type) {
    switch (type) {
      case DocumentType.ID:
        return 'Upload ID';
      case DocumentType.DriverLicense:
        return 'Upload Driver License';
      case DocumentType.DrugsTest:
        return 'Upload Drugs Test';
      case DocumentType.CriminalRecord:
        return 'Upload Criminal Record';
      case DocumentType.DrivingViolations:
        return 'Upload Driving Violations';
      case DocumentType.ProfilePhoto:
        return 'Upload Profile Photo';
      case DocumentType.CarPhoto:
        return 'Upload Car Photo';
      case DocumentType.CarLicense:
        return 'Upload Car License';
      case DocumentType.VehicleViolations:
        return 'Upload Vehicle Violations';
      case DocumentType.Insurance:
        return 'Upload Insurance';
      case DocumentType.CarTest:
        return 'Upload Car Test';
    }
  }

  @override
  Widget build(BuildContext context) {
    final label = _getLabelForType(widget.documentType);

    return Scaffold(
      appBar: AppBar(title: Text(label)),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            ImageUploadWidget(
              label: label,
              icon: Icons.camera_alt,
              onImageSelected: _onImageSelected,
            ),
            const SizedBox(height: 24),
            ElevatedButton(
              onPressed: _selectedFile != null
                  ? () => widget.onNext(widget.documentType, _selectedFile!)
                  : null,
              /// Styling for the button - ازاي مش بياخد الحاجات ال defualt
              child: const Text('Next' ,),
            ),
          ],
        ),
      ),
    );
  }
}