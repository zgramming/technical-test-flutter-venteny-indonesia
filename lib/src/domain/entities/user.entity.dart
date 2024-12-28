import 'package:equatable/equatable.dart';

import '../../data/models/user.model.dart';

class UserEntity extends Equatable {
  final String? email;
  final String token;
  const UserEntity({
    this.email,
    required this.token,
  });

  @override
  List<Object?> get props => [email, token];

  @override
  bool get stringify => true;

  UserEntity copyWith({
    String? email,
    String? token,
  }) {
    return UserEntity(
      email: email ?? this.email,
      token: token ?? this.token,
    );
  }

  // Convert from UserModel to UserEntity
  factory UserEntity.fromModel(UserModel model) {
    return UserEntity(
      email: model.email,
      token: model.token,
    );
  }
}
