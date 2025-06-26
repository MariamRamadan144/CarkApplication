import 'package:flutter/material.dart';
import 'package:test_cark/features/cars/presentation/screens/add_car_screen.dart';
import 'owner_home_screen.dart';
import 'owner_profile_screen.dart';
import 'package:test_cark/features/notifications/presentation/screens/owner_notification_screen.dart'
    as notif;

class OwnerNavigationScreen extends StatefulWidget {
  const OwnerNavigationScreen({Key? key}) : super(key: key);

  @override
  State<OwnerNavigationScreen> createState() => _OwnerNavigationScreenState();
}

class _OwnerNavigationScreenState extends State<OwnerNavigationScreen> {
  int _currentIndex = 0;
  int _refreshKey = 0;

  final List<Widget> _screens = [
    const OwnerHomeScreen(),
    Container(), // Placeholder for Notification
    const OwnerProfileScreen(),
  ];

  void _onTabTapped(int index) async {
    if (index == 1) {
      // Notification tab: push to notification screen
      await Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => const notif.OwnerNotificationScreen()),
      );
      // Stay on the current tab (Home)
      setState(() {
        _currentIndex = 0;
      });
    } else {
      setState(() {
        _currentIndex = index;
      });
    }
  }

  void _navigateToAddCar() async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const AddCarScreen()),
    );
    if (result == true) {
      setState(() {
        _currentIndex = 0;
        _refreshKey++;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: _currentIndex,
        children: [
          OwnerHomeScreen(key: ValueKey(_refreshKey)),
          Container(),
          const OwnerProfileScreen(),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: _onTabTapped,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(
              icon: Icon(Icons.notifications), label: 'Notification'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
        ],
      ),
    );
  }
}
