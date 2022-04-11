part of 'bank_products_bloc.dart';

abstract class BankAccountsEvent {}

class UserBankAccountsRequested extends BankAccountsEvent {
  final String authKey;
  UserBankAccountsRequested({
    required this.authKey,
  });
}
