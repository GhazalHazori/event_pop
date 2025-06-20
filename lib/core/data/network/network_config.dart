//ملف الاعدادادتى لكامل ال api
import 'package:flutter_templat/core/enums/request_type.dart';
import 'package:flutter_templat/core/utils/general_utile.dart';

class NetworkConfig {
  static String BASE_API = '/api/';
  static String getFullApiRoute(String apiroute) {
    return BASE_API + apiroute;
  }

  static Map<String, String>? getHeaders(
      {bool needAuth = true,
      RequestType? type,
      Map<String, String>? extraHeaders}) {
    return {
      if (needAuth)
        "Authorization":
            "Barrier eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6Ijk2ZWJmZTU3LTg3YWUtNDUyYy1iNTkxLWYzN2RiYjAwOTFiNyIsImlzQWRtaW4iOmZhbHNlLCJpYXQiOjE3NTA0NTgyODR9.zotJPmASOgIXCh1BJQyVm2wkOk0zi0J4klvljDK9Ab8",
      if (type != RequestType.GET)
        "Content-Type": type == RequestType.MULTIPART
            ? "multipart/form-data"
            : "application/json",
      ...extraHeaders ?? {}
    };
  }
}
