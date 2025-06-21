import 'package:bot_toast/bot_toast.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_templat/core/data/models/apis/eventt_modell.dart';
import 'package:flutter_templat/core/data/models/apis/token_info.dart';
import 'package:flutter_templat/core/data/models/common_response.dart';
import 'package:flutter_templat/core/data/network/endpoints/profile_endpoints.dart';
import 'package:flutter_templat/core/data/network/endpoints/user_endpoints.dart';
import 'package:flutter_templat/core/data/network/network_config.dart';
import 'package:flutter_templat/core/enums/request_type.dart';
import 'package:flutter_templat/core/utils/network_util.dart';

class ProfileRepository {
  Future<Either<String, String>> updateAboutText(
      String newText, String id) async {
    try {
      return NetworkUtil.sendRequest(
        type: RequestType.PUT,
        url: ProfileEndPoints.editAboutme + id,
        body: {
          'about': newText,
        },
        headers: NetworkConfig.getHeaders(
            needAuth: true), // Set to true since token is required
      ).then((response) {
        CommonResponse<Map<String, dynamic>> commonResponse =
            CommonResponse.fromJson(response);

        if (commonResponse.getStatus) {
          return Right(commonResponse.data?['message'] ??
              'Profile updated successfully!');
        } else {
          return Left(commonResponse.message ?? 'Failed to update profile');
        }
      });
    } catch (e) {
      return Left('Error: $e');
    }
  }

  Future<Either<String, Map<String, dynamic>>> fetchProfileData(
      String id) async {
    try {
      final response = await NetworkUtil.sendRequest(
        type: RequestType.GET,
        url: ProfileEndPoints.getProfile + (id),
        headers: NetworkConfig.getHeaders(needAuth: true),
      );

      final CommonResponse<Map<String, dynamic>> commonResponse =
          CommonResponse.fromJson(response);

      if (commonResponse.getStatus) {
        return Right(commonResponse.data ?? {});
      } else {
        return Left(commonResponse.message ?? 'فشل تحميل البيانات');
      }
    } catch (e) {
      return Left('خطأ أثناء الاتصال: $e');
    }
  }

  Future<Either<String, List<EventModel>>> geteventforuser(
      {required String id}) async {
    try {
      return NetworkUtil.sendRequest(
        type: RequestType.GET,
        url: ProfileEndPoints.geteventforuser + id,
        headers: NetworkConfig.getHeaders(
          needAuth: true,
          type: RequestType.GET,
        ),
      ).then((response) {
        CommonResponse<dynamic> commonResponse =
            CommonResponse.fromJson(response);
        if (commonResponse.getStatus) {
          List<EventModel> resultList = [];
          commonResponse.data['userEvent'].forEach(
            (element) {
              resultList.add(EventModel.fromJson(element));
            },
          );
          return Right(resultList);
        } else {
          return Left(commonResponse.message ?? '');
        }
      });
    } catch (e) {
      return Left(e.toString());
    }
  }
}
