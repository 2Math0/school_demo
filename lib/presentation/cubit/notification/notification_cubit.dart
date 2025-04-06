import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import '../../../data/models/notification.dart';
import '../../../data/repositories/notification_repository.dart';

part 'notification_state.dart';

class NotificationCubit extends Cubit<NotificationState> {
  final NotificationRepository notificationRepository;
  final String userId;

  NotificationCubit({
    required this.notificationRepository,
    required this.userId,
  }) : super(const NotificationInitial());

  Future<void> loadNotifications({bool unreadOnly = false}) async {
    try {
      emit(const NotificationLoading());
      final notifications = await notificationRepository.getNotifications(
        userId: userId,
        unreadOnly: unreadOnly,
      );
      emit(NotificationsLoaded(notifications: notifications));
    } catch (e) {
      emit(NotificationError(message: e.toString()));
    }
  }

  Future<void> markAsRead(String notificationId) async {
    try {
      emit(const NotificationLoading());
      await notificationRepository.markAsRead(
        userId: userId,
        notificationId: notificationId,
      );
      final notifications = await notificationRepository.getNotifications(
        userId: userId,
      );
      emit(NotificationsLoaded(notifications: notifications));
    } catch (e) {
      emit(NotificationError(message: e.toString()));
    }
  }

  Future<void> markAllAsRead() async {
    try {
      emit(const NotificationLoading());
      await notificationRepository.markAllAsRead(userId);
      final notifications = await notificationRepository.getNotifications(
        userId: userId,
      );
      emit(NotificationsLoaded(notifications: notifications));
    } catch (e) {
      emit(NotificationError(message: e.toString()));
    }
  }
}
