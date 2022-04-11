import 'package:dartz/dartz.dart';
import 'package:flutter/foundation.dart';
import 'package:sandbox_prometeo/core/movements/src/domain/movement.dart';

import 'movements_req_params.dart';

abstract class MovementRepository {
  Future<Either<ErrorDescription, List<Movement>>> getMovements(
      MovementsReqParams requiredParams);
}
