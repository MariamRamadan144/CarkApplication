import 'package:flutter/material.dart';

class TopBrandsWidget extends StatelessWidget {
  const TopBrandsWidget({super.key, required this.imagePath, required this.name});
  final String imagePath;
  final String name;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: Column(
        children: [
          CircleAvatar(radius: 30, backgroundImage: AssetImage(imagePath)),
          const SizedBox(height: 5),
          Text(name)
        ],
      ),
    );
  }
}


