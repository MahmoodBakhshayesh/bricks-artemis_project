class NewVersion {
  NewVersion({
    required this.number,
    required this.isForce,
    required this.address,
    required this.dateTime,
    required this.description,
    required this.newFeatures,
  });

  final String number;
  final bool isForce;
  final String address;
  final DateTime dateTime;
  final String description;
  final List<String> newFeatures;

  factory NewVersion.fromJson(Map<String, dynamic> json) => NewVersion(
    number: json["Number"],
    isForce: json["IsForce"],
    address: json["Address"],
    dateTime: DateTime.parse(json["DateTime"]),
    description: json["Description"],
    newFeatures: List<String>.from((json["NewFeatures"]??"").toString().split(",").map((x) => x)),
  );

  Map<String, dynamic> toJson() => {
    "Number": number,
    "IsForce": isForce,
    "Address": address,
    "DateTime": dateTime.toIso8601String(),
    "Description": description,
    "NewFeatures": List<dynamic>.from(newFeatures.map((x) => x)).join(","),
  };
}
