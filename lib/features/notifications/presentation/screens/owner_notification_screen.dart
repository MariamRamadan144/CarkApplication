import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../auth/presentation/cubits/auth_cubit.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class OwnerNotificationScreen extends StatelessWidget {
  const OwnerNotificationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final user = context.read<AuthCubit>().userModel;
    final userId = user?.id ?? '1';
    
    return Scaffold(
      appBar: AppBar(
        title: const Text('Notifications'),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collection('Notification')
            .where('userId', isEqualTo: userId)
            .orderBy('timestamp', descending: true)
            .snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.error_outline, size: 64, color: Colors.grey.shade400),
                  const SizedBox(height: 16),
                  Text(
                    'Error loading notifications',
                    style: TextStyle(fontSize: 18, color: Colors.grey.shade600),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Please try again later',
                    style: TextStyle(fontSize: 14, color: Colors.grey.shade500),
                  ),
                ],
              ),
            );
          }
          
          if (!snapshot.hasData) {
            return const Center(child: CircularProgressIndicator());
          }
          
          final docs = snapshot.data!.docs;
          
          if (docs.isEmpty) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.notifications_none,
                    size: 64,
                    color: Colors.grey.shade400,
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'No notifications yet',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.grey.shade600,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'You\'ll see notifications here when you have updates',
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.grey.shade500,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            );
          }
          
          return ListView.builder(
            padding: const EdgeInsets.all(16),
            itemCount: docs.length,
            itemBuilder: (context, index) {
              final data = docs[index].data() as Map<String, dynamic>;
              final timestamp = data['timestamp'] as Timestamp?;
              final date = timestamp?.toDate();
              final isRead = data['read'] ?? false;
              final notificationType = data['type'] ?? 'general';
              
              String formattedTime = '';
              if (date != null) {
                final now = DateTime.now();
                final difference = now.difference(date);
                
                if (difference.inDays > 0) {
                  formattedTime = '${difference.inDays}d ago';
                } else if (difference.inHours > 0) {
                  formattedTime = '${difference.inHours}h ago';
                } else if (difference.inMinutes > 0) {
                  formattedTime = '${difference.inMinutes}m ago';
                } else {
                  formattedTime = 'Just now';
                }
              }
              
              // Choose icon based on notification type
              IconData notificationIcon;
              Color iconColor;
              
              switch (notificationType) {
                case 'booking':
                  notificationIcon = Icons.calendar_today;
                  iconColor = Colors.blue;
                  break;
                case 'payment':
                  notificationIcon = Icons.payment;
                  iconColor = Colors.green;
                  break;
                case 'car':
                  notificationIcon = Icons.directions_car;
                  iconColor = Colors.orange;
                  break;
                default:
                  notificationIcon = Icons.notifications;
                  iconColor = Colors.grey;
              }
              
              return Card(
                margin: const EdgeInsets.only(bottom: 12),
                color: isRead ? Colors.grey.shade50 : Colors.white,
                child: ListTile(
                  leading: CircleAvatar(
                    backgroundColor: isRead ? Colors.grey.shade300 : iconColor,
                    child: Icon(
                      notificationIcon,
                      color: isRead ? Colors.grey.shade600 : Colors.white,
                    ),
                  ),
                  title: Text(
                    data['title'] ?? '',
                    style: TextStyle(
                      fontWeight: isRead ? FontWeight.normal : FontWeight.bold,
                    ),
                  ),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(data['body'] ?? ''),
                      const SizedBox(height: 4),
                      Text(
                        formattedTime,
                        style: TextStyle(
                          fontSize: 12,
                          color: Colors.grey.shade500,
                        ),
                      ),
                    ],
                  ),
                  onTap: () {
                    // Mark as read
                    FirebaseFirestore.instance
                        .collection('Notification')
                        .doc(docs[index].id)
                        .update({'read': true});
                  },
                ),
              );
            },
          );
        },
      ),
    );
  }
}
