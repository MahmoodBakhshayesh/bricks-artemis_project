import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';

abstract class NetworkInfoInterface {
  Future<bool> get isConnected;
}

class NetworkInfo implements NetworkInfoInterface {
  final Connectivity connectivity;

  NetworkInfo(this.connectivity);

  @override
  Future<bool> get isConnected async {
    // return false;
    ConnectivityResult r = await connectivity.checkConnectivity();
    return r != ConnectivityResult.none;
  }
}
