import 'package:bloc/bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:meta/meta.dart';
import 'package:sandbox_prometeo/core/movements/domain.dart';

part 'movements_event.dart';
part 'movements_state.dart';

@injectable
class MovementsBloc extends Bloc<MovementsEvent, MovementsState> {
  final MovementRepository movementRepository;

  MovementsBloc(
    this.movementRepository,
  ) : super(MovementsState()) {
    on<MovementsRequested>(_onMovementsRequested);
  }

  Future<void> _onMovementsRequested(
    MovementsRequested event,
    Emitter<MovementsState> emit,
  ) async {
    emit(state.copyWith(isError: false, isLoading: true));
    final optionMovements =
        await movementRepository.getMovements(MovementsReqParams(
      productType: event.requiredParams.productType,
      productNumber: event.requiredParams.productNumber,
      authKey: event.requiredParams.authKey,
      currency: event.requiredParams.currency,
      dateStart: event.requiredParams.dateStart,
      dateEnd: event.requiredParams.dateEnd,
    ));
    optionMovements.fold(
      (error) => emit(
        state.copyWith(
          errorMessage: error.toString(),
          isError: true,
          isLoading: false,
        ),
      ),
      (movements) => emit(
        state.copyWith(
          movements: movements,
          isLoading: false,
        ),
      ),
    );
  }
}
