import 'package:flutter_bloc/flutter_bloc.dart';

import '../../domain/entities/auth.entity.dart';
import '../../domain/usecase/login.usecase.dart';
import '../../domain/usecase/logout.usecase.dart';

abstract class AuthState {}

class AuthStateInitial extends AuthState {}

class AuthStateLoading extends AuthState {}

class AuthStateSuccess extends AuthState {
  final AuthEntity auth;
  AuthStateSuccess(this.auth);
}

class AuthStateError extends AuthState {
  final String message;
  AuthStateError(this.message);
}

class AuthCubit extends Cubit<AuthState> {
  final LoginUseCase loginUseCase;
  final LogoutUseCase logoutUseCase;
  AuthCubit({
    required this.loginUseCase,
    required this.logoutUseCase,
  }) : super(AuthStateInitial());

  void login(String email, String password) async {
    emit(AuthStateLoading());

    final result = await loginUseCase(email, password);

    // Add delay for loading state
    await Future.delayed(const Duration(seconds: 1));

    result.fold(
      (failure) => emit(AuthStateError(failure.message)),
      (data) => emit(AuthStateSuccess(data)),
    );
  }

  void logout() async {
    emit(AuthStateLoading());

    final result = await logoutUseCase();

    result.fold(
      (failure) => emit(AuthStateError(failure.message)),
      (_) => emit(AuthStateSuccess(const AuthEntity(token: ""))),
    );
  }
}
