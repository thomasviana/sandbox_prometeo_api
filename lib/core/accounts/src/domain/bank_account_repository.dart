import 'package:dartz/dartz.dart';
import 'package:sandbox_prometeo/core/accounts/src/domain/bank_account.dart';

abstract class BankAccountRepository {
  Future<Option<List<BankAccount>>> getUserBankAccounts(String authKey);
}
