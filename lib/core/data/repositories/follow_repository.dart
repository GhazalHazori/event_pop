import 'package:dartz/dartz.dart';
import 'package:flutter_templat/core/data/models/apis/interest_model.dart';
import 'package:flutter_templat/core/data/models/common_response.dart';
import 'package:flutter_templat/core/data/models/following_model.dart';
import 'package:flutter_templat/core/data/network/endpoints/profile_endpoints.dart';
import 'package:flutter_templat/core/data/network/network_config.dart';
import 'package:flutter_templat/core/enums/request_type.dart';
import 'package:flutter_templat/core/utils/network_util.dart';

class FollowRepository {
  Future<Either<String, List<FolowingModel>>> getAllFollowings(
      String userId) async {
    try {
      return NetworkUtil.sendRequest(
        type: RequestType.GET,
        url: "${ProfileEndPoints.getallfollowings}$userId",
        headers: NetworkConfig.getHeaders(needAuth: true),
      ).then((response) {
        final commonResponse = CommonResponse<dynamic>.fromJson(response);

        if (commonResponse.getStatus) {
          List<FolowingModel> resultList = [];
          commonResponse.data['existFollowers'].forEach(
            (element) {
              resultList.add(FolowingModel.fromJson(element));
            },
          );
          return Right(resultList);
        } else {
          return Left(commonResponse.message ?? 'فشل في جلب الذين يتابعوك');
        }
      });
    } catch (e) {
      return Left(e.toString());
    }
  }

  Future<Either<String, List<FolowingModel>>> getAllFollowers(
      String userId) async {
    try {
      return NetworkUtil.sendRequest(
        type: RequestType.GET,
        url: "${ProfileEndPoints.getallfollowers}$userId",
        headers: NetworkConfig.getHeaders(needAuth: true),
      ).then((response) {
        final commonResponse = CommonResponse<dynamic>.fromJson(response);

        if (commonResponse.getStatus) {
          print(commonResponse.data);
          List<FolowingModel> resultList = [];
          commonResponse.data['existFollowers'].forEach(
            (element) {
              resultList.add(FolowingModel.fromJson(element));
            },
          );
          return Right(resultList);
        } else {
          return Left(commonResponse.message ?? 'فشل في جلب الذين تتابعهم');
        }
      });
    } catch (e) {
      return Left(e.toString());
    }
  }
}
