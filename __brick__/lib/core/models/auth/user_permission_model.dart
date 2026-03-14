import 'package:flutter/widgets.dart';

@immutable
class UserPermissionModel {
  final int? userGroupID;
  final String? userGroupTitle;
  final String? uiName;
  final String? pageName;

  const UserPermissionModel({this.userGroupID, this.userGroupTitle, this.uiName, this.pageName});

  factory UserPermissionModel.fromJson(Map<String, dynamic> json) => UserPermissionModel(
    userGroupID: int.tryParse(json['UserGroupID'].toString()),
    userGroupTitle: json['UserGroupTitle'],
    uiName: json['UIName'],
    pageName: json['PageName'],
  );

  Map<String, dynamic> toJson() => {
    'UserGroupID': userGroupID,
    'UserGroupTitle': userGroupTitle,
    'UIName': uiName,
    'PageName': pageName,
  };
}
