import 'dart:io';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:test_cark/core/utils/assets_manager.dart';
import '../../../../../config/themes/app_colors.dart';
import '../../../../../core/utils/text_manager.dart';
import '../../../../home/widgets/camera_preview_box.dart';
import '../../widgets/instruction_text.dart';


class UploadIdScreen extends StatefulWidget {
  const UploadIdScreen({super.key});

  @override
  State<UploadIdScreen> createState() => _UploadIdScreenState();
}

class _UploadIdScreenState extends State<UploadIdScreen> {
  File? _selectedImage;

  Future<void> _pickImage() async {
    final picker = ImagePicker();
    final picked = await picker.pickImage(source: ImageSource.camera);
    if (picked != null) {
      setState(() {
        _selectedImage = File(picked.path);
      });
    }
  }

  void _uploadImage() {
    if (_selectedImage != null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(TextManager.image_uploaded_successfully.tr())),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(TextManager.please_take_photo_first.tr())),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.sizeOf(context).width;
    final screenHeight = MediaQuery.sizeOf(context).height;
    final theme = Theme.of(context);
    return Scaffold(
      backgroundColor: theme.colorScheme.surface,
      appBar: AppBar(
        // centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.black),
        flexibleSpace: SafeArea(
          child: Row(
            children: [
              IconButton(
                icon: const Icon(Icons.arrow_back),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
              Text(
                TextManager.upload_your_id.tr(),
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                  color: Colors.black,
                ),
              ),
            ],
          ),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.08),
        child: SingleChildScrollView(
          child: Baseline(
            baseline: screenHeight * 0.02,
            baselineType: TextBaseline.alphabetic,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: screenHeight * 0.02),
                InstructionText(
                  text: TextManager.instruction_place_id.tr(),
                ),
                InstructionText(
                  text: TextManager.instruction_position_id.tr(),
                ),
                InstructionText(
                  text: TextManager.instruction_clear_details.tr(),
                ),
                SizedBox(height: screenHeight * 0.05),
                CameraPreviewBox(
                  onTap: _pickImage,
                  imageProvider: _selectedImage != null
                      ? FileImage(
                          _selectedImage!) // "assets/images/uploads/camera.png"
                      : const AssetImage(AssetsManager.camera),
                ),
                SizedBox(height: screenHeight * 0.2),
                SizedBox(
                  width: double.infinity,
                  height: screenHeight * 0.07,
                  child: ElevatedButton.icon(
                    icon: const Icon(Icons.upload, color: AppColors.white),
                    label: Text(
                      TextManager.upload_photo.tr(),
                      style: const TextStyle(
                        color: AppColors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    onPressed: _uploadImage,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.primary,
                    ),
                  ),
                ),
                SizedBox(height: screenHeight * 0.04),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
