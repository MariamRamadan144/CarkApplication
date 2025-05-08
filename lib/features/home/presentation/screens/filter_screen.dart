import 'package:flutter/material.dart';
import '../../widgets/filter_options.dart';

/// clean
/// filter by ??
class FilterScreen extends StatefulWidget {
  const FilterScreen({super.key});

  @override
  _FilterScreenState createState() => _FilterScreenState();
}

class _FilterScreenState extends State<FilterScreen> {
  Map<String, bool> filters = {
    "Location": false,
    "Capacity": false,
    "Brand": false,
    "Price": false,
    "Model": false,
    "Car Type": false,
    "Availability": false,
  };

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: const Text(
          'Filter',
          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black),
        ),
        actions: [
          Padding(
            padding: EdgeInsets.only(right: screenWidth * 0.06),
            child: IconButton(
              icon: const Icon(Icons.camera_alt, size: 24, color: Colors.black),
              onPressed: () {},
            ),
          ),
        ],
      ),
      body: Padding(
        padding: EdgeInsets.all(screenWidth * 0.04),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Search Bar
            TextField(
              decoration: InputDecoration(
                hintText: "Search for car",
                prefixIcon: const Icon(Icons.search),
                filled: true,
                fillColor: Colors.grey.shade300,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
            SizedBox(height: screenHeight * 0.02),

            // Filter Options
            Expanded(
              child: ListView(
                children: filters.keys.map((filter) {
                  return Padding(
                    padding: EdgeInsets.only(bottom: screenHeight * 0.01),
                    child: FilterOption(
                      title: filter,
                      isSelected: filters[filter]!,
                      onTap: () {
                        setState(() {
                          filters[filter] = !filters[filter]!;
                        });
                      },
                    ),
                  );
                }).toList(),
              ),
            ),

            // Apply Button
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.indigo.shade900,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  padding: EdgeInsets.symmetric(vertical: screenHeight * 0.015),
                ),
                onPressed: () {
                  // Handle Apply button action
                },
                child: Text(
                  "Apply",
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: screenWidth * 0.045,
                      fontWeight: FontWeight.bold),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

