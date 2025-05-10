
import 'dart:convert';
import 'package:hive/hive.dart';
part 'token.g.dart';
@HiveType(typeId: 0)
class Token extends HiveObject {
  @HiveField(0)
  final String jwtToken;

  Token({
    required this.jwtToken,
  });

  Token copyWith({
    String? jwtToken,
  }) =>
      Token(
        jwtToken: jwtToken ?? this.jwtToken,
      );

  factory Token.fromRawJson(String str) => Token.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Token.fromJson(Map<String, dynamic> json) => Token(
        jwtToken: json["jwt_token"],
      );

  Map<String, dynamic> toJson() => {
        "jwt_token": jwtToken,
      };
}