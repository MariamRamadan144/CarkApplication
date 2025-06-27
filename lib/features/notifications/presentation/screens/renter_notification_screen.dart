import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../auth/presentation/cubits/auth_cubit.dart';

class RenterNotificationScreen extends StatelessWidget {
  const RenterNotificationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final user = context.read<AuthCubit>().userModel;
    final userId = user?.id ?? '1';
    return Scaffold(
      appBar: AppBar(title: const Text('Renter Notifications')),
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collection('Notification')
            .where('type', isEqualTo: 'renter')
            .where('userId', isEqualTo: userId)
            .orderBy('timestamp', descending: true)
            .snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const Center(child: CircularProgressIndicator());
          }
          final docs = snapshot.data!.docs;
          if (docs.isEmpty) {
            return const Center(child: Text('No notifications yet'));
          }
          return ListView.builder(
            itemCount: docs.length,
            itemBuilder: (context, index) {
              final data = docs[index].data() as Map<String, dynamic>;
              final timestamp = data['timestamp'] as Timestamp?;
              final date = timestamp?.toDate();
              String formattedTime = date != null
                  ? '${date.hour.toString().padLeft(2, '0')}:${date.minute.toString().padLeft(2, '0')}'
                  : '';
              return ListTile(
                title: Text(data['title'] ?? ''),
                subtitle: Text(data['body'] ?? ''),
                trailing: Text(formattedTime, style: TextStyle(fontSize: 12, color: Theme.of(context).colorScheme.secondary)),
              );
            },
          );
        },
      ),
    );
  }
} 