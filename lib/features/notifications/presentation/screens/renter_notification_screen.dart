import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../cubits/notification_cubit.dart';
import '../../../auth/presentation/cubits/auth_cubit.dart';

class RenterNotificationScreen extends StatefulWidget {
  const RenterNotificationScreen({super.key});

  @override
  State<RenterNotificationScreen> createState() => _RenterNotificationScreenState();
}

class _RenterNotificationScreenState extends State<RenterNotificationScreen> {
  @override
  void initState() {
    super.initState();
    _loadNotifications();
  }

  void _loadNotifications() {
    final authCubit = context.read<AuthCubit>();
    final currentUser = authCubit.userModel;
    
    if (currentUser != null) {
      final userId = currentUser.id;
      // Load renter notifications for the current user
      context.read<NotificationCubit>().fetchNotificationsForUser(userId, 'renter');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Renter Notifications'),
        automaticallyImplyLeading: false,
      ),
      body: BlocBuilder<NotificationCubit, NotificationState>(
        builder: (context, state) {
          if (state is NotificationLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is NotificationError) {
            return Center(child: Text(state.message));
          } else if (state is NotificationLoaded) {
            if (state.notifications.isEmpty) {
              return const Center(child: Text('No notifications.'));
            }
            return ListView.separated(
              padding: const EdgeInsets.symmetric(vertical: 16),
              itemCount: state.notifications.length,
              separatorBuilder: (context, index) => const Divider(height: 1, indent: 16, endIndent: 16),
              itemBuilder: (context, index) {
                final notification = state.notifications[index];
                return ListTile(
                  leading: Icon(
                    notification.isRead ? Icons.notifications : Icons.notifications_active,
                    color: notification.isRead ? Colors.grey : Theme.of(context).colorScheme.primary,
                  ),
                  title: Text(notification.title, style: const TextStyle(fontWeight: FontWeight.bold)),
                  subtitle: Text(notification.body),
                  trailing: Text(
                    '${notification.timestamp.hour}:${notification.timestamp.minute.toString().padLeft(2, '0')}',
                    style: const TextStyle(fontSize: 12, color: Colors.grey),
                  ),
                  onTap: () => context.read<NotificationCubit>().markAsRead(notification.id),
                );
              },
            );
          }
          return const SizedBox.shrink();
        },
      ),
    );
  }
} 