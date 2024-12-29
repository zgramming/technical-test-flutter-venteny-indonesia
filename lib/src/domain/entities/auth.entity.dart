import 'package:equatable/equatable.dart';

import '../../data/models/auth.model.dart';

class AuthEntity extends Equatable {
  final String? email;
  final String token;
  const AuthEntity({
    this.email,
    required this.token,
  });

  @override
  List<Object?> get props => [email, token];

  @override
  bool get stringify => true;

  factory AuthEntity.fromModel(AuthModel model) {
    return AuthEntity(
      email: model.email,
      token: model.token,
    );
  }

  AuthEntity copyWith({
    String? email,
    String? token,
  }) {
    return AuthEntity(
      email: email ?? this.email,
      token: token ?? this.token,
    );
  }
}
