import 'dart:typed_data';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';
import 'package:test_cark/config/themes/app_colors.dart';

class OwnerNotificationScreen extends StatelessWidget {
  const OwnerNotificationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Owner Notifications'),
          bottom: const TabBar(
            tabs: [
              Tab(text: 'With Driver'),
              Tab(text: 'Without Driver'),
            ],
          ),
        ),
        body: const TabBarView(
          children: [
            WithDriverView(),
            WithoutDriverView(),
          ],
        ),
      ),
    );
  }
}

class WithDriverView extends StatelessWidget {
  const WithDriverView({super.key});

  @override
  Widget build(BuildContext context) {
    // Replace with actual data model and list builder
    return ListView(
      padding: EdgeInsets.all(16.r),
      children: [
        Card(
          elevation: 2,
          child: Padding(
            padding: EdgeInsets.all(16.r),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('New Booking Request',
                    style:
                        TextStyle(fontSize: 18.sp, fontWeight: FontWeight.bold)),
                SizedBox(height: 8.h),
                const Text('Car: Honda Accord'),
                const Text('Renter: John Doe'),
                const Text('Duration: 3 Days'),
                SizedBox(height: 16.h),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    TextButton(
                      onPressed: () {},
                      child: const Text('Cancel'),
                    ),
                    SizedBox(width: 8.w),
                    ElevatedButton(
                      onPressed: () {},
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.primary,
                      ),
                      child: const Text('Confirm',
                          style: TextStyle(color: Colors.white)),
                    ),
                  ],
                )
              ],
            ),
          ),
        )
      ],
    );
  }
}

class WithoutDriverView extends StatelessWidget {
  const WithoutDriverView({super.key});

  Future<void> _generateAndShowPdf(BuildContext context) async {
    final pdf = await _generateContractPdf();
    await Printing.layoutPdf(
      onLayout: (PdfPageFormat format) async => pdf.save(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: Theme.of(context).colorScheme.primary, // or your preferred color
        ),
        onPressed: () => _generateAndShowPdf(context),
        child: const Text(
          'Generate Contract PDF',
          style: TextStyle(color: Colors.white),
        ),
      ),
    );
  }
}

// PDF Generation Logic
Future<pw.Document> _generateContractPdf() async {
  final pdf = pw.Document();
  final font = await PdfGoogleFonts.latoRegular();
  final boldFont = await PdfGoogleFonts.latoBold();

  pdf.addPage(
    pw.Page(
      build: (pw.Context context) {
        return pw.Column(
          crossAxisAlignment: pw.CrossAxisAlignment.start,
          children: [
            pw.Header(
              level: 0,
              child: pw.Text('Car Rental Agreement (Without Driver)',
                  style: pw.TextStyle(font: boldFont, fontSize: 24)),
            ),
            pw.Header(
                level: 2, child: pw.Text('📄 Agreement Details')),
            _buildDetailRow('Rental Company:', '[Your Company Name]', font),
            _buildDetailRow('Renter Name:', '__________________________', font),
            _buildDetailRow(
                'Driver License Number:', '__________________________', font),
            _buildDetailRow('Phone Number:', '__________________________', font),
            _buildDetailRow('Email:', '__________________________', font),
            _buildDetailRow(
                'Rental Start Date:', '__________________________', font),
            _buildDetailRow(
                'Rental End Date:', '__________________________', font),
            _buildDetailRow(
                'Car Type / Model:', '__________________________', font),
            _buildDetailRow(
                'Car Plate Number:', '__________________________', font),
            _buildDetailRow(
                'Pickup Location:', '__________________________', font),
            _buildDetailRow(
                'Return Location:', '__________________________', font),
            pw.SizedBox(height: 20),
            pw.Header(level: 2, child: pw.Text('💵 Payment Terms')),
            _buildDetailRow('Rental Rate:', '\$______ / day', font),
            _buildDetailRow('Total Rental Fee:', '\$______', font),
            _buildDetailRow('Security Deposit:', '\$______ (refundable)', font),
            _buildDetailRow('Extra KM Charge:', '\$0.32 / km after 450 km/day', font),
            _buildDetailRow('Fuel Policy:', 'Same-to-same', font),
            pw.SizedBox(height: 20),
            pw.Header(level: 2, child: pw.Text("✅ Renter's Responsibilities")),
            pw.Paragraph(
                text:
                    'Renter agrees to operate the vehicle without a driver provided by the company. Renter must:',
                style: pw.TextStyle(font: font)),
            pw.Bullet(
                text: 'Hold a valid driving license for at least 2 years',
                style: pw.TextStyle(font: font)),
            pw.Bullet(text: 'Obey all traffic laws', style: pw.TextStyle(font: font)),
            pw.Bullet(
                text: 'Refrain from smoking in the car', style: pw.TextStyle(font: font)),
            pw.Bullet(
                text: 'Return the car in the same condition as received',
                style: pw.TextStyle(font: font)),
            pw.SizedBox(height: 20),
            pw.Header(level: 2, child: pw.Text('🛡 Insurance & Waivers')),
            pw.Bullet(
                text: '✔ Third Party Insurance included',
                style: pw.TextStyle(font: font)),
            pw.Bullet(
                text: '✔ Collision Damage Waiver (CDW): up to \$800 liability',
                style: pw.TextStyle(font: font)),
            pw.Bullet(
                text: '✔ Theft Protection: up to \$800 liability',
                style: pw.TextStyle(font: font)),
            pw.Bullet(
                text: '❌ Renter is not covered for:', style: pw.TextStyle(font: font)),
            pw.Padding(
              padding: const pw.EdgeInsets.only(left: 20),
              child: pw.Column(
                  crossAxisAlignment: pw.CrossAxisAlignment.start,
                  children: [
                    pw.Bullet(
                        text: 'Driving under the influence',
                        style: pw.TextStyle(font: font)),
                    pw.Bullet(
                        text: 'Unauthorized driver usage',
                        style: pw.TextStyle(font: font)),
                    pw.Bullet(
                        text: 'Damage to tires, glass, underbody',
                        style: pw.TextStyle(font: font)),
                  ]),
            ),
            pw.SizedBox(height: 20),
            pw.Header(level: 2, child: pw.Text('⚠️ Penalties')),
            _buildDetailRow('Late Return:', '\$___ / hour', font),
            _buildDetailRow('Unauthorized driver:', 'Voids insurance', font),
            _buildDetailRow(
                'Damage beyond deductible:', 'Renter bears the excess cost', font),
            _buildDetailRow('Traffic fines:', 'Paid by renter', font),
            pw.SizedBox(height: 20),
            pw.Header(level: 2, child: pw.Text('🔄 Cancellation Policy')),
            pw.Paragraph(
                text:
                    'Free cancellation before pickup. Full refund if canceled at least 24 hours before pickup.',
                style: pw.TextStyle(font: font)),
            pw.SizedBox(height: 40),
            pw.Header(level: 2, child: pw.Text('✍️ Signatures')),
            _buildSignatureLine('Renter Signature:'),
            _buildSignatureLine('Company Representative Signature:'),
          ],
        );
      },
    ),
  );

  return pdf;
}

pw.Widget _buildDetailRow(String title, String value, pw.Font font) {
  return pw.Padding(
    padding: const pw.EdgeInsets.symmetric(vertical: 2),
    child: pw.Row(
      mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
      children: [
        pw.Text(title, style: pw.TextStyle(font: font)),
        pw.Text(value, style: pw.TextStyle(font: font)),
      ],
    ),
  );
}

pw.Widget _buildSignatureLine(String title) {
  return pw.Column(
      crossAxisAlignment: pw.CrossAxisAlignment.start,
      children: [
        pw.SizedBox(height: 20),
        pw.Text(title),
        pw.SizedBox(height: 5),
        pw.Container(
          width: 250,
          child: pw.Divider(),
        ),
        pw.SizedBox(height: 5),
        pw.Text('Date: ___________'),
      ]);
} 