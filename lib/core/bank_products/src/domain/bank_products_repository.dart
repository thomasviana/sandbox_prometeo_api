import 'package:dartz/dartz.dart';
import 'package:sandbox_prometeo/core/bank_products/domain.dart';

abstract class BankProductsRepository {
  Future<Option<List<BankAccount>>> getUserBankAccounts(String authKey);
  Future<Option<List<CreditCard>>> getUserCreditCards(String authKey);
}
