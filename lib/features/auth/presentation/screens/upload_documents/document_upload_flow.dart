// lib/presentation/screens/upload_documents/document_upload_flow.dart
import 'dart:io';
import 'package:flutter/material.dart';

import 'document_upload_screen.dart';

enum DocumentType {
  ID,
  DriverLicense,
  DrugsTest,
  CriminalRecord,
  DrivingViolations,
  ProfilePhoto,
  CarPhoto,
  CarLicense,
  VehicleViolations,
  Insurance,
  CarTest,
}

class DocumentUploadFlow extends StatefulWidget {
  const DocumentUploadFlow({super.key});

  @override
  State<DocumentUploadFlow> createState() => _DocumentUploadFlowState();
}

class _DocumentUploadFlowState extends State<DocumentUploadFlow> {
  final List<DocumentType> _documentTypes = DocumentType.values;
  int _currentIndex = 0;
  final Map<DocumentType, File> _uploadedDocuments = {};

  void _handleNext(DocumentType type, File file) {
    _uploadedDocuments[type] = file;

    if (_currentIndex < _documentTypes.length - 1) {
      setState(() {
        _currentIndex++;
      });
    } else {
      // All documents uploaded successfully
      debugPrint('All documents uploaded:');
      for (var entry in _uploadedDocuments.entries) {
        debugPrint('${entry.key.name}: ${entry.value.path}');
      }
      // Navigate or trigger submission logic
    }
  }

  @override
  Widget build(BuildContext context) {
    final currentType = _documentTypes[_currentIndex];

    return DocumentUploadScreen(
      documentType: currentType,
      onNext: _handleNext,
    );
  }
}
