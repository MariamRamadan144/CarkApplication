import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:test_cark/core/utils/assets_manager.dart';
import '../../../../../config/routes/screens_name.dart';
import '../../../../auth/presentation/screens/profile/profile_screen.dart';
import '../../../../cars/presentation/screens/add_car_screen.dart';
import '../../../../cars/presentation/screens/view_cars_screen.dart';
import '../../widgets/home_widgets/brand_section_widget.dart';
import '../../widgets/home_widgets/view_cars_section_widget.dart';
import '../../widgets/rental_widgets/filter_button.dart';
import '../../widgets/rental_widgets/rental_summary_card.dart';
import '../booking_screens/payment_screen.dart';
import '../booking_screens/rental_search_screen.dart';
import 'contact_help_screen.dart';
import 'feedback_screen.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../auth/presentation/cubits/auth_cubit.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  void _navigateAndCloseDrawer(BuildContext context, Widget screen) {
    Navigator.pop(context); // Close the drawer
    Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => screen),
    );
  }

  void _logout(BuildContext context) {
    final authCubit = context.read<AuthCubit>();
    // Clear user session
    authCubit.userModel = null;
    Navigator.pop(context); // Close drawer
    Navigator.pushReplacementNamed(context, ScreensName.login);
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Logged out successfully')),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          leading: Builder(
            builder: (context) => IconButton(
              icon: const Icon(Icons.menu),
              onPressed: () => Scaffold.of(context).openDrawer(),
            ),
          ),
          actions: [
            // Notification icon with badge (placeholder for unread count)
            Stack(
              children: [
                IconButton(
                  icon: const Icon(Icons.notifications),
                  onPressed: () {
                    Navigator.pushNamed(context, ScreensName.ownerNotificationScreen);
                  },
                ),
                // Example badge (replace with real unread count logic)
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
                      '0', // Replace with unread count
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
        drawer: BlocBuilder<AuthCubit, AuthState>(
          builder: (context, state) {
            final authCubit = context.read<AuthCubit>();
            final user = authCubit.userModel;
            return Drawer(
              child: ListView(
                padding: EdgeInsets.zero,
                children: [
                  DrawerHeader(
                    decoration: BoxDecoration(
                      color: Theme.of(context).primaryColor,
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image(
                          image: const AssetImage(AssetsManager.carLogo),
                          width: 0.15.sw,
                        ),
                        SizedBox(height: 0.01.sh),
                        if (user != null)
                          Text(
                            '${user.firstName} ${user.lastName}',
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        if (user != null)
                          Text(
                            'Renter',
                            style: const TextStyle(
                              color: Colors.white70,
                              fontSize: 14,
                            ),
                          ),
                      ],
                    ),
                  ),
                  ListTile(
                    leading: const Icon(Icons.home),
                    title: const Text('Home'),
                    onTap: () => Navigator.pop(context),
                  ),
                  ListTile(
                    leading: const Icon(Icons.person),
                    title: const Text('Profile'),
                    onTap: () =>
                        _navigateAndCloseDrawer(context, const ProfileScreen()),
                  ),
                  const Divider(),
                  // Switch to Owner
                  ListTile(
                    leading: const Icon(Icons.directions_car),
                    title: const Text('Switch to Owner'),
                    onTap: () {
                      final authCubit = context.read<AuthCubit>();
                      authCubit.toggleRole();
                      Navigator.pop(context); // Close drawer
                      Navigator.pushReplacementNamed(context, ScreensName.ownerHomeScreen);
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Switched to Owner mode')),
                      );
                    },
                  ),
                  ListTile(
                    leading: const Icon(Icons.history),
                    title: const Text('Booking History'),
                    onTap: () => _navigateAndCloseDrawer(
                        context, BookingHistoryScreen()),
                  ),
                  ListTile(
                    leading: const Icon(Icons.credit_card),
                    title: const Text('Payment Methods'),
                    onTap: () => _navigateAndCloseDrawer(
                        context, PaymentMethodsScreen()),
                  ),
                  ListTile(
                    leading: const Icon(Icons.contact_support),
                    title: const Text('Contact & Help'),
                    onTap: () =>
                        _navigateAndCloseDrawer(context, ContactHelpScreen()),
                  ),
                  ListTile(
                    leading: const Icon(Icons.feedback),
                    title: const Text('Feedback'),
                    onTap: () =>
                        _navigateAndCloseDrawer(context, FeedbackScreen()),
                  ),
                  const Divider(),
                  ListTile(
                    leading: const Icon(Icons.logout),
                    title: const Text('Logout'),
                    onTap: () => _logout(context),
                  ),
                ],
              ),
            );
          },
        ),
        body: SafeArea(
          child: Padding(
            padding: EdgeInsets.all(0.03.sw),
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // SizedBox(height: 0.02.sh),

                  // Search Bar
                  // const CustomSearchBar(),
                  const RentalSummaryCard(),
                  SizedBox(height: 0.02.sh),

                  // Filter Button
                  const FilterButton(),
                  SizedBox(height: 0.02.sh),

                  // All brands in general
                  const BrandSectionWidget(),

                  // View Cars Section
                  ViewCarsSectionWidget(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

/// removed from ui:
//Column(
//                       children: [
//                         Text("Location",
//                             style: TextStyle(
//                                 fontSize: 0.04.sw,
//                                 fontWeight: FontWeight.w500)),
//                         const Row(
//                           children: [
//                             Icon(Icons.location_on, color: Colors.red),
//                             Text("Alex, Egypt") //
//                           ],
//                         )
//                       ],
//                     ),
/// car section
// const Cars(
//     title: 'Top Rated Cars',
//     imagePath: 'assets/images/home/car1(home).png'),
// const Cars(
//     title: 'Most Popular Cars',
//     imagePath: 'assets/images/home/car1(home).png'),
/// Rent a Car anytime text
// Text(TextManager.rentCarText.tr(),
//     style: TextStyle(
//         fontSize: 0.02.sh, fontWeight: FontWeight.bold),),
// SizedBox(height: 0.02.sh),
