import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../config/themes/app_colors.dart';
import '../../../../../core/utils/assets_manager.dart';
import '../../../../home/presentation/widgets/search_widgets/camera_preview_box.dart';
import 'document_upload_flow.dart';
import '../../cubits/document_cubit.dart';
import '../../cubits/document_state.dart';

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

  @override
  void didUpdateWidget(covariant DocumentUploadScreen oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.documentType != widget.documentType) {
      setState(() {
        _selectedFile = null;
      });
    }
  }

  Future<void> _pickImage() async {
    final picker = ImagePicker();
    final picked = await picker.pickImage(source: ImageSource.camera);
    if (picked != null) {
      setState(() {
        _selectedFile = File(picked.path);
      });
    }
  }

  void _uploadDocument(BuildContext context) {
    if (_selectedFile != null) {
      context.read<DocumentCubit>().uploadDocument(widget.documentType, _selectedFile!);
    }
  }

  String _getLabelForType(DocumentType type) {
    switch (type) {
      case DocumentType.IDFront:
        return 'ID';
      case DocumentType.IDBack:
        return 'ID';
      case DocumentType.DriverLicense:
        return 'Driver License';
      case DocumentType.DrugsTest:
        return 'Drugs Test';
      case DocumentType.CriminalRecord:
        return 'Criminal Record';
      case DocumentType.DrivingViolations:
        return 'Driving Violations';
      case DocumentType.ProfilePhoto:
        return 'Profile Photo';
      case DocumentType.CarPhoto:
        return 'Car Photo';
      case DocumentType.CarLicense:
        return 'Car License';
      case DocumentType.VehicleViolations:
        return 'Vehicle Violations';
      case DocumentType.Insurance:
        return 'Insurance';
      case DocumentType.CarTest:
        return 'Car Test';
    }
  }

  String _getInstructionsForType(DocumentType type) {
    switch (type) {
      case DocumentType.DriverLicense:
        return 'Make sure both front and back sides of your driver\'s license are visible.\n\nEnsure the license is not expired and all details are readable.';
      case DocumentType.DrugsTest:
        return 'Upload a recent drug test result issued by an authorized center.\n\nMake sure the result includes your full name and test date.';
      case DocumentType.CriminalRecord:
        return 'Upload an official criminal record certificate issued by the government.\n\nEnsure it is stamped, recent (within 3 months), and your name is clear.';
      case DocumentType.DrivingViolations:
        return 'Provide a copy or screenshot of your driving record from official sources.\n\nMake sure any recent violations are clearly visible.';
      case DocumentType.ProfilePhoto:
        return 'Upload a clear photo of yourself facing forward with good lighting.\n\nAvoid sunglasses, filters, or background distractions.';
      case DocumentType.IDFront:
        return 'Upload your Front National ID (valid and not expired).\n\ front Side must be shown clearly.';
      case DocumentType.IDBack:
        return 'Upload the back side of your National ID.\n\nEnsure all details are visible and the document is not expired.';
      case DocumentType.CarPhoto:
        return 'Upload multiple photos of the car from front, side, and back.\n\nEnsure the car is clean and license plate is visible.';
      case DocumentType.CarLicense:
        return 'Upload the official car registration document.\n\nEnsure the car details and expiry date are visible.';
      case DocumentType.VehicleViolations:
        return 'Provide a screenshot or document showing no pending vehicle violations.\n\nEnsure your license plate number appears in the document.';
      case DocumentType.Insurance:
        return 'Upload a valid car insurance document with your name and coverage dates.\n\nEnsure the policy is active and clearly readable.';
      case DocumentType.CarTest:
        return 'Upload a photo or PDF of the latest car inspection report.\n\nMake sure the report includes the inspection date and pass status.';
    }
  }

  @override
  Widget build(BuildContext context) {
    final label = _getLabelForType(widget.documentType);
    final instructions = _getInstructionsForType(widget.documentType);
    final theme = Theme.of(context);
    final documentType = widget.documentType;
    return BlocConsumer<DocumentCubit, DocumentState>(
      listener: (context, state) {
        if (state is DocumentSuccess && state.message.isNotEmpty) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(state.message)),
          );
          widget.onNext(documentType, state.documents[documentType]!);
        } else if (state is DocumentFailure) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(state.error)),
          );
        }
      },
      builder: (context, state) {
        final file = state.documents[documentType];
        final isLoading = state is DocumentLoading;
        return Scaffold(
          backgroundColor: Colors.white,
          appBar: AppBar(
            backgroundColor: Colors.white,
            elevation: 0,
            iconTheme: const IconThemeData(color: Colors.black),
            title: Text(label, style: const TextStyle(color: Colors.black)),
          ),
          body: Padding(
            padding: EdgeInsets.symmetric(horizontal: 0.1.sw),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 0.09.sh),
                  _DocumentStepper(
                    totalSteps: DocumentType.values.length,
                    currentStep: DocumentType.values.indexOf(documentType),
                    theme: theme,
                  ),
                  SizedBox(height: 0.07.sh),
                  _DottedInstructionBox(text: instructions, theme: theme),
                  SizedBox(height: 0.05.sh),
                  CameraPreviewBox(
                    onTap: isLoading ? () {} : () { _pickImage(); },
                    imageProvider: _selectedFile != null
                        ? FileImage(_selectedFile!)
                        : (file != null ? FileImage(file) : const AssetImage(AssetsManager.camera)),
                  ),
                  SizedBox(height: 0.2.sh),
                  SizedBox(
                    width: double.infinity,
                    height: 0.07.sh,
                    child: ElevatedButton.icon(
                      icon: isLoading
                          ? const SizedBox(
                              width: 20,
                              height: 20,
                              child: CircularProgressIndicator(strokeWidth: 2, color: Colors.white),
                            )
                          : const Icon(Icons.upload, color: AppColors.white),
                      label: Text(
                        isLoading ? 'Uploading...' : 'Upload',
                        style: const TextStyle(
                          color: AppColors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      onPressed: (!isLoading && _selectedFile != null)
                          ? () => _uploadDocument(context)
                          : null,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.primary,
                      ),
                    ),
                  ),
                  SizedBox(height: 0.04.sh),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}

class _DocumentStepper extends StatelessWidget {
  final int totalSteps;
  final int currentStep;
  final ThemeData theme;
  const _DocumentStepper({required this.totalSteps, required this.currentStep, required this.theme});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: List.generate(totalSteps * 2 - 1, (index) {
          if (index.isEven) {
            int step = index ~/ 2;
            Color color;
            Color textColor;
            if (step <= currentStep) {
              color = theme.primaryColor;
              textColor = Colors.white;
            } else {
              color = Colors.grey[300]!;
              textColor = Colors.white;
            }
            return CircleAvatar(
              radius: 20,
              backgroundColor: color,
              child: Text(
                '${step + 1}',
                style: TextStyle(
                  color: textColor,
                  fontWeight: FontWeight.bold,
                ),
              ),
            );
          } else {
            // Dots between steps
            int leftStep = (index - 1) ~/ 2;
            Color dotColor = (leftStep < currentStep) ? theme.primaryColor : Colors.grey[300]!;
            return Row(
              children: List.generate(3, (i) => Padding(
                padding: const EdgeInsets.symmetric(horizontal: 2),
                child: Container(
                  width: 5,
                  height: 5,
                  decoration: BoxDecoration(
                    color: dotColor,
                    shape: BoxShape.circle,
                  ),
                ),
              )),
            );
          }
        }),
      ),
    );
  }
}

class _DottedInstructionBox extends StatelessWidget {
  final String text;
  final ThemeData theme;
  const _DottedInstructionBox({required this.text, required this.theme});

  @override
  Widget build(BuildContext context) {
    final instructions = text.split('\n').where((e) => e.trim().isNotEmpty).toList();
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.symmetric(vertical: 8),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: theme.primaryColor.withOpacity(0.06),
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
        border: Border.all(
          color: Colors.transparent,
          width: 0,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          // Top border (primary color)
          Container(
            width: double.infinity,
            height: 4,
            decoration: BoxDecoration(
              color: theme.primaryColor,
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(16),
                topRight: Radius.circular(16),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.fromLTRB(20, 24, 20, 20), // Extra top padding
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: instructions.map((line) => Padding(
                padding: const EdgeInsets.symmetric(vertical: 4),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      margin: const EdgeInsets.only(top: 7, right: 10),
                      width: 7,
                      height: 7,
                      decoration: BoxDecoration(
                        color: theme.primaryColor,
                        shape: BoxShape.circle,
                      ),
                    ),
                    Expanded(
                      child: Text(
                        line.trim(),
                        style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w500),
                      ),
                    ),
                  ],
                ),
              )).toList(),
            ),
          ),
        ],
      ),
    );
  }
}