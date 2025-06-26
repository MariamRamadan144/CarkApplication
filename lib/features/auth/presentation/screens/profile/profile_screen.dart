import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:test_cark/core/utils/text_manager.dart';
import '../../../../../config/themes/app_colors.dart';
import '../../widgets/profile_custom_widgets/editable_info.dart';
import '../../widgets/profile_custom_widgets/profile_header.dart';
import '../../widgets/profile_custom_widgets/profile_picture.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const ProfileHeader(),
      
              SizedBox(height: 0.02.sh),
      
              // Profile Picture
              const ProfilePicture(),
      
              SizedBox(height: 0.02.sh),
      
              // User Information
              Expanded(
                child: ListView(
                  children: const [
                    EditableInfo(title: TextManager.nameHint, value: "Mariam"),
                    EditableInfo(title: TextManager.emailHint, value: "mariam@gmail.com"),
                    EditableInfo(title: TextManager.phoneHint, value: "01029587445"),
                    EditableInfo(title: TextManager.nationalIdHint, value: "30301442875268"),
                  ],
                ),
              ),
      
              Center(
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.pushNamed(context, "");
                  },
                  child: Text(
                    TextManager.edit.tr(),
                    style: const TextStyle(color: AppColors.white),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
