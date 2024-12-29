
import 'dart:convert';

import 'package:equatable/equatable.dart';

class AuthModel extends Equatable {
  final String? email;
  final String token;
  const AuthModel({
    this.email,
    required this.token,
  });

  @override
  List<Object?> get props => [email, token];

  @override
  bool get stringify => true;

  AuthModel copyWith({
    String? email,
    String? token,
  }) {
    return AuthModel(
      email: email ?? this.email,
      token: token ?? this.token,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'email': email,
      'token': token,
    };
  }

  factory AuthModel.fromMap(Map<String, dynamic> map) {
    return AuthModel(
      email: map['email'] != null ? map['email'] as String : null,
      token: map['token'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory AuthModel.fromJson(String source) =>
      AuthModel.fromMap(json.decode(source) as Map<String, dynamic>);
}