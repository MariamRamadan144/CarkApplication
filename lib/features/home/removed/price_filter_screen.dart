import 'package:flutter/material.dart';

import 'package:flutter/material.dart';

class PriceFilterScreen extends StatefulWidget {
  const PriceFilterScreen({Key? key}) : super(key: key);

  @override
  _PriceFilterScreenState createState() => _PriceFilterScreenState();
}

class _PriceFilterScreenState extends State<PriceFilterScreen> {
  // نحدد الحد الأدنى والأقصى لسعر الفلترة (تقدر تعدلهم حسب مشروعك)
  RangeValues selectedRange = const RangeValues(0, 1000);

  // يمكن تعريف حدود السلايدر (min, max)
  final double minPrice = 0;
  final double maxPrice = 1000;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Select Price Range'),
        actions: [
          IconButton(
            icon: const Icon(Icons.check),
            onPressed: () {
              // هنا نرجع selectedRange إلى الشاشة اللي قبلها
              Navigator.pop(context, selectedRange);
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Text(
              'Price Range: \$${selectedRange.start.round()} - \$${selectedRange.end.round()}',
              style: const TextStyle(fontSize: 18),
            ),
            const SizedBox(height: 20),
            RangeSlider(
              values: selectedRange,
              min: minPrice,
              max: maxPrice,
              divisions: 20, // تقدر تعدل التقسيمات حسب الحاجة
              labels: RangeLabels(
                '\$${selectedRange.start.round()}',
                '\$${selectedRange.end.round()}',
              ),
              onChanged: (RangeValues newRange) {
                setState(() {
                  selectedRange = newRange;
                });
              },
            ),
          ],
        ),
      ),
    );
  }
}

