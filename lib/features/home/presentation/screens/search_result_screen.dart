import 'package:flutter/material.dart';

import '../../widgets/car_list_items.dart';



class SearchResultsScreen extends StatefulWidget {
  const SearchResultsScreen({super.key});


  @override
  _SearchResultsScreenState createState() => _SearchResultsScreenState();
}

class _SearchResultsScreenState extends State<SearchResultsScreen> {
  String? selectedCar;
  int _selectedIndex = 0; // Track the selected tab

  final List<Map<String, dynamic>> cars = [
    {
      'name': 'Toyota Yaris Cross',
      'image': 'assets/images/search/yaris_cross_hybrid_lrg.png',
      'seats': 4,
      'transmission': 'Automatic',
      'smallBags': 2,
      'largeBags': 1,
    },
    {
      'name': 'Toyota Corolla Cross',
      'image': 'assets/images/home/FerrariBrand.png',
      'seats': 5,
      'transmission': 'Automatic',
      'smallBags': 2,
      'largeBags': 1,
    },
    {
      'name': 'Toyota Fortuner',
      'image': 'assets/images/home/FerrariBrand.png',
      'seats': 7,
      'transmission': 'Automatic',
      'smallBags': 2,
      'largeBags': 3,
    },
  ];

  void _onNavBarTap(int index) {
    setState(() {
      _selectedIndex = index;
    });

    // Add navigation logic here (if needed)
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title:
        const Text('Search', style: TextStyle(fontWeight: FontWeight.bold)),
        backgroundColor: Colors.white,
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.black),
      ),
      body: Padding(
        padding: EdgeInsets.all(screenWidth * 0.04),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              decoration: InputDecoration(
                hintText: "Search for car",
                filled: true,
                fillColor: Colors.grey.shade200,
                prefixIcon: const Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
            SizedBox(height: screenHeight * 0.02),
            Expanded(
              child: ListView.builder(
                itemCount: cars.length,
                itemBuilder: (context, index) {
                  final car = cars[index];
                  return CarListItem(
                    carName: car['name'],
                    imagePath: car['image'],
                    seats: car['seats'],
                    transmission: car['transmission'],
                    smallBags: car['smallBags'].toString(),
                    largeBags: car['largeBags'].toString(),
                    isSelected: selectedCar == car['name'],
                    onTap: () {
                      setState(() {
                        selectedCar = car['name'];
                      });
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: _onNavBarTap,
        // selectedItemColor: const Color(0xff120A53).withOpacity(0.8),
        selectedItemColor: const Color(0xff120A53),

        // Highlighted icon color
        unselectedItemColor: Colors.grey,
        // Non-selected icon color
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'HOME'),
          BottomNavigationBarItem(icon: Icon(Icons.car_rental), label: 'NOTIFICATIONS'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
          BottomNavigationBarItem(icon: Icon(Icons.more_vert), label: ''),
        ],
      ),
    );
  }
}
