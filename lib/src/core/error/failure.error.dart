import 'package:equatable/equatable.dart';

abstract class Failure extends Equatable {
  final String message;

  const Failure(this.message);

  @override
  List<Object> get props => [message];
}

class ServerFailure extends Failure {
  const ServerFailure(super.message);
}

class ConnectionFailure extends Failure {
  const ConnectionFailure(super.message);
}

class DatabaseFailure extends Failure {
  const DatabaseFailure(super.message);
}

class CommonFailure extends Failure {
  const CommonFailure(super.message);
}

class TimeOutFailure extends Failure {
  const TimeOutFailure(super.message);
}

class ValidationFailure extends Failure {
  ValidationFailure(List<dynamic> messages)
      : super(
          messages.map((e) => e['message'] ?? "Unknown Error").join("\n"),
        );
}
