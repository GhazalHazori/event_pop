import 'package:dartz/dartz.dart';
import 'package:flutter_templat/core/data/models/client_model.dart';
import 'package:flutter_templat/core/data/models/common_response.dart';
import 'package:flutter_templat/core/data/network/endpoints/payment_endpoints.dart';
import 'package:flutter_templat/core/data/network/network_config.dart';
import 'package:flutter_templat/core/enums/request_type.dart';
import 'package:flutter_templat/core/utils/network_util.dart';

class PaymentRepository {
   Future<Either<String, Clientmodel>> creatPayment({
    required String seats,
    required String eventId,
   
  }) async {
    try {
      return NetworkUtil.sendRequest(
        type: RequestType.POST,
        url: PaymentEndpoints.createPayment,
        body: {
          'eventId': eventId,
          'seats': seats,
         
        },
        headers: NetworkConfig.getHeaders(needAuth: true),
      ).then((response) {
        CommonResponse<Map<String, dynamic>> commonResponse =
            CommonResponse.fromJson(response);

        if (commonResponse.getStatus) {
          return Right(Clientmodel.fromJson(commonResponse.data ?? {}));
        } else {
          return Left(commonResponse.message ?? '');
        }
      });
    } catch (e) {
      return Left(e.toString());
    }
  }
}