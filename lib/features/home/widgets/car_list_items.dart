import 'package:flutter/material.dart';

class CarListItem extends StatelessWidget {
  const CarListItem({
    super.key,
    required this.carName,
    required this.imagePath,
    required this.seats,
    required this.transmission,
    required this.smallBags,
    required this.largeBags,
    required this.isSelected,
    required this.onTap,
  });
  final String carName;
  final String imagePath;
  final int seats;
  final String transmission;
  final String smallBags;
  final String largeBags;
  final bool isSelected;
  final VoidCallback onTap;


  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 8),
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: isSelected ? Theme.of(context).colorScheme.primary.withOpacity(0.5): Theme.of(context).colorScheme.onPrimary,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(
            color: isSelected ? Theme.of(context).colorScheme.primary.withOpacity(0.5) : Theme.of(context).colorScheme.secondary,
            width: isSelected ? 2 : 1,
          ),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Car Image
            Image.asset(
              imagePath,
              width: 80,
              height: 50,
              fit: BoxFit.cover,
            ),
            const SizedBox(width: 10),

            // Car Details (Wrap in Expanded to prevent overflow)
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    carName,
                    style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 4),

                  // Car Info Row (Seats, Transmission, Bags)
                  Row(
                    children: [
                      const Icon(Icons.event_seat, size: 14, color: Colors.grey),
                      const SizedBox(width: 4),
                      Text('$seats seats', style: const TextStyle(fontSize: 12)),
                      const SizedBox(width: 10),

                      const Icon(Icons.settings, size: 14, color: Colors.grey),
                      const SizedBox(width: 4),
                      Text(transmission, style: const TextStyle(fontSize: 12)),
                    ],
                  ),

                  const SizedBox(height: 4),

                  Row(
                    children: [
                      const Icon(Icons.work, size: 14, color: Colors.grey),
                      const SizedBox(width: 4),
                      Text('$smallBags Small Bag', style: const TextStyle(fontSize: 12)),

                      const SizedBox(width: 10),

                      const Icon(Icons.luggage, size: 14, color: Colors.grey),
                      const SizedBox(width: 4),
                      Text('$largeBags Large Bag', style: const TextStyle(fontSize: 12)),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
