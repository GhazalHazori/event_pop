import 'package:dartz/dartz.dart';
import 'package:flutter_templat/core/data/models/common_response.dart';
import 'package:flutter_templat/core/data/models/search_model.dart';
import 'package:flutter_templat/core/data/network/endpoints/search_endpoints.dart';
import 'package:flutter_templat/core/data/network/network_config.dart';
import 'package:flutter_templat/core/enums/request_type.dart';
import 'package:flutter_templat/core/utils/network_util.dart';

class SearchRepository {
   Future<Either<String, List<Searchmodel>>> searchevent({required String name}
 ) async {
    try {
      final response = await NetworkUtil.sendRequest(
        type: RequestType.GET,
        url: SearchEndpoints.search,
    
        headers: NetworkConfig.getHeaders(
          needAuth: true,
          type: RequestType.GET,
          
        ),params: {"name":name}
      );

      CommonResponse<dynamic> commonResponse =
          CommonResponse.fromJson(response);

      if (commonResponse.getStatus) {
        List<Searchmodel> result = [];

        commonResponse.getData["events"]!.forEach(
          (element) {
            result.add(Searchmodel.fromJson(element));
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