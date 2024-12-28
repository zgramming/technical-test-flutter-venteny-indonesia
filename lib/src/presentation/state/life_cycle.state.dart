import 'package:equatable/equatable.dart';

class LifeCycleState<T> extends Equatable {
  final bool isLoading;
  final bool isLoaded;
  final bool isFailed;

  final T? data;
  final String? message;
  const LifeCycleState({
    this.isLoading = false,
    this.isLoaded = false,
    this.isFailed = false,
    this.data,
    this.message,
  });

  // set loading
  LifeCycleState<T> loading() {
    return LifeCycleState<T>(
      isLoading: true,
      isLoaded: false,
      isFailed: false,
      data: null,
      message: null,
    );
  }

  // set loaded
  LifeCycleState<T> loaded(T data) {
    return LifeCycleState<T>(
      isLoading: false,
      isLoaded: true,
      isFailed: false,
      data: data,
      message: null,
    );
  }

  // set failed
  LifeCycleState<T> failed(String message) {
    return LifeCycleState<T>(
      isLoading: false,
      isLoaded: false,
      isFailed: true,
      data: null,
      message: message,
    );
  }

  // Reset state
  LifeCycleState<T> reset() {
    return LifeCycleState<T>(
      isLoading: false,
      isLoaded: false,
      isFailed: false,
      data: null,
      message: null,
    );
  }

  @override
  List<Object?> get props {
    return [
      isLoading,
      isLoaded,
      isFailed,
      data,
      message,
    ];
  }

  @override
  bool get stringify => true;

  LifeCycleState<T> copyWith({
    bool? isLoading,
    bool? isLoaded,
    bool? isFailed,
    T? data,
    String? message,
  }) {
    return LifeCycleState<T>(
      isLoading: isLoading ?? this.isLoading,
      isLoaded: isLoaded ?? this.isLoaded,
      isFailed: isFailed ?? this.isFailed,
      data: data ?? this.data,
      message: message ?? this.message,
    );
  }
}
