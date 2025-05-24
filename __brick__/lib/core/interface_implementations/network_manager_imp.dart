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
  Future<ResponseImplementation> post(RequestInterface request, {String? api, Map<String, String>? headers, Duration? timeout}) async {
    NetworkOption option = NetworkOption();

    String apiAddress = api == null
        ? option.baseUrl!
        : api.contains("http")
        ? api
        : option.baseUrl! + api;

    dynamic reqJson = request.toJson();
    NetworkRequest networkRequest = NetworkRequest(api: apiAddress, data: reqJson);

    if (headers != null) {
      networkRequest.options.headers?.addAll(headers);
    }
    if (networkResponse.status) {
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
        trace: StackTrace.fromString("NetworkManagerImp.post"),
      );
    }
  }


  @override
  Future<ResponseImplementation> get(String? url,{Map<String, String>? headers,}) async {
    NetworkOption option = NetworkOption();
    String apiAddress = url == null
        ? option.baseUrl!
        : url.contains("http")
        ? url
        : option.baseUrl! + url;

    NetworkRequest networkRequest = NetworkRequest(api: apiAddress, data: '');
    String? token = getIt<WidgetRef>().read(userProvider)?.token;
    if (token != null) {
      networkRequest.options.headers?.addAll({"Authorization": "Bearer $token"});
    }

    if (headers != null) {
      networkRequest.options.headers?.addAll(headers);
    }
    NetworkResponse networkResponse = await networkRequest.get();

    if (networkResponse.status) {
      try {
        print(networkResponse.responseBody);
        ResponseImplementation res = ResponseImplementation.fromJson(networkResponse.responseBody);
        return res;
      } catch (e, trace) {
        throw ParseException(message: e.toString(), trace: trace);
      }
    } else {
      throw ServerException(
        code: networkResponse.responseCode,
        message: networkResponse.extractedMessage!,
        trace: StackTrace.fromString("NetworkManagerImp.get"),
      );
    }
    // return res;
  }
}
