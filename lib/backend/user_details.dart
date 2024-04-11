import 'package:cloud_firestore/cloud_firestore.dart';

class UserDetails {
  String account;
  String password;
  Timestamp createdOn;

  UserDetails({
    required this.account,
    required this.password,
    required this.createdOn,
  });

  UserDetails.fromJson(Map<String, Object?> json)
      : this(
          account: json["account"]! as String,
          password: json["password"]! as String,
          createdOn: json['createdOn']! as Timestamp,
        );

  UserDetails copyWith({
    String? account,
    String? password,
  }) {
    return UserDetails(
      account: account ?? this.account,
      password: password ?? this.password,
      createdOn: createdOn ?? this.createdOn,
    );
  }

  Map<String, Object> toJson() {
    return {
      "account": account,
      "password": password,
      "createdOn": createdOn,
    };
  }
}
