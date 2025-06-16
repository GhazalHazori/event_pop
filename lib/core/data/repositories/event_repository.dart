import 'package:dartz/dartz.dart';
import 'package:flutter_templat/core/data/models/all_event_model.dart';
import 'package:flutter_templat/core/data/models/common_response.dart';
import 'package:flutter_templat/core/data/models/past_event_model.dart';
import 'package:flutter_templat/core/data/models/up_coming_event.dart';
import 'package:flutter_templat/core/data/network/endpoints/event_endpoints.dart';
import 'package:flutter_templat/core/data/network/network_config.dart';
import 'package:flutter_templat/core/enums/request_type.dart';
import 'package:flutter_templat/core/utils/network_util.dart' show NetworkUtil;

class EventRepository{
   Future<Either<String, List<AllEventModel>>> getAllEvent(
 ) async {
    try {
      final response = await NetworkUtil.sendRequest(
        type: RequestType.GET,
        url: EventEndpoints.getAllevent,
    
        headers: NetworkConfig.getHeaders(
          needAuth: false,
          type: RequestType.GET,
        ),
      );

      CommonResponse<dynamic> commonResponse =
          CommonResponse.fromJson(response);

      if (commonResponse.getStatus) {
        List<AllEventModel> result = [];

        commonResponse.getData["data"]["events"]!.forEach(
          (element) {
            result.add(AllEventModel.fromJson(element));
          },
        );

        return Right(result);
      } else {
        return Left(commonResponse.message ?? '');
      }
    } catch (e) {
      return Left(e.toString());
    }
  }
   Future<Either<String, List<UpComingEventModel>>> getUpComingEvent(
 ) async {
    try {
      final response = await NetworkUtil.sendRequest(
        type: RequestType.GET,
        url: EventEndpoints.getUpcomingevent,
    
        headers: NetworkConfig.getHeaders(
          needAuth: true,
          type: RequestType.GET,
        ),
      );

      CommonResponse<dynamic> commonResponse =
          CommonResponse.fromJson(response);

      if (commonResponse.getStatus) {
        List<UpComingEventModel> result = [];

        commonResponse.getData["events"]!.forEach(
          (element) {
            result.add(UpComingEventModel.fromJson(element));
          },
        );

        return Right(result);
      } else {
        return Left(commonResponse.message ?? '');
      }
    } catch (e) {
      return Left(e.toString());
    }
  }
    Future<Either<String, List<PastEventModel>>> getPastEvent(
 ) async {
    try {
      final response = await NetworkUtil.sendRequest(
        type: RequestType.GET,
        url: EventEndpoints.getPastEvent,
    
        headers: NetworkConfig.getHeaders(
          needAuth: true,
          type: RequestType.GET,
        ),
      );

      CommonResponse<dynamic> commonResponse =
          CommonResponse.fromJson(response);

      if (commonResponse.getStatus) {
        List<PastEventModel> result = [];

        commonResponse.getData["events"]!.forEach(
          (element) {
            result.add(PastEventModel.fromJson(element));
          },
        );

        return Right(result);
      } else {
        return Left(commonResponse.message ?? '');
      }
    } catch (e) {
      return Left(e.toString());
    }
  }
}