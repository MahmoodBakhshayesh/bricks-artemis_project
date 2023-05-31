import 'package:flutter/foundation.dart';
import 'package:network_manager/network_manager.dart';
import 'package:dio/dio.dart' as dio;
import '../abstracts/exception_abs.dart';
import '../abstracts/network_manager_abs.dart';
import '../abstracts/request_abs.dart';
import '../abstracts/response_abs.dart';
import '../constants/apis.dart';

class NetworkManager implements NetworkManagerInterface {
  NetworkManager();

  @override
  Future<Response> post(Request request) async {
    NetworkRequest networkRequest = NetworkRequest(api: Apis.baseUrl, data: request.toJson());
    NetworkResponse networkResponse = await networkRequest.post();
    if (networkResponse.responseStatus) {
      try {
        // Response res = Response.fromJson(networkResponse.responseBody);
        Response res = await compute(Response.fromJson, networkResponse.responseBody);
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
  Future<Response> get(String url) async {
    dio.Dio d = dio.Dio(dio.BaseOptions(
        responseType: dio.ResponseType.bytes,
        followRedirects: false,
        validateStatus: (status) {
          return (status ?? 0) < 500;
        }));
    var response = await d.get(url);

    // NetworkRequest networkRequest = NetworkRequest(api: url, data: '');
    // NetworkResponse networkResponse = await networkRequest.get();
    Response res = Response(
      status: (response.statusCode == 200) ? 1 : -1,
      message: response.statusMessage ?? 'Unknown Error',
      body: response.data,
    );
    return res;
  }
}
