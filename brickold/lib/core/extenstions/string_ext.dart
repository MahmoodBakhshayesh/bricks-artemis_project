

extension StringExt on String {
  bool get isValidIp => ipv4RegExp.hasMatch(this);
  bool get isValidIpPort => ipv4portRegExp.hasMatch(this);





}

extension StringNullExt on String? {
  String? get pureValue => this==null? null: this!.isEmpty?null:this;
}

final RegExp boardingPassRegex = RegExp(r'^M1[\w\s]{20}[\w\s]{8}[\w\s]{3}[\w\s]{3}[\w\s]{3}\d{4}\s\d{3}\w{1}[\w\s]{3}\d\s{3}$');


RegExp ipv4RegExp = RegExp(r'^(?:[0-9]{1,3}\.){3}[0-9]{1,3}$',);
// RegExp ipv4portRegExp = RegExp(r'^(?:[0-9]{1,3}\.){3}[0-9]{1,3}$',);
final ipv4portRegExp = RegExp(r'^((25[0-5]|2[0-4][0-9]|[0-1]?[0-9][0-9]?)\.){3}(25[0-5]|2[0-4][0-9]|[0-1]?[0-9][0-9]?):([0-9]{1,5})$');

RegExp validSeatReg = RegExp(r'^^\d{1,3}[A-Za-z]',);