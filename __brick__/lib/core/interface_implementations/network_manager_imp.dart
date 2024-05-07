import 'package:network_manager/network_manager.dart';
import '../../core/interface_implementations/response_imp.dart';
import 'package:flutter/foundation.dart';
import 'package:dio/dio.dart' as dio;
import '../interfaces/exception_int.dart';
import '../interfaces/network_manager_int.dart';
import '../interfaces/request_int.dart';
import '../interfaces/response_int.dart';
import '../constants/apis.dart';
import 'exceptions_imp.dart';

class NetworkManagerImp implements NetworkManagerInterface {
  NetworkManagerImp();

  @override
  Future<ResponseImplementation> post(RequestInterface request) async {
    NetworkRequest networkRequest = NetworkRequest(api: Apis.baseUrl, data: request.toJson());
    NetworkResponse networkResponse = await networkRequest.post();
    if (networkResponse.responseStatus) {
      try {
        ResponseImplementation res = ResponseImplementation.fromJson(networkResponse.responseBody);
        return res;
      } catch (e, trace) {
        throw ParseException(message: e.toString(), trace: trace);
      }
    } else {
      throw ServerException(
        code: networkResponse.responseCode,
        message: networkResponse.extractedMessage!,
        trace: StackTrace.fromString("RemoteDataSource.getSalt"),
      );
    }
  }

  @override
  Future<ResponseImplementation> get(String url) async {
    dio.Dio d = dio.Dio(dio.BaseOptions(
        responseType: dio.ResponseType.bytes,
        followRedirects: false,
        validateStatus: (status) {
          return (status ?? 0) < 500;
        }));
    var response = await d.get(url);

    // NetworkRequest networkRequest = NetworkRequest(api: url, data: '');
    // NetworkResponse networkResponse = await networkRequest.get();
    ResponseImplementation res = ResponseImplementation(
      status: (response.statusCode == 200) ? 1 : -1,
      message: response.statusMessage ?? 'Unknown Error',
      body: response.data,
    );
    return res;
  }
}
