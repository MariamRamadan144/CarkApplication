import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../auth/presentation/cubits/auth_cubit.dart';
import '../../../auth/presentation/screens/profile/profile_screen.dart';
import '../../../cars/presentation/screens/add_car_screen.dart';
import '../../../cars/presentation/screens/view_cars_screen.dart';
import '../../../../config/routes/screens_name.dart';
import '../../../../core/utils/assets_manager.dart';
import '../widgets/owner_drawer.dart';

class OwnerHomeScreen extends StatelessWidget {
  const OwnerHomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('My Cars'),
        actions: [
          // Notification icon
          Stack(
            children: [
              IconButton(
                icon: const Icon(Icons.notifications),
                onPressed: () {
                  Navigator.pushNamed(context, ScreensName.ownerNotificationScreen);
                },
              ),
              // Notification badge
              Positioned(
                right: 8,
                top: 8,
                child: Container(
                  padding: const EdgeInsets.all(2),
                  decoration: BoxDecoration(
                    color: Colors.red,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  constraints: const BoxConstraints(
                    minWidth: 16,
                    minHeight: 16,
                  ),
                  child: const Text(
                    '0', // TODO: Replace with real unread count
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 10,
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
      drawer: const OwnerDrawer(),
      body: const ViewCarsScreen(),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushNamed(context, ScreensName.addCarScreen);
        },
        backgroundColor: Theme.of(context).primaryColor,
        child: const Icon(Icons.add, color: Colors.white),
      ),
    );
  }
} 