import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'dart:typed_data';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../constants/apis.dart';
import '../data_base/object_box.dart';

class ImageCatcher {
  final SharedPreferences sharedPreferences;
  final Dio dio = Dio(BaseOptions(
      responseType: ResponseType.bytes,
      followRedirects: false,
      validateStatus: (status) {
        return (status ?? 0) < 500;
      }));

  ImageCatcher(this.sharedPreferences);

  Future<Uint8List?> getLogo(String alCode) async {
    try {
      String? logoBase64 = sharedPreferences.getString("${alCode}Logo");
      if(logoBase64!=null){
        Uint8List logoBytes = base64Decode(logoBase64);
        return logoBytes;
      }else {
        var response = await dio.get(Apis.logoUrl + alCode);
        if (response.statusCode == 200 && response.data is Uint8List && (response.data as Uint8List).isNotEmpty) {

          saveImage(response.data,alCode);
          String base64Logo = base64Encode(response.data);
          sharedPreferences.setString("${alCode}Logo", base64Logo);
          return response.data;
        } else {
          return null;
        }
      }
    } catch (e) {
      log(e.toString());
      return null;
    }
  }

  saveImage(Uint8List data,String alCode) async {
    log("$alCode logoSaved");
    if(!kIsWeb) {
      Directory appDocDir = await getApplicationDocumentsDirectory();
      File file = File("${appDocDir.path}/$alCode.png");
      file.writeAsBytes(data).catchError((e) {
        log(e);
      });
    }
  }

  Future<String?> checkFile(String alCode) async {
    if(!kIsWeb) {
      Directory appDocDir = await getApplicationDocumentsDirectory();
      bool exist = await File("${appDocDir.path}/$alCode.png").exists();
      if(exist) {
        return "${appDocDir.path}/$alCode.png";
      }else{
        return null;
      }
    }else{
      return null;
    }
  }
}
