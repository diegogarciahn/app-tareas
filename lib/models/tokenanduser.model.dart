// To parse this JSON data, do
//
//     final tokenAndUser = tokenAndUserFromJson(jsonString);

import 'dart:convert';

TokenAndUser tokenAndUserFromJson(String str) => TokenAndUser.fromJson(json.decode(str));

String tokenAndUserToJson(TokenAndUser data) => json.encode(data.toJson());

class TokenAndUser {
    TokenAndUser({
        this.token,
        this.usuario,
    });

    String? token;
    String? usuario;

    factory TokenAndUser.fromJson(Map<String, dynamic> json) => TokenAndUser(
        token: json["token"],
        usuario: json["usuario"],
    );

    Map<String, dynamic> toJson() => {
        "token": token,
        "usuario": usuario,
    };
}
