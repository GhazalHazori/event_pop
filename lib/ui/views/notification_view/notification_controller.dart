import 'package:flutter_templat/ui/shared/custom_widgets/custom_notification_item.dart';
import 'package:get/get.dart';

class NotificationController extends GetxController {
  RxList<CustomNotificationItem> notifications = <CustomNotificationItem>[
    CustomNotificationItem(
      title: 'David Silbia',
      subtitle: 'Invite Jo Malone London’s Mother’s',
      time: 'Just now',
      showActions: true,
    ),
    CustomNotificationItem(
      title: 'Adnan Safi',
      subtitle: 'Started following you',
      time: '5 min ago',
    ),
    CustomNotificationItem(
      title: 'Joan Baker',
      subtitle: 'Invite A virtual Evening of Smooth Jazz',
      time: '20 min ago',
      showActions: true,
    ),
    CustomNotificationItem(
      title: 'Ronald C. Kinch',
      subtitle: 'Like your events',
      time: '1 hr ago',
    ),
    CustomNotificationItem(
      title: 'Clara Tolson',
      subtitle: 'Join your Event Gala Music Festival',
      time: '9 hr ago',
    ),
    CustomNotificationItem(
      title: 'Jennifer Fritz',
      subtitle: 'Invite you International Kids Safe',
      time: 'Tue , 5:10 pm',
      showActions: true,
    ),
    CustomNotificationItem(
      title: 'Eric G. Prickett',
      subtitle: 'Started following you',
      time: 'Wed, 3:30 pm',
    ),
  ].obs;
}
