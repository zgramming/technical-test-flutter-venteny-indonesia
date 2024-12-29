import 'package:dartz/dartz.dart';

import '../../core/error/failure.error.dart';
import '../entities/auth.entity.dart';
import '../repositories/auth.repository.dart';

class LoginUseCase {
  final AuthRepository repository;
  LoginUseCase({
    required this.repository,
  });

  Future<Either<Failure, AuthEntity>> call(String email, String password) {
    return repository.login(email, password);
  }
}
