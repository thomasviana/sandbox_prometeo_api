part of 'movements_bloc.dart';

class MovementsState {
  final List<Movement> movements;
  final String errorMessage;
  final bool isError;
  final bool isLoading;

  MovementsState({
    this.movements = const [],
    this.errorMessage = '',
    this.isError = false,
    this.isLoading = true,
  });

  MovementsState copyWith({
    List<Movement>? movements,
    String? errorMessage,
    bool? isError,
    bool? isLoading,
  }) {
    return MovementsState(
      movements: movements ?? this.movements,
      errorMessage: errorMessage ?? this.errorMessage,
      isError: isError ?? this.isError,
      isLoading: isLoading ?? this.isLoading,
    );
  }
}
