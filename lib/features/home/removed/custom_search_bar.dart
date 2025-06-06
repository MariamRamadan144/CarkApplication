import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:test_cark/config/routes/screens_name.dart';

import '../../../core/utils/text_manager.dart';

class CustomSearchBar extends StatelessWidget {
  const CustomSearchBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        // Search Bar
        Expanded(
          child: TextField(
            decoration: InputDecoration(
              hintText: TextManager.searchBarHint.tr(),

              prefixIcon: const Icon(Icons.search),

              // Navigation to filter screen
              suffixIcon: InkWell(
                onTap: () {
                  Navigator.pushNamed(context, ScreensName.filterScreen);
                },
                child: const Icon(Icons.filter_list, size: 28),
              ),

              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(50),
                borderSide: BorderSide.none,
              ),

              contentPadding: EdgeInsets.symmetric(vertical: 0.002.sh),
            ),
          ),
        ),
      ],
    );
  }
}
