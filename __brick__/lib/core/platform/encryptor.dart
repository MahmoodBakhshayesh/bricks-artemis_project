import 'dart:convert';
import 'package:crypto/crypto.dart';
import 'package:artemis_utils/artemis_utils.dart';
class Encryptor {
  Encryptor._();


  static String encryptPassword(String password,{String salt = "SalterIsHereForNullSalts"}){
    List<int> bytes = password.toUtf16!;
    List<int> src = salt.toUtf16!;
    List<int> dst =src+ bytes;
    final c1 = sha256.convert(dst);
    final c2 = base64Encode(c1.bytes);
    return c2;
  }
  static String encryptPasswordOld(String password,{String salt = "SalterIsHereForNullSalts"}){
    List<int> bytes = password.toUtf16!;
    List<int> src = salt.toUtf16!;
    List<int> dst =src+ bytes;
    final c1 = sha1.convert(dst);
    final c2 = base64Encode(c1.bytes);
    return c2;
  }
}