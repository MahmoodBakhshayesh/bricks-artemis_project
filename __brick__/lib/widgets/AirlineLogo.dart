import 'dart:convert';
import '../../core/interface_implementations/response_imp.dart';
import '../../core/interfaces/network_manager_int.dart';
import '../../initialize.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import '../core/constants/apis.dart';
import '../core/data_base/local_data_base.dart';
import '../core/data_base/table_names.dart';

class AirlineLogo extends StatefulWidget {
  final double size;
  final String logo;
  final LocalDataBase localDataBase = LocalDataBase();

  AirlineLogo(this.logo,{Key? key, this.size = 40}) : super(key: key);

  @override
  State<AirlineLogo> createState() => _AirlineLogoState();
}

class _AirlineLogoState extends State<AirlineLogo> {
  Image? logoImg;

  @override
  void initState() {
    getImage(widget.logo);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: widget.size,
      height: widget.size,
      child: logoImg ?? const SizedBox(),
    );
  }

  Future<void> getImage(String logo) async {
    String? logoBase64 = await widget.localDataBase.getFromTable<String>(TableNames.logoTable, logo);
    if (logoBase64 == null) {
      NetworkManagerInterface networkManager = getIt<NetworkManagerInterface>();
      ResponseImplementation response = await networkManager.get(Apis.logoUrl + logo);
      if (response.isSuccess) {
        if (response.body is Uint8List && (response.body as Uint8List).isNotEmpty) {
          String base64Logo = base64Encode(response.body);
          widget.localDataBase.putToTable<String>(TableNames.logoTable, logo, base64Logo);
          Image img = Image.memory(response.body);
          logoImg = img;
          setState(() {});
        }
      }
    } else {
      Uint8List logoBytes = base64Decode(logoBase64);
      Image img = Image.memory(logoBytes);
      logoImg = img;
      setState(() {});
    }
  }
}
