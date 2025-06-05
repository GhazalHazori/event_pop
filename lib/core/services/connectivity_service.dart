import 'dart:async';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter_templat/core/enums/connectivity_status.dart';

class ConnectivityService {
  StreamController<ConnectivityStatus> connectivityStatusController =
      StreamController<ConnectivityStatus>.broadcast();

  ConnectivityService() {
    Connectivity connectivity = Connectivity();

    connectivity.onConnectivityChanged.listen((event) {
      connectivityStatusController.add(getStauts(event as ConnectivityResult));
    });
  }
  ConnectivityStatus getStauts(ConnectivityResult value) {
    switch (value) {
      case ConnectivityResult.bluetooth:
        return ConnectivityStatus.ONLINE;
      case ConnectivityResult.wifi:
        return ConnectivityStatus.ONLINE;

      case ConnectivityResult.ethernet:
        return ConnectivityStatus.ONLINE;

      case ConnectivityResult.mobile:
        return ConnectivityStatus.ONLINE;

      case ConnectivityResult.none:
        return ConnectivityStatus.ONLINE;

      case ConnectivityResult.vpn:
        return ConnectivityStatus.ONLINE;

      case ConnectivityResult.other:
        return ConnectivityStatus.ONLINE;
    }
  }
}
