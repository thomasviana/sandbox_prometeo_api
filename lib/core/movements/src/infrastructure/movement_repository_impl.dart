import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:injectable/injectable.dart';
import 'package:sandbox_prometeo/core/movements/domain.dart';
import 'package:sandbox_prometeo/keys/keys.dart';

@LazySingleton(as: MovementRepository)
class MovementRepositoryImpl implements MovementRepository {
  static const String prometeoUrl = 'https://banking.sandbox.prometeoapi.com';
  static const String prometeoApiKey = PROMETEO_API_KEY;

  @override
  Future<Either<ErrorDescription, List<Movement>>> getMovements(
      MovementsReqParams requiredParams) async {
    final movementQuery =
        requiredParams.productType == 'account' ? 'movement/' : 'movements';
    final currencyQuery = requiredParams.currency.isNotEmpty
        ? 'currency=${requiredParams.currency}'
        : '';
    try {
      final response = await http.get(
        Uri.parse(
          prometeoUrl +
              '/${requiredParams.productType}/${requiredParams.productNumber}/$movementQuery?key=${requiredParams.authKey}&$currencyQuery&date_start=${requiredParams.dateStart}&date_end=${requiredParams.dateEnd}',
        ),
        headers: <String, String>{
          'Accept': 'application/json',
          'X-API-Key': prometeoApiKey,
        },
      );
      final status = jsonDecode(response.body)['status'] as String;
      if (status == 'error') {
        final errorMessage = jsonDecode(response.body)['message'] as String;
        return left(ErrorDescription(errorMessage));
      } else {
        final parsed = jsonDecode(response.body)['movements'] as List;
        final movements = parsed.map((e) => Movement.fromMap(e)).toList();
        return right(movements);
      }
    } catch (error) {
      throw Exception('Error getting posts from server: $error');
    }
  }
}
