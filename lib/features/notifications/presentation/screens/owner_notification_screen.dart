import 'package:flutter/material.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../cubits/notification_cubit.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class OwnerNotificationScreen extends StatelessWidget {
  final String currentUserId = '2';

  const OwnerNotificationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Owner Notifications')),
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collection('Notification')
            .where('type', isEqualTo: 'owner')
            .where('userId', isEqualTo: currentUserId)
            .orderBy('timestamp', descending: true)
            .snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const Center(child: CircularProgressIndicator());
          }
          final docs = snapshot.data!.docs;
          if (docs.isEmpty) {
            return const Center(child: Text('No notifications.'));
          }
          return ListView.builder(
            itemCount: docs.length,
            itemBuilder: (context, index) {
              final data = docs[index].data() as Map<String, dynamic>;
              return ListTile(
                title: Text(data['title'] ?? ''),
                subtitle: Text(data['body'] ?? ''),
                trailing: data['read'] == true
                    ? const Icon(Icons.check, color: Colors.green)
                    : const Icon(Icons.notifications, color: Colors.blue),
              );
            },
          );
        },
      ),
    );
  }
}

// class WithDriverView extends StatelessWidget {
//   const WithDriverView({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return BlocBuilder<NotificationCubit, NotificationState>(
//       builder: (context, state) {
//         if (state is NotificationLoading) {
//           return const Center(child: CircularProgressIndicator());
//         } else if (state is NotificationError) {
//           return Center(child: Text(state.message));
//         } else if (state is NotificationLoaded) {
//           if (state.notifications.isEmpty) {
//             return const Center(child: Text('No notifications.'));
//           }
//           return ListView(
//             padding: const EdgeInsets.all(16),
//             children: state.notifications
//                 .map((notification) => Card(
//                       elevation: 2,
//                       child: Padding(
//                         padding: const EdgeInsets.all(16),
//                         child: Column(
//                           crossAxisAlignment: CrossAxisAlignment.start,
//                           children: [
//                             Text(notification.title,
//                                 style: const TextStyle(
//                                     fontSize: 18, fontWeight: FontWeight.bold)),
//                             const SizedBox(height: 8),
//                             Text(notification.message),
//                             const SizedBox(height: 16),
//                             Row(
//                               mainAxisAlignment: MainAxisAlignment.end,
//                               children: [
//                                 TextButton(
//                                   onPressed: () {},
//                                   child: const Text('Cancel'),
//                                 ),
//                                 const SizedBox(width: 8),
//                                 ElevatedButton(
//                                   onPressed: () => context
//                                       .read<NotificationCubit>()
//                                       .markAsRead(notification.id),
//                                   child: const Text('Mark as Read',
//                                       style: TextStyle(color: Colors.white)),
//                                 ),
//                               ],
//                             )
//                           ],
//                         ),
//                       ),
//                     ))
//                 .toList(),
//           );
//         }
//         return const SizedBox.shrink();
//       },
//     );
//   }
// }
//
// class WithoutDriverView extends StatelessWidget {
//   const WithoutDriverView({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return BlocBuilder<NotificationCubit, NotificationState>(
//       builder: (context, state) {
//         if (state is NotificationLoading) {
//           return const Center(child: CircularProgressIndicator());
//         } else if (state is NotificationError) {
//           return Center(child: Text(state.message));
//         } else if (state is NotificationLoaded) {
//           if (state.notifications.isEmpty) {
//             return const Center(child: Text('No notifications.'));
//           }
//           return ListView(
//             padding: const EdgeInsets.all(16),
//             children: state.notifications
//                 .map((notification) => Card(
//                       elevation: 2,
//                       child: Padding(
//                         padding: const EdgeInsets.all(16),
//                         child: Column(
//                           crossAxisAlignment: CrossAxisAlignment.start,
//                           children: [
//                             Text(notification.title,
//                                 style: const TextStyle(
//                                     fontSize: 18, fontWeight: FontWeight.bold)),
//                             const SizedBox(height: 8),
//                             Text(notification.message),
//                             const SizedBox(height: 16),
//                             Row(
//                               mainAxisAlignment: MainAxisAlignment.end,
//                               children: [
//                                 ElevatedButton(
//                                   onPressed: () => context
//                                       .read<NotificationCubit>()
//                                       .markAsRead(notification.id),
//                                   child: const Text('Mark as Read',
//                                       style: TextStyle(color: Colors.white)),
//                                 ),
//                               ],
//                             )
//                           ],
//                         ),
//                       ),
//                     ))
//                 .toList(),
//           );
//         }
//         return const SizedBox.shrink();
//       },
//     );
//   }
// }
//
// // PDF Generation Logic
// Future<pw.Document> _generateContractPdf() async {
//   final pdf = pw.Document();
//   final font = await PdfGoogleFonts.latoRegular();
//   final boldFont = await PdfGoogleFonts.latoBold();
//
//   pdf.addPage(
//     pw.Page(
//       build: (pw.Context context) {
//         return pw.Column(
//           crossAxisAlignment: pw.CrossAxisAlignment.start,
//           children: [
//             pw.Header(
//               level: 0,
//               child: pw.Text('Car Rental Agreement (Without Driver)',
//                   style: pw.TextStyle(font: boldFont, fontSize: 24)),
//             ),
//             pw.Header(level: 2, child: pw.Text('📄 Agreement Details')),
//             _buildDetailRow('Rental Company:', '[Your Company Name]', font),
//             _buildDetailRow('Renter Name:', '__________________________', font),
//             _buildDetailRow(
//                 'Driver License Number:', '__________________________', font),
//             _buildDetailRow(
//                 'Phone Number:', '__________________________', font),
//             _buildDetailRow('Email:', '__________________________', font),
//             _buildDetailRow(
//                 'Rental Start Date:', '__________________________', font),
//             _buildDetailRow(
//                 'Rental End Date:', '__________________________', font),
//             _buildDetailRow(
//                 'Car Type / Model:', '__________________________', font),
//             _buildDetailRow(
//                 'Car Plate Number:', '__________________________', font),
//             _buildDetailRow(
//                 'Pickup Location:', '__________________________', font),
//             _buildDetailRow(
//                 'Return Location:', '__________________________', font),
//             pw.SizedBox(height: 20),
//             pw.Header(level: 2, child: pw.Text('💵 Payment Terms')),
//             _buildDetailRow('Rental Rate:', '\$______ / day', font),
//             _buildDetailRow('Total Rental Fee:', '\$______', font),
//             _buildDetailRow('Security Deposit:', '\$______ (refundable)', font),
//             _buildDetailRow(
//                 'Extra KM Charge:', '\$0.32 / km after 450 km/day', font),
//             _buildDetailRow('Fuel Policy:', 'Same-to-same', font),
//             pw.SizedBox(height: 20),
//             pw.Header(level: 2, child: pw.Text("✅ Renter's Responsibilities")),
//             pw.Paragraph(
//                 text:
//                     'Renter agrees to operate the vehicle without a driver provided by the company. Renter must:',
//                 style: pw.TextStyle(font: font)),
//             pw.Bullet(
//                 text: 'Hold a valid driving license for at least 2 years',
//                 style: pw.TextStyle(font: font)),
//             pw.Bullet(
//                 text: 'Obey all traffic laws', style: pw.TextStyle(font: font)),
//             pw.Bullet(
//                 text: 'Refrain from smoking in the car',
//                 style: pw.TextStyle(font: font)),
//             pw.Bullet(
//                 text: 'Return the car in the same condition as received',
//                 style: pw.TextStyle(font: font)),
//             pw.SizedBox(height: 20),
//             pw.Header(level: 2, child: pw.Text('🛡 Insurance & Waivers')),
//             pw.Bullet(
//                 text: '✔ Third Party Insurance included',
//                 style: pw.TextStyle(font: font)),
//             pw.Bullet(
//                 text: '✔ Collision Damage Waiver (CDW): up to \$800 liability',
//                 style: pw.TextStyle(font: font)),
//             pw.Bullet(
//                 text: '✔ Theft Protection: up to \$800 liability',
//                 style: pw.TextStyle(font: font)),
//             pw.Bullet(
//                 text: '❌ Renter is not covered for:',
//                 style: pw.TextStyle(font: font)),
//             pw.Padding(
//               padding: const pw.EdgeInsets.only(left: 20),
//               child: pw.Column(
//                   crossAxisAlignment: pw.CrossAxisAlignment.start,
//                   children: [
//                     pw.Bullet(
//                         text: 'Driving under the influence',
//                         style: pw.TextStyle(font: font)),
//                     pw.Bullet(
//                         text: 'Unauthorized driver usage',
//                         style: pw.TextStyle(font: font)),
//                     pw.Bullet(
//                         text: 'Damage to tires, glass, underbody',
//                         style: pw.TextStyle(font: font)),
//                   ]),
//             ),
//             pw.SizedBox(height: 20),
//             pw.Header(level: 2, child: pw.Text('⚠️ Penalties')),
//             _buildDetailRow('Late Return:', '\$___ / hour', font),
//             _buildDetailRow('Unauthorized driver:', 'Voids insurance', font),
//             _buildDetailRow('Damage beyond deductible:',
//                 'Renter bears the excess cost', font),
//             _buildDetailRow('Traffic fines:', 'Paid by renter', font),
//             pw.SizedBox(height: 20),
//             pw.Header(level: 2, child: pw.Text('🔄 Cancellation Policy')),
//             pw.Paragraph(
//                 text:
//                     'Free cancellation before pickup. Full refund if canceled at least 24 hours before pickup.',
//                 style: pw.TextStyle(font: font)),
//             pw.SizedBox(height: 40),
//             pw.Header(level: 2, child: pw.Text('✍️ Signatures')),
//             _buildSignatureLine('Renter Signature:'),
//             _buildSignatureLine('Company Representative Signature:'),
//           ],
//         );
//       },
//     ),
//   );
//
//   return pdf;
// }
//
// pw.Widget _buildDetailRow(String title, String value, pw.Font font) {
//   return pw.Padding(
//     padding: const pw.EdgeInsets.symmetric(vertical: 2),
//     child: pw.Row(
//       mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
//       children: [
//         pw.Text(title, style: pw.TextStyle(font: font)),
//         pw.Text(value, style: pw.TextStyle(font: font)),
//       ],
//     ),
//   );
// }
//
// pw.Widget _buildSignatureLine(String title) {
//   return pw.Column(crossAxisAlignment: pw.CrossAxisAlignment.start, children: [
//     pw.SizedBox(height: 20),
//     pw.Text(title),
//     pw.SizedBox(height: 5),
//     pw.Container(
//       width: 250,
//       child: pw.Divider(),
//     ),
//     pw.SizedBox(height: 5),
//     pw.Text('Date: ___________'),
//   ]);
// }
