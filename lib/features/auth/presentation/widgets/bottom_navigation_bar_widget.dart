import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../../../../core/utils/text_manager.dart';

class BottomNavigationBarWidget extends StatelessWidget {
  BottomNavigationBarWidget({super.key, required this.selectedIndex, required this.onTap});
  int selectedIndex;
  final void Function(int) onTap;

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      currentIndex: selectedIndex,
      onTap: onTap,
      selectedItemColor: Theme.of(context).colorScheme.primary,
      unselectedItemColor: Colors.grey,
      items: [
        BottomNavigationBarItem(
            icon: const Icon(Icons.home), label: TextManager.home.tr()),
        BottomNavigationBarItem(
            icon: const Icon(Icons.notification_add),
            label: TextManager.notification.tr()),
        BottomNavigationBarItem(
            icon: const Icon(Icons.person), label: TextManager.profile.tr()),
        BottomNavigationBarItem(
            icon: const Icon(Icons.more_vert), label: TextManager.more.tr()),
      ],
    );
  }
}
