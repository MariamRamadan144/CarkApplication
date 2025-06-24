import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../cubits/notification_cubit.dart';

class NotificationsScreen extends StatelessWidget {
  const NotificationsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<NotificationCubit, NotificationState>(
      builder: (context, state) {
        if (state is NotificationLoading) {
          return const Center(child: CircularProgressIndicator());
        } else if (state is NotificationError) {
          return Center(child: Text(state.message));
        } else if (state is NotificationLoaded) {
          if (state.notifications.isEmpty) {
            return const Center(child: Text('No notifications.'));
          }
          return ListView.builder(
            itemCount: state.notifications.length,
            itemBuilder: (context, index) {
              final notification = state.notifications[index];
              return ListTile(
                title: Text(notification.title),
                subtitle: Text(notification.message),
                trailing: Text(
                  '${notification.date.hour}:${notification.date.minute}',
                  style: const TextStyle(fontSize: 12, color: Colors.grey),
                ),
                leading: Icon(
                  notification.isRead ? Icons.notifications : Icons.notifications_active,
                  color: notification.isRead ? Colors.grey : Theme.of(context).colorScheme.primary,
                ),
                onTap: () => context.read<NotificationCubit>().markAsRead(notification.id),
              );
            },
          );
        }
        return const SizedBox.shrink();
      },
    );
  }
}
