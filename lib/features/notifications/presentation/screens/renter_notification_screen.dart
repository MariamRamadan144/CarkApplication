import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class RenterNotificationScreen extends StatelessWidget {
   final String currentUserId= '1';
  const RenterNotificationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Renter Notifications')),
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collection('Notification')
            .where('type', isEqualTo: 'renter')
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