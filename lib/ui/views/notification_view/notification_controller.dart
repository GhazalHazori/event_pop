import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_templat/core/data/models/notification_model.dart';
import 'package:flutter_templat/core/data/repositories/notification_repository.dart';
import 'package:flutter_templat/ui/shared/custom_widgets/custom_notification_item.dart';
import 'package:flutter_templat/core/services/base_controller.dart';
import 'package:flutter_templat/core/utils/general_utile.dart';
import 'package:flutter_templat/ui/shared/custom_widgets/custom_toast.dart';
import 'package:flutter_templat/core/enums/message_type.dart';

class NotificationController extends BaseControoler {
  final NotificationRepository _repository = NotificationRepository();
  final RxList<NotifictionModel> notifications = <NotifictionModel>[].obs;
  final RxBool isLoading = false.obs;

  @override
  void onInit() {
    super.onInit();
    notificationService.notifcationStream.stream.listen((notif) {
      notifications.insert(0, notif);
      print("📩 إشعار لحظي وصلك: ${notif.message}");
    });

    fetchNotifications();
    print('🚀 NotificationController initialized');
  }

  void refreshNotifications() {
    print('🔄 Manually refreshing notifications...');
    fetchNotifications();
  }

  void fetchNotifications() {
    // Get user ID from storage or user model
    // For now, use the user ID from the API example
    // TODO: Get user ID from token or user profile
    final userId = storage.getUserId();

    runLoadingFutureFunction(
      function: _repository.getAllNotifications(userId).then(
        (value) {
          value.fold(
            (l) {
              CustomToast.showMessage(
                message: l,
                messageType: MessagType.REJECTED,
              );
            },
            (r) {
              print('📊 Raw notifications data: $r');
              print('📋 Notifications length: ${r.length}');
              print(
                  '📋 First notification: ${r.isNotEmpty ? r.first.toJson() : 'No notifications'}');
              notifications.value = r;
              print('✅ Fetched ${r.length} notifications');
              print('📋 Stored notifications length: ${notifications.length}');
            },
          );
        },
      ),
    );
  }

  Widget buildNotificationItem(NotifictionModel notification) {
    String title = '';
    String subtitle = '';
    String time = '';
    bool showActions = false;
    String sourceType = '';

    // Parse notification based on type
    switch (notification.type) {
      case 'follow-accepted':
        title = 'Follow Request Accepted';
        subtitle =
            notification.message ?? 'Someone accepted your follow request';
        showActions = false;
        break;
      case 'follow-rejected':
        title = 'Follow Request Rejected';
        subtitle =
            notification.message ?? 'Someone rejected your follow request';
        showActions = false;
        break;
      case 'invite':
        title = 'Event Invitation';
        subtitle = notification.message ?? 'You have been invited to an event';
        showActions = false;
        break;
      case 'follow-request':
        title = 'New Follow Request';
        subtitle = notification.message ?? 'Someone wants to follow you';
        showActions = true;
        break;
      default:
        title = 'Notification';
        subtitle = notification.message ?? 'You have a new notification';
        showActions = false;
    }

    // Format time
    if (notification.createdAt != null) {
      try {
        final dateTime = DateTime.parse(notification.createdAt!);
        final now = DateTime.now();
        final difference = now.difference(dateTime);

        if (difference.inMinutes < 1) {
          time = 'Just now';
        } else if (difference.inMinutes < 60) {
          time = '${difference.inMinutes} min ago';
        } else if (difference.inHours < 24) {
          time = '${difference.inHours} hr ago';
        } else {
          time = '${difference.inDays} days ago';
        }
      } catch (e) {
        time = 'Recently';
      }
    }

    return CustomNotificationItem(
      title: title,
      subtitle: subtitle,
      time: time,
      showActions: showActions,
      isRead: notification.isRead ?? false,
      onAccept: showActions ? () => acceptInvite(notification) : null,
      onReject: showActions ? () => rejectInvite(notification) : null,
    );
  }

  void markAsRead(int notificationId) async {
    // TODO: Implement mark as read functionality
    print('Marking notification $notificationId as read');
  }

  void acceptInvite(NotifictionModel notification) async {
    if (notification.sourceId != null) {
      print(
          '✅ Accepting follow request with sourceId: ${notification.sourceId}');
      runLoadingFutureFunction(
        function: _repository.acceptFollowRequest(notification.sourceId!).then(
          (value) {
            print('📋 Accept result: $value');
            value.fold(
              (l) {
                print('❌ Accept error: $l');
                CustomToast.showMessage(
                  message: l,
                  messageType: MessagType.REJECTED,
                );
              },
              (r) {
                print('✅ Accept success: $r');
                CustomToast.showMessage(
                  message: r,
                  messageType: MessagType.SUCCSESS,
                );
                // Remove the notification from the list immediately
                notifications.removeWhere((n) => n.id == notification.id);
                print('🔄 Refreshing notifications after accept...');
                fetchNotifications();
              },
            );
          },
        ),
      );
    }
  }

  void rejectInvite(NotifictionModel notification) async {
    if (notification.sourceId != null) {
      print(
          '❌ Rejecting follow request with sourceId: ${notification.sourceId}');
      runLoadingFutureFunction(
        function: _repository.rejectFollowRequest(notification.sourceId!).then(
          (value) {
            print('📋 Reject result: $value');
            value.fold(
              (l) {
                print('❌ Reject error: $l');
                CustomToast.showMessage(
                  message: l,
                  messageType: MessagType.REJECTED,
                );
              },
              (r) {
                print('✅ Reject success: $r');
                CustomToast.showMessage(
                  message: r,
                  messageType: MessagType.SUCCSESS,
                );
                // Remove the notification from the list immediately
                notifications.removeWhere((n) => n.id == notification.id);
                print('🔄 Refreshing notifications after reject...');
                fetchNotifications();
              },
            );
          },
        ),
      );
    }
  }
}
