import 'package:dartz/dartz.dart';
import 'package:flutter_templat/core/data/models/notification_model.dart';
import 'package:flutter_templat/core/data/models/common_response.dart';
import 'package:flutter_templat/core/data/network/endpoints/notification_endpoint.dart';
import 'package:flutter_templat/core/data/network/network_config.dart';
import 'package:flutter_templat/core/enums/request_type.dart';
import 'package:flutter_templat/core/utils/network_util.dart';

class NotificationRepository {
  Future<Either<String, List<NotifictionModel>>> getAllNotifications(
      String userId) async {
    try {
      return NetworkUtil.sendRequest(
        type: RequestType.GET,
        url: NotificationEndPoints.getNotificationUrl(userId),
        headers: NetworkConfig.getHeaders(needAuth: true),
      ).then((response) {
        print('🔍 Raw API response: $response');
        final commonResponse = CommonResponse<dynamic>.fromJson(response);
        print('📊 CommonResponse status: ${commonResponse.getStatus}');
        print('📊 CommonResponse data: ${commonResponse.data}');

        if (commonResponse.getStatus) {
          List<NotifictionModel> resultList = [];
          if (commonResponse.data['notifications'] != null) {
            print(
                '📋 Found notifications array: ${commonResponse.data['notifications']}');
            commonResponse.data['notifications'].forEach(
              (element) {
                print('📋 Processing notification: $element');
                resultList.add(NotifictionModel.fromJson(element));
              },
            );
            print('📋 Final result list length: ${resultList.length}');
          }
          return Right(resultList);
        } else {
          print('❌ API returned error: ${commonResponse.message}');
          return Left(commonResponse.message ?? 'فشل في جلب الإشعارات');
        }
      });
    } catch (e) {
      return Left(e.toString());
    }
  }

  Future<Either<String, String>> markAsRead(int notificationId) async {
    try {
      return NetworkUtil.sendRequest(
        type: RequestType.PUT,
        url: NotificationEndPoints.notificationaccept + '$notificationId',
        headers: NetworkConfig.getHeaders(needAuth: true),
      ).then((response) {
        final commonResponse = CommonResponse<dynamic>.fromJson(response);

        if (commonResponse.getStatus) {
          return Right(commonResponse.message ?? 'تم تحديد الإشعار كمقروء');
        } else {
          return Left(commonResponse.message ?? 'فشل في تحديد الإشعار كمقروء');
        }
      });
    } catch (e) {
      return Left(e.toString());
    }
  }

  Future<Either<String, String>> acceptFollowRequest(int sourceId) async {
    try {
      print('🔍 Accepting follow request for sourceId: $sourceId');
      final url = NotificationEndPoints.notificationaccept + "$sourceId";
      print('🌐 Accept URL: $url');
      print('🔑 Headers: ${NetworkConfig.getHeaders(needAuth: true)}');

      return NetworkUtil.sendRequest(
        body: {},
        type: RequestType.PUT,
        url: url,
        headers: NetworkConfig.getHeaders(needAuth: true),
      ).then((response) {
        print('📡 Accept API Response: $response');
        print('📊 Accept Response Status Code: ${response['statusCode']}');
        print('📊 Accept Response Data: ${response['response']}');

        final commonResponse = CommonResponse<dynamic>.fromJson(response);
        print('📊 Accept CommonResponse status: ${commonResponse.getStatus}');
        print('📊 Accept CommonResponse message: ${commonResponse.message}');
        print('📊 Accept CommonResponse data: ${commonResponse.data}');

        if (commonResponse.getStatus) {
          print('✅ Accept successful');
          return Right(commonResponse.message ?? 'تم قبول طلب المتابعة بنجاح');
        } else {
          print('❌ Accept failed: ${commonResponse.message}');
          return Left(commonResponse.message ?? 'فشل في قبول طلب المتابعة');
        }
      });
    } catch (e) {
      print('❌ Accept exception: $e');
      return Left(e.toString());
    }
  }

  Future<Either<String, String>> rejectFollowRequest(int sourceId) async {
    try {
      print('🔍 Rejecting follow request for sourceId: $sourceId');
      final url = NotificationEndPoints.notificationreject + '$sourceId';
      print('🌐 Reject URL: $url');
      print('🔑 Headers: ${NetworkConfig.getHeaders(needAuth: true)}');

      return NetworkUtil.sendRequest(
        body: {},
        type: RequestType.PUT,
        url: url,
        headers: NetworkConfig.getHeaders(needAuth: true),
      ).then((response) {
        print('📡 Reject API Response: $response');
        print('📊 Reject Response Status Code: ${response['statusCode']}');

        final commonResponse = CommonResponse<dynamic>.fromJson(response);
        print('📊 Reject CommonResponse status: ${commonResponse.getStatus}');
        print('📊 Reject CommonResponse message: ${commonResponse.message}');

        if (commonResponse.getStatus) {
          print('✅ Reject successful');
          return Right(commonResponse.message ?? 'تم رفض طلب المتابعة بنجاح');
        } else {
          print('❌ Reject failed: ${commonResponse.message}');
          return Left(commonResponse.message ?? 'فشل في رفض طلب المتابعة');
        }
      });
    } catch (e) {
      print('❌ Reject exception: $e');
      return Left(e.toString());
    }
  }

  Future<Either<String, Map<String, dynamic>>> sendFollowRequest({
    required String followingId,
    required String followerId,
  }) async {
    try {
      return NetworkUtil.sendRequest(
        type: RequestType.POST,
        url: NotificationEndPoints.follow,
        headers: NetworkConfig.getHeaders(needAuth: true),
        body: {
          'followingId': followingId,
          'followerId': followerId,
        },
      ).then((response) {
        final commonResponse = CommonResponse<dynamic>.fromJson(response);

        if (commonResponse.getStatus) {
          return Right(commonResponse.data ?? {});
        } else {
          return Left(commonResponse.message ?? 'فشل في إرسال طلب المتابعة');
        }
      });
    } catch (e) {
      return Left(e.toString());
    }
  }
}
