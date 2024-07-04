import 'dart:convert';

UserData userDataFromJson(String str) => UserData.fromJson(json.decode(str));

String userDataToJson(UserData data) => json.encode(data.toJson());

class UserData {
  int id;
  String username;
  String name;
  String email;
  DateTime createdAt;
  DateTime updatedAt;
  dynamic phone;
  dynamic avatar;
  dynamic deviceToken;
  dynamic device;
  dynamic os;
  dynamic appVersion;
  String balance;

  UserData({
    required this.id,
    required this.username,
    required this.name,
    required this.email,
    required this.createdAt,
    required this.updatedAt,
    required this.phone,
    required this.avatar,
    required this.deviceToken,
    required this.device,
    required this.os,
    required this.appVersion,
    required this.balance,
  });

  factory UserData.fromJson(Map<String, dynamic> json) => UserData(
    id: json["id"],
    username: json["username"],
    name: json["name"],
    email: json["email"],
    createdAt: DateTime.parse(json["created_at"]),
    updatedAt: DateTime.parse(json["updated_at"]),
    phone: json["phone"],
    avatar: json["avatar"],
    deviceToken: json["device_token"],
    device: json["device"],
    os: json["os"],
    appVersion: json["app_version"],
    balance: json["balance"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "username": username,
    "name": name,
    "email": email,
    "created_at": createdAt.toIso8601String(),
    "updated_at": updatedAt.toIso8601String(),
    "phone": phone,
    "avatar": avatar,
    "device_token": deviceToken,
    "device": device,
    "os": os,
    "app_version": appVersion,
    "balance": balance,
  };
}
