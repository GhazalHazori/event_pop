import 'package:dartz/dartz.dart';
import 'package:flutter_templat/core/data/models/common_response.dart';
import 'package:flutter_templat/core/data/network/endpoints/add_event_endpoint.dart';
import 'package:flutter_templat/core/data/network/network_config.dart';
import 'package:flutter_templat/core/enums/request_type.dart';
import 'package:flutter_templat/core/utils/network_util.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class EventRepository {
  Future<Either<String, String>> createEvent({
    required String name,
    required DateTime date,
    required String image,
    required LatLng location,
    required String interest,
    required int tickets,
    required int price,
  }) async {
    try {
      return NetworkUtil.sendRequest(
        type: RequestType.POST,
        url: AddeventEndPoints.addevent,
        body: {
          "name": name,
          "date": date.toIso8601String().split('T')[0],
          "image": image,
          "location": {
            "type": "Point",
            "coordinates": [location.latitude, location.longitude],
          },
          "interest": interest.toLowerCase(),
          "tickets": tickets,
          "price": price,
        },
        headers: NetworkConfig.getHeaders(needAuth: true),
      ).then((response) {
        CommonResponse<Map<String, dynamic>> commonResponse =
            CommonResponse.fromJson(response);

        if (commonResponse.getStatus) {
          return Right(commonResponse.message ?? "Event created successfully");
        } else {
          return Left(commonResponse.message ?? 'Failed to create event');
        }
      });
    } catch (e) {
      return Left(e.toString());
    }
  }
}
