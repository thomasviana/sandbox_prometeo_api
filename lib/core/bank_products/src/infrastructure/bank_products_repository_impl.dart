import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:http/http.dart' as http;
import 'package:injectable/injectable.dart';
import 'package:sandbox_prometeo/keys/keys.dart';

import '../../domain.dart';

@LazySingleton(as: BankProductsRepository)
class BankProductsRepositoryImpl implements BankProductsRepository {
  static const String prometeoUrl = 'https://banking.sandbox.prometeoapi.com';
  static const String prometeoApiKey = PROMETEO_API_KEY;

  @override
  Future<Option<List<BankAccount>>> getUserBankAccounts(String authKey) async {
    try {
      final response = await http.get(
        Uri.parse(prometeoUrl + '/account/?key=$authKey'),
        headers: <String, String>{
          'Accept': 'application/json',
          'X-API-Key': prometeoApiKey,
        },
      );
      final status = jsonDecode(response.body)['status'] as String;
      if (status == 'error') {
        return const None();
      } else {
        final parsed = jsonDecode(response.body)['accounts'] as List;
        final bankAccounts = parsed.map((e) => BankAccount.fromMap(e)).toList();
        return some(bankAccounts);
      }
    } catch (error) {
      throw Exception('Error getting posts from server: $error');
    }
  }

  @override
  Future<Option<List<CreditCard>>> getUserCreditCards(String authKey) async {
    try {
      final response = await http.get(
        Uri.parse(prometeoUrl + '/credit-card/?key=$authKey'),
        headers: <String, String>{
          'Accept': 'application/json',
          'X-API-Key': prometeoApiKey,
        },
      );
      final status = jsonDecode(response.body)['status'] as String;
      if (status == 'error') {
        return const None();
      } else {
        final parsed = jsonDecode(response.body)['credit_cards'] as List;
        final creditCards = parsed.map((e) => CreditCard.fromMap(e)).toList();
        return some(creditCards);
      }
    } catch (error) {
      throw Exception('Error getting posts from server: $error');
    }
  }
}
