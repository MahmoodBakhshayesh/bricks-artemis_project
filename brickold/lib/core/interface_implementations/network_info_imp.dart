import 'dart:developer';
import 'package:connectivity_plus/connectivity_plus.dart';
import '../interfaces/network_info_int.dart';

class NetworkInfoImp implements NetworkInfoInterface {
  final Connectivity connectivity;

  NetworkInfoImp(this.connectivity);

  @override
  Future<bool> get isConnected async {
    // return false;
    List<ConnectivityResult> rl = await connectivity.checkConnectivity();
    // log("Connection Status:  ${r.first != ConnectivityResult.none}");
    return rl.contains(ConnectivityResult.wifi) || rl.contains(ConnectivityResult.ethernet) || rl.contains(ConnectivityResult.mobile);
  }
}
