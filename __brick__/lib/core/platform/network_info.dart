
import 'dart:developer';

import 'package:connectivity_plus/connectivity_plus.dart';

import '../abstracts/network_info_abs.dart';

class NetworkInfo implements NetworkInfoInterface {
  final Connectivity connectivity;

  NetworkInfo(this.connectivity);

  @override
  Future<bool> get isConnected async {
    // return false;
    ConnectivityResult r = await connectivity.checkConnectivity();
    log("Connection Status:  ${r != ConnectivityResult.none}");
    return r != ConnectivityResult.none;
  }
}
