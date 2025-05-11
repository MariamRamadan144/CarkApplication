import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../../../../core/utils/text_manager.dart';

class BottomNavigationBarWidget extends StatefulWidget {
  BottomNavigationBarWidget({super.key, required this.selectedIndex});
  int selectedIndex;

  @override
  State<BottomNavigationBarWidget> createState() => _BottomNavigationBarWidgetState();
}

class _BottomNavigationBarWidgetState extends State<BottomNavigationBarWidget> {
  void _onItemTapped(int index) {
    setState(() {
      widget.selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      currentIndex: widget.selectedIndex,
      onTap: _onItemTapped,
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
