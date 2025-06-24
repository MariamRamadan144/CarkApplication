import 'dart:io';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../screens/upload_documents/document_upload_flow.dart';
import 'document_state.dart';

class DocumentCubit extends Cubit<DocumentState> {
  DocumentCubit() : super(DocumentInitial());

  void uploadDocument(DocumentType type, File file) async {
    emit(DocumentLoading(state.documents));
    try {
      final updatedDocs = Map<DocumentType, File?>.from(state.documents);
      updatedDocs[type] = file;
      // Simulate upload delay
      await Future.delayed(const Duration(milliseconds: 500));
      emit(DocumentSuccess(updatedDocs, message: "Document uploaded successfully"));
    } catch (e) {
      emit(DocumentFailure(state.documents, e.toString()));
    }
  }

  void removeDocument(DocumentType type) async {
    emit(DocumentLoading(state.documents));
    try {
      final updatedDocs = Map<DocumentType, File?>.from(state.documents);
      updatedDocs[type] = null;
      await Future.delayed(const Duration(milliseconds: 200));
      emit(DocumentSuccess(updatedDocs, message: "Document removed successfully"));
    } catch (e) {
      emit(DocumentFailure(state.documents, e.toString()));
    }
  }

  void resetDocuments() {
    emit(DocumentInitial());
  }
} 