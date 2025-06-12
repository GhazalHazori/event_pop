// import 'package:bot_toast/bot_toast.dart';
// import 'package:dartz/dartz.dart';

// import 'package:flutter_templat/core/data/models/apis/token_info.dart';
// import 'package:flutter_templat/core/data/network/endpoints/user_endpoints.dart';

// import '../../enums/request_type.dart';
// import '../../utils/network_util.dart';
// import '../models/common_response.dart';
// import '../network/network_config.dart';

// class UserRepository {
//   Future<Either<String, TokenInfo>> login({
//     required String email,
//     required String password,
//   }) async {
//     try {
//       return NetworkUtil.sendRequest(
//         type: RequestType.POST,
//         url: UserEndPoints.login,
//         body: {
//           'userName': email,
//           'password': password,
//         },
//         headers: NetworkConfig.getHeaders(needAuth: false),
//       ).then((response) {
//         CommonResponse<Map<String, dynamic>> commonResponse =
//             CommonResponse.fromJson(response);

//         if (commonResponse.getStatus) {
//           return Right(TokenInfo.fromJson(commonResponse.data ?? {}));
//         } else {
//           return Left(commonResponse.message ?? '');
//         }
//       });
//     } catch (e) {
//       return Left(e.toString());
//     }
//   }
// }
import 'package:bot_toast/bot_toast.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_templat/core/data/models/apis/token_info.dart';
import 'package:flutter_templat/core/data/models/common_response.dart';
import 'package:flutter_templat/core/data/network/endpoints/user_endpoints.dart';
import 'package:flutter_templat/core/data/network/network_config.dart';
import 'package:flutter_templat/core/enums/request_type.dart';
import 'package:flutter_templat/core/utils/network_util.dart';

class UserRepository {
  Future<Either<String, TokenInfo>> login({
    required String email,
    required String password,
  }) async {
    try {
      return NetworkUtil.sendRequest(
        type: RequestType.POST,
        url: UserEndPoints.login,
        body: {
          'email': email,
          'password': password,
        },
        headers: NetworkConfig.getHeaders(needAuth: false),
      ).then((response) {
        CommonResponse<Map<String, dynamic>> commonResponse =
            CommonResponse.fromJson(response);

        if (commonResponse.getStatus) {
          return Right(TokenInfo.fromJson(commonResponse.data ?? {}));
        } else {
          return Left(commonResponse.message ?? '');
        }
      });
    } catch (e) {
      return Left(e.toString());
    }
  }
    Future<Either<String, String>> verify({
    required String email,
    required String otpNum,
  }) async {
    try {
      return NetworkUtil.sendRequest(
        type: RequestType.POST,
        url: UserEndPoints.verify,
        body: {
          'email': email,
          'otpNum': otpNum,
        },
        headers: NetworkConfig.getHeaders(needAuth: false),
      ).then((response) {
        CommonResponse<Map<String, dynamic>> commonResponse =
            CommonResponse.fromJson(response);

        if (commonResponse.getStatus) {
          return Right(commonResponse.data!['message']);
        } else {
          return Left(commonResponse.message ?? '');
        }
      });
    } catch (e) {
      return Left(e.toString());
    }
  }
  


  Future<Either<String, bool>> register({
    required String email,
    required String password,
    required String phoneNumber,
    required String name,
    required List<String> provinces,
    required List<String> interests,
  }) async {
    try {
      return NetworkUtil.sendRequest(
        type: RequestType.POST,
        url: UserEndPoints.register,
        body: {
          'email': email,
          'password': password,
          'phoneNumber': phoneNumber,
          'name': name,
          'provinces': provinces ,
          'interests':interests,
        },
     
        headers: NetworkConfig.getHeaders(needAuth: false),
      ).then((response) {
        CommonResponse<Map<String, dynamic>> commonResponse =
            CommonResponse.fromJson(response);

        if (commonResponse.getStatus) {
          return Right(commonResponse.getStatus);
        } else {
          return Left(commonResponse.message ?? '');
        }
      });
    } catch (e) {
      return Left(e.toString());
    }
  }
}
