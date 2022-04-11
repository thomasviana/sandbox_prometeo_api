part of 'bank_accounts_bloc.dart';

@immutable
abstract class BankAccountsEvent {}

class UserBankAccountsRequested extends BankAccountsEvent {
  final String authKey;
  UserBankAccountsRequested({
    required this.authKey,
  });
}
