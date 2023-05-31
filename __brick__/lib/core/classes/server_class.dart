import 'package:flutter/cupertino.dart';

@immutable
class Server {
  const Server({
    required this.name,
    required this.address,
    required this.description,
    required this.isTest,
    required this.socketAddress,
    required this.imageAddress,
    required this.projectName,
  });

  final String name;
  final String address;
  final String projectName;
  final String description;
  final bool isTest;
  final String socketAddress;
  final dynamic imageAddress;

  factory Server.fromJson(Map<String, dynamic> json) => Server(
    name: json["Name"],
    address: json["Address"],
    description: json["Description"],
    isTest: json["IsTest"],
    socketAddress: json["SocketAddress"]??'',
    imageAddress: json["ImageAddress"]??'',
    projectName: json["ProjectName"]??'ABOMIS',
  );

  Map<String, dynamic> toJson() => {
    "Name": name,
    "Address": address,
    "Description": description,
    "IsTest": isTest,
    "SocketAddress": socketAddress,
    "ImageAddress": imageAddress,
    "ProjectName": projectName,
  };
}