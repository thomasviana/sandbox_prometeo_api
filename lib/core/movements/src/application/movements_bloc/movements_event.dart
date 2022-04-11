part of 'movements_bloc.dart';

@immutable
abstract class MovementsEvent {}

class MovementsRequested extends MovementsEvent {
  final MovementsReqParams requiredParams;
  MovementsRequested({
    required this.requiredParams,
  });
}
