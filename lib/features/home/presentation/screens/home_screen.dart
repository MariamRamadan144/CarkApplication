// import 'package:flutter/material.dart';
// import '../../core/reusable_widgets/showCars.dart';
// import '../../core/reusable_widgets/top_brands_widget.dart';
// import '../Filter/filter_screen.dart';
//
// class HomeScreen extends StatefulWidget {
//   @override
//   State<HomeScreen> createState() => _HomeScreenState();
// }
//
// class _HomeScreenState extends State<HomeScreen> {
//
//   int _selectedIndex = 0;
//
//   void _onItemTapped(int index) {
//     setState(() {
//       _selectedIndex = index;
//     });
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       bottomNavigationBar: BottomNavigationBar(
//         currentIndex: _selectedIndex,
//         onTap: _onItemTapped,
//         type: BottomNavigationBarType.fixed,
//         selectedItemColor: const Color(0xff120A53),
//         unselectedItemColor: Colors.grey,
//         items: const [
//           BottomNavigationBarItem(icon: Icon(Icons.home), label: 'HOME'),
//           BottomNavigationBarItem(icon: Icon(Icons.notification_add), label: 'NOTIFICATION'),
//           BottomNavigationBarItem(icon: Icon(Icons.person), label: 'PROFILE'),
//           BottomNavigationBarItem(icon: Icon(Icons.more_vert), label: ''),
//         ],
//       ),
//       body: SafeArea(
//         child: Padding(
//           padding: const EdgeInsets.all(16.0),
//           child: SingleChildScrollView(
//             physics: const BouncingScrollPhysics(),
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 const Row(
//                   // mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                   children: [
//                     Padding(
//                       padding: EdgeInsets.only(left: 20),
//                       child: Image(image: AssetImage("assets/images/home/carLogo.png"),),
//                     ),
//                     SizedBox(width: 150),
//                     Column(
//                       children: [
//                         Text("Location", style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500)),
//                         Row(
//                           children: [
//                             Icon(Icons.location_on, color: Colors.red),
//                             Text("Alex, Egypt") /// GET FROM DATABASE
//                           ],
//                         )
//                       ],
//                     ),
//                     SizedBox(width: 40),
//                   ],
//                 ),
//                 const SizedBox(height: 20),
//                 const Text("Rent a Car anytime", style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
//                 const SizedBox(height: 10),
//                 TextField(
//                   onTap: (){
//                     Navigator.push(
//                       context,
//                       MaterialPageRoute(
//                         builder: (context) =>  FilterScreen(),),
//                     );
//                   },
//                   decoration: InputDecoration(
//                     hintText: "Search any car...",
//                     prefixIcon: const Icon(Icons.search),
//                     suffixIcon: const Icon(Icons.filter_list),
//                     border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
//                   ),
//                 ),
//                 const SizedBox(height: 20),
//                 const Text("Top Brands", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
//                 const SizedBox(height: 10),
//                 const SingleChildScrollView(
//                   scrollDirection: Axis.horizontal,
//                   child: Row(
//                     children: [
//                       TopBrandsWidget(imagePath: 'assets/images/home/allBrand.png', name: 'All'),
//                       TopBrandsWidget(imagePath: 'assets/images/home/teslaBrand.png', name: 'Tesla',),
//                       TopBrandsWidget(imagePath: 'assets/images/home/BMW_Brand.png', name: 'BMW',),
//                       TopBrandsWidget( imagePath: 'assets/images/home/FerrariBrand.png', name: 'Ferrari',),
//                       TopBrandsWidget(imagePath: 'assets/images/home/AudiBrand.png', name: 'Audi',),
//                       // _brandIcon("Porsche"),
//                     ],
//                   ),
//                 ),
//                 const SizedBox(height: 20),
//                 const Cars(title: 'Top Rated Cars', imagePath: 'assets/images/home/car1(home).png',),
//                 const Cars(title: 'Most Popular Cars', imagePath: 'assets/images/home/car1(home).png',),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }
//
//
import 'package:flutter/material.dart';
import 'package:test_cark/core/utils/assets_manager.dart';
import '../../widgets/top_brands.dart';
import 'filter_screen.dart';

/// clean
class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        // type: BottomNavigationBarType.fixed,
        selectedItemColor: const Color(0xff120A53),
        unselectedItemColor: Colors.grey,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'HOME'),
          BottomNavigationBarItem(
              icon: Icon(Icons.notification_add), label: 'NOTIFICATION'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'PROFILE'),
          BottomNavigationBarItem(icon: Icon(Icons.more_vert), label: ''),
        ],
      ),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(screenWidth * 0.04),
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Padding(
                      padding: EdgeInsets.only(left: screenWidth * 0.05),
                      child: Image(
                        image:
                            const AssetImage(AssetsManager.carLogo),
                        // "assets/images/home/carLogo.png"
                        width: screenWidth * 0.15,
                      ),
                    ),
                    SizedBox(width: screenWidth * 0.3),
                    Column(
                      children: [
                        Text("Location",
                            style: TextStyle(
                                fontSize: screenWidth * 0.04,
                                fontWeight: FontWeight.w500)),
                        const Row(
                          children: [
                            Icon(Icons.location_on, color: Colors.red),
                            Text("Alex, Egypt") //
                          ],
                        )
                      ],
                    ),
                    SizedBox(width: screenWidth * 0.1),
                  ],
                ),
                SizedBox(height: screenHeight * 0.02),
                Text("Rent a Car anytime",
                    style: TextStyle(
                        fontSize: screenWidth * 0.06,
                        fontWeight: FontWeight.bold)),
                SizedBox(height: screenHeight * 0.015),
                TextField(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const FilterScreen()),
                    );
                  },
                  decoration: InputDecoration(
                    hintText: "Search any car...",
                    prefixIcon: const Icon(Icons.search),
                    suffixIcon: const Icon(Icons.filter_list),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10)),
                  ),
                ),
                SizedBox(height: screenHeight * 0.02),
                Text("Top Brands",
                    style: TextStyle(
                        fontSize: screenWidth * 0.05,
                        fontWeight: FontWeight.bold)),
                SizedBox(height: screenHeight * 0.015),
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
                SizedBox(height: screenHeight * 0.02),
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
