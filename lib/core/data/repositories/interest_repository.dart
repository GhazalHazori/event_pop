import 'package:dartz/dartz.dart';
import 'package:flutter_templat/core/data/models/apis/all_interest_model.dart';
import 'package:flutter_templat/core/data/models/apis/interest_model.dart';
import 'package:flutter_templat/core/data/models/common_response.dart';
import 'package:flutter_templat/core/data/network/endpoints/profile_endpoints.dart';
import 'package:flutter_templat/core/data/network/network_config.dart';
import 'package:flutter_templat/core/enums/request_type.dart';
import 'package:flutter_templat/core/utils/network_util.dart';

class InterestRepository {
  Future<Either<String, List<AllInterest>>> getAllInterests() async {
    try {
      return NetworkUtil.sendRequest(
        type: RequestType.GET,
        url: ProfileEndPoints.getallinterests,
        headers: NetworkConfig.getHeaders(needAuth: true),
      ).then((response) {
        final commonResponse = CommonResponse<dynamic>.fromJson(response);

        if (commonResponse.getStatus) {
          List<AllInterest> resultList = [];
          commonResponse.data.forEach(
            (element) {
              resultList.add(AllInterest.fromJson(element));
            },
          );
          return Right(resultList);
        } else {
          return Left(commonResponse.message ?? 'فشل في جلب الاهتمامات');
        }
      });
    } catch (e) {
      return Left(e.toString());
    }
  }

  Future<Either<String, List<Interest>>> getInterests(String userId) async {
    try {
      return NetworkUtil.sendRequest(
        type: RequestType.GET,
        url: "${ProfileEndPoints.getinterestforuser}$userId",
        headers: NetworkConfig.getHeaders(needAuth: true),
      ).then((response) {
        final commonResponse = CommonResponse<dynamic>.fromJson(response);

        if (commonResponse.getStatus) {
          List<Interest> resultList = [];
          commonResponse.data['interests'].forEach(
            (element) {
              resultList.add(Interest.fromJson(element));
            },
          );
          return Right(resultList);
        } else {
          return Left(commonResponse.message ?? 'فشل في جلب الاهتمامات');
        }
      });
    } catch (e) {
      return Left(e.toString());
    }
  }
}
