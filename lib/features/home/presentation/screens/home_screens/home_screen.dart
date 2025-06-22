import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:test_cark/config/routes/screens_name.dart';
import 'package:test_cark/core/utils/assets_manager.dart';
import '../../widgets/home_widgets/brand_section_widget.dart';
import '../../widgets/home_widgets/filter_section_widget.dart';
import '../../widgets/home_widgets/view_cars_section_widget.dart';
import '../../../removed/custom_search_bar.dart';
import '../../widgets/rental_widgets/filter_button.dart';
import '../../widgets/rental_widgets/rental_summary_card.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(0.04.sw),
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Cark Logo - Now clickable
                GestureDetector(
                  onTap: () {
                    Navigator.pushNamed(context, ScreensName.rentalSearchScreen);
                  },
                  child: Image(
                    image: const AssetImage(AssetsManager.carLogo),
                    width: 0.15.sw,
                  ),
                ),
                SizedBox(height: 0.02.sh),

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

