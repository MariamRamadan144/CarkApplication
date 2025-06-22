import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:test_cark/config/themes/app_colors.dart';

enum NotificationType { requestSent, confirmed, cancelled }

class RenterNotificationScreen extends StatelessWidget {
  const RenterNotificationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Mock data
    final List<Map<String, dynamic>> notifications = [
      {'type': NotificationType.requestSent, 'carName': 'Toyota Camry'},
      {'type': NotificationType.confirmed, 'carName': 'BMW X5'},
      {'type': NotificationType.cancelled, 'carName': 'Ford Focus'},
    ];

    return Scaffold(
      appBar: AppBar(
        title: Text(tr('renter_notification')),
        automaticallyImplyLeading: false,
      ),
      body: notifications.isEmpty
          ? Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.notifications_off_outlined,
                      size: 80.sp, color: Colors.grey.shade400),
                  SizedBox(height: 20.h),
                  Text(tr('no_notifications'),
                      style: TextStyle(
                          fontSize: 22.sp,
                          fontWeight: FontWeight.bold,
                          color: Colors.grey.shade700)),
                  SizedBox(height: 8.h),
                  Text(tr('no_notifications_yet'),
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontSize: 16.sp, color: Colors.grey.shade500)),
                ],
              ),
            )
          : ListView.separated(
              padding: EdgeInsets.symmetric(vertical: 16.h),
              itemCount: notifications.length,
              separatorBuilder: (context, index) =>
                  Divider(height: 1.h, indent: 16.w, endIndent: 16.w),
              itemBuilder: (context, index) {
                final notification = notifications[index];
                return _buildNotificationTile(
                    notification['type'], notification['carName']);
              },
            ),
    );
  }

  Widget _buildNotificationTile(NotificationType type, String carName) {
    IconData icon;
    Color color;
    String title;
    String subtitle;

    switch (type) {
      case NotificationType.requestSent:
        icon = Icons.hourglass_top_outlined;
        color = Colors.blue.shade700;
        title = tr('request_sent');
        subtitle =
            "${tr('your_booking_request_for')} $carName ${tr('has_been_sent')}\n${tr('awaiting_owner_response')}";
        break;
      case NotificationType.confirmed:
        icon = Icons.check_circle_outline;
        color = Colors.green.shade700;
        title = tr('booking_confirmed');
        subtitle =
            "${tr('your_booking_for')} $carName ${tr('is_confirmed')}";
        break;
      case NotificationType.cancelled:
        icon = Icons.cancel_outlined;
        color = Colors.red.shade700;
        title = tr('booking_cancelled');
        subtitle =
            "${tr('your_booking_for_cancelled')} $carName ${tr('was_cancelled')}";
        break;
    }

    return ListTile(
      leading: CircleAvatar(
        backgroundColor: color.withOpacity(0.1),
        child: Icon(icon, color: color),
      ),
      title: Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
      subtitle: Text(subtitle),
      trailing: Text('1h ago',
          style: TextStyle(fontSize: 12.sp, color: Colors.grey.shade500)),
    );
  }
} 