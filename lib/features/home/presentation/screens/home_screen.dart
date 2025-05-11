import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:test_cark/core/utils/assets_manager.dart';
import 'package:test_cark/core/utils/text_manager.dart';
import '../../../../config/routes/screens_name.dart';
import '../../../auth/presentation/widgets/bottom_navigation_bar_widget.dart';
import '../../widgets/top_brands.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Bottom Navigation Bar
      bottomNavigationBar: BottomNavigationBarWidget(selectedIndex: _selectedIndex,),

      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(0.04.sw),
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Cark Logo
                Image(
                  image: const AssetImage(AssetsManager.carLogo),
                  width: 0.15.sw,
                ),

                SizedBox(height: 0.02.sh),

                // Rent a Car anytime
                // Text(TextManager.rentCarText.tr(),
                //     style: TextStyle(
                //         fontSize: 0.02.sh, fontWeight: FontWeight.bold)),

                // SizedBox(height: 0.015.sh),

                // Search Bar
                TextField(
                  onTap: () {
                    Navigator.pushNamed(context, ScreensName.filterScreen);
                  },
                  decoration: InputDecoration(
                    hintText: TextManager.searchBarHint.tr(),
                    prefixIcon: const Icon(Icons.search),
                    suffixIcon: const Icon(Icons.filter_list),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10)),
                  ),
                ),

                SizedBox(height: 0.02.sh),

                // Top Brands
                Text("Top Brands",
                    style: TextStyle(
                        fontSize: 0.05.sp, fontWeight: FontWeight.bold)),

                SizedBox(height: 0.015.sh),

                // From The Database
                const SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    /// from the database
                    children: [
                      TopBrandsWidget(
                          imagePath: AssetsManager.allBrand,
                          // assets/images/home/allBrand.png
                          name: 'All'),
                    ],
                  ),
                ),

                SizedBox(height: 0.02.sh),
                // const Cars(
                //     title: 'Top Rated Cars',
                //     imagePath: 'assets/images/home/car1(home).png'),
                // const Cars(
                //     title: 'Most Popular Cars',
                //     imagePath: 'assets/images/home/car1(home).png'),
              ],
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
