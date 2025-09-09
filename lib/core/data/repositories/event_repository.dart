import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:flutter_templat/core/data/models/all_event_model.dart';
import 'package:flutter_templat/core/data/models/common_response.dart';
import 'package:flutter_templat/core/data/models/event_details_model.dart';
import 'package:flutter_templat/core/data/models/event_map_model.dart';
import 'package:flutter_templat/core/data/models/nearly_event_model.dart';
import 'package:flutter_templat/core/data/models/past_event_model.dart';
import 'package:flutter_templat/core/data/models/saved_event_model.dart';
import 'package:flutter_templat/core/data/models/up_coming_event.dart';
import 'package:flutter_templat/core/data/network/endpoints/add_event_endpoint.dart';
import 'package:flutter_templat/core/data/network/endpoints/event_endpoints.dart';
import 'package:flutter_templat/core/data/network/network_config.dart';
import 'package:flutter_templat/core/enums/request_type.dart';
import 'package:flutter_templat/core/utils/network_util.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class EventRepository {
  Future<Either<String, String>> saveEvent({
    required int id,
  }) async {
    try {
      return NetworkUtil.sendRequest(
        type: RequestType.POST,
        url: EventEndpoints.saveEvent + '${id}',
        headers: NetworkConfig.getHeaders(needAuth: true),
      ).then((response) {
        CommonResponse<Map<String, dynamic>> commonResponse =
            CommonResponse.fromJson(response);

        if (commonResponse.getStatus) {
          return Right(commonResponse.message ?? '');
        } else {
          return Left(commonResponse.message ?? '');
        }
      });
    } catch (e) {
      return Left(e.toString());
    }
  }

  Future<Either<String, List<SavedEventModel>>> getSavedEvent(
      {required String id}) async {
    try {
      final response = await NetworkUtil.sendRequest(
        type: RequestType.GET,
        url: EventEndpoints.getSavedEvent + '${id}',
        headers: NetworkConfig.getHeaders(
          needAuth: true,
          type: RequestType.GET,
        ),
      );

      CommonResponse<dynamic> commonResponse =
          CommonResponse.fromJson(response);

      if (commonResponse.getStatus) {
        List<SavedEventModel> result = [];

        commonResponse.getData["events"]!.forEach(
          (element) {
            result.add(SavedEventModel.fromJson(element));
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

  Future<Either<String, Eventdetailsmodel>> geteventById(
      {required String id}) async {
    try {
      final response = await NetworkUtil.sendRequest(
        type: RequestType.GET,
        url: EventEndpoints.geteventbyid + '${id}',
        headers: NetworkConfig.getHeaders(
          needAuth: true,
          type: RequestType.GET,
        ),
      );

      CommonResponse<dynamic> commonResponse =
          CommonResponse.fromJson(response);

      if (commonResponse.getStatus) {
        // List<Eventdetailsmodel> result = [];

        // commonResponse.data!.forEach(
        //   (element) {
        //     result.add(Eventdetailsmodel.fromJson(element));
        //   },
        // );

        return Right(
            Eventdetailsmodel.fromJson(commonResponse.getData['event'] ?? {}));
      } else {
        return Left(commonResponse.message ?? '');
      }
    } catch (e) {
      return Left(e.toString());
    }
  }

  Future<Either<String, String>> createEvent({
    required String name,
    required DateTime date,
    required File image,
    required LatLng location,
    required String interest,
    required int tickets,
    required int price,
    required String description,
    required DateTime time,
  }) async {
    try {
      final fields = {
        'name': name,
        'date': date.toIso8601String().split('T')[0],
        'description': description,
        'price': price.toString(),
        'tickets': tickets.toString(),
        'interest': interest.toLowerCase(),
        'time': time.hour.toString() + ':' + time.minute.toString(),
        'location':
            '{"type":"Point","coordinates":[${location.longitude},${location.latitude}]}'
      };
      final files = {
        'image': image.path,
      };
      final headers = NetworkConfig.getHeaders(needAuth: true);
      final response = await NetworkUtil.sendMultipartRequest(
        url: AddeventEndPoints.addevent,
        headers: headers,
        fields: fields,
        files: files,
      );
      CommonResponse<Map<String, dynamic>> commonResponse =
          CommonResponse.fromJson(response);
      if (commonResponse.getStatus) {
        return Right(commonResponse.message ?? "Event created successfully");
      } else {
        return Left(commonResponse.message ?? 'Failed to create event');
      }
    } catch (e) {
      return Left(e.toString());
    }
  }

  Future<Either<String, List<AllEventModel>>> getAllEvent() async {
    try {
      final response = await NetworkUtil.sendRequest(
        type: RequestType.GET,
        url: EventEndpoints.getAllevent,
        headers: NetworkConfig.getHeaders(
          needAuth: true,
          type: RequestType.GET,
        ),
      );

      CommonResponse<dynamic> commonResponse =
          CommonResponse.fromJson(response);

      if (commonResponse.getStatus) {
        List<AllEventModel> result = [];

        commonResponse.getData["result"]!.forEach(
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

  Future<Either<String, List<UpComingEventModel>>> getUpComingEvent() async {
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

  Future<Either<String, List<PastEventModel>>> getPastEvent() async {
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

  Future<Either<String, List<PlaceModel>>> getEventformap() async {
    try {
      final response = await NetworkUtil.sendRequest(
        type: RequestType.GET,
        url: EventEndpoints.getmapevent,
        headers: NetworkConfig.getHeaders(
          needAuth: true,
          type: RequestType.GET,
        ),
      );

      CommonResponse<dynamic> commonResponse =
          CommonResponse.fromJson(response);

      if (commonResponse.getStatus) {
        List<PlaceModel> result = [];

        commonResponse.getData["events"]!.forEach(
          (element) {
            result.add(PlaceModel.fromJson(element));
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

  Future<Either<String, List<NearlyEventmodel>>> getNearlyEvent() async {
    try {
      final response = await NetworkUtil.sendRequest(
        type: RequestType.GET,
        url: EventEndpoints.nearlyEvent,
        headers: NetworkConfig.getHeaders(
          needAuth: true,
          type: RequestType.GET,
        ),
      );

      CommonResponse<dynamic> commonResponse =
          CommonResponse.fromJson(response);

      if (commonResponse.getStatus) {
        List<NearlyEventmodel> result = [];

        commonResponse.data!.forEach(
          (element) {
            result.add(NearlyEventmodel.fromJson(element));
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
