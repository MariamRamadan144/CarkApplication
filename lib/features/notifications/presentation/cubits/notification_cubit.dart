import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

// Simple notification model
class AppNotification extends Equatable {
  final String id;
  final String title;
  final String message;
  final DateTime date;
  final bool isRead;

  const AppNotification({
    required this.id,
    required this.title,
    required this.message,
    required this.date,
    this.isRead = false,
  });

  AppNotification copyWith({bool? isRead}) => AppNotification(
        id: id,
        title: title,
        message: message,
        date: date,
        isRead: isRead ?? this.isRead,
      );

  @override
  List<Object?> get props => [id, title, message, date, isRead];
}

// States
abstract class NotificationState extends Equatable {
  const NotificationState();
  @override
  List<Object?> get props => [];
}

class NotificationInitial extends NotificationState {}
class NotificationLoading extends NotificationState {}
class NotificationLoaded extends NotificationState {
  final List<AppNotification> notifications;
  const NotificationLoaded(this.notifications);
  @override
  List<Object?> get props => [notifications];
}
class NotificationError extends NotificationState {
  final String message;
  const NotificationError(this.message);
  @override
  List<Object?> get props => [message];
}

// Cubit
class NotificationCubit extends Cubit<NotificationState> {
  NotificationCubit() : super(NotificationInitial());

  // Simulate fetching notifications
  Future<void> fetchNotifications() async {
    emit(NotificationLoading());
    await Future.delayed(const Duration(seconds: 1));
    try {
      // Replace with real data source
      final notifications = [
        AppNotification(
          id: '1',
          title: 'Booking Confirmed',
          message: 'Your booking for Toyota Camry is confirmed.',
          date: DateTime.now().subtract(const Duration(hours: 1)),
        ),
        AppNotification(
          id: '2',
          title: 'Booking Cancelled',
          message: 'Your booking for Ford Focus was cancelled.',
          date: DateTime.now().subtract(const Duration(days: 1)),
        ),
      ];
      emit(NotificationLoaded(notifications));
    } catch (e) {
      emit(NotificationError('Failed to load notifications'));
    }
  }

  void markAsRead(String id) {
    if (state is NotificationLoaded) {
      final notifications = (state as NotificationLoaded).notifications.map((n) {
        if (n.id == id) return n.copyWith(isRead: true);
        return n;
      }).toList();
      emit(NotificationLoaded(notifications));
    }
  }
} 