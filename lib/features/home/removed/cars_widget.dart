// import 'package:flutter/material.dart';
// class CarsWidget extends StatelessWidget {
//   const CarsWidget({super.key, required this.title, required this.imagePath});
//   final String title;
//   final String imagePath;
//
//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         Row(
//           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//           children: [
//             Text(title, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
//             const Text("View All", style: TextStyle(color: Colors.grey)),
//           ],
//         ),
//         const SizedBox(height: 10),
//         SizedBox(
//           height: 200,
//           child: ListView.builder(
//             scrollDirection: Axis.horizontal,
//             itemCount: 3,
//             itemBuilder: (context, index) {
//               return Container(
//                 width: 200,
//                 margin: const EdgeInsets.only(right: 10),
//                 padding: const EdgeInsets.all(10),
//                 decoration: BoxDecoration(
//                   borderRadius: BorderRadius.circular(10),
//                   color: Colors.white,
//                   boxShadow: [BoxShadow(color: Colors.grey.withOpacity(0.3), blurRadius: 5)],
//                 ),
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     Container(
//                       height: 80,
//                       decoration: BoxDecoration(
//                         borderRadius: BorderRadius.circular(10),
//                         image: DecorationImage(
//                           image: AssetImage(imagePath),
//                           fit: BoxFit.cover,
//                         ),
//                       ),
//                     ),
//                     const SizedBox(height: 8),
//                     const Text("Car Model Name", style: TextStyle(fontWeight: FontWeight.bold)),
//                     const Row(
//                       children: [
//                         Icon(Icons.star, color: Colors.amber, size: 16),
//                         Text(" 5.0 "),
//                         Text(" | 7 Trips", style: TextStyle(color: Colors.grey)),
//                       ],
//                     ),
//                     const SizedBox(height: 5),
//                     const Text("Available from 2 August", style: TextStyle(color: Colors.green, fontSize: 12)),
//                     const SizedBox(height: 5),
//                     const Text("4 Seats | EGP 100.00/hour", style: TextStyle(fontSize: 12)),
//                   ],
//                 ),
//               );
//             },
//           ),
//         ),
//       ],
//     )
//     ;
//   }
// }
