import 'package:dartz/dartz.dart';

import '../../core/error/failure.error.dart';
import '../repositories/auth.repository.dart';

class LogoutUseCase {
  final AuthRepository repository;
  LogoutUseCase({
    required this.repository,
  });

  Future<Either<Failure, void>> call() {
    return repository.logout();
  }
}
