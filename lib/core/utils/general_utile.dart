import 'package:flutter_templat/app/my_app_controller.dart';
import 'package:flutter_templat/core/data/repositories/shared_preference_repository.dart';
import 'package:flutter_templat/core/enums/connectivity_status.dart';
import 'package:flutter_templat/core/enums/message_type.dart';
import 'package:flutter_templat/core/services/cart_service.dart';
import 'package:flutter_templat/core/services/connectivity_service.dart';
import 'package:flutter_templat/core/services/location_services.dart';
import 'package:flutter_templat/core/services/notification_service.dart';
import 'package:flutter_templat/ui/shared/custom_widgets/custom_toast.dart';
import 'package:get/get.dart';

SharedPrefrenceRepository get storage => Get.find<SharedPrefrenceRepository>();
CartService get cartService => Get.find<CartService>();
LocationService get locationService => Get.find<LocationService>();
ConnectivityService get connectivityService => Get.find<ConnectivityService>();
NotificationService get notificationService => Get.find<NotificationService>();
bool get isOnline =>
    Get.find<MyAppContoller>().connectionStatus == ConnectivityStatus.ONLINE;
double get taxAmount => 0.18;
double get deliveryAmount => 0.1;
// void fadeInTransation(Widget view){
//   Get.to(view,transition,duration)
// }
// void customLoader() => BotToast.showCustomLoading(toastBuilder: );
void checkConnection(Function function) {
  if (isOnline) {
    function;
  } else {
    CustomToast.showMessage(
      message: 'Please check internet connection',
      messageType: MessagType.WARNING,
    );
  }
}
