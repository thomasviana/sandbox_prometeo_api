part of 'bank_accounts_bloc.dart';

class BankAccountsState {
  final List<BankAccount> bankAccounts;
  final bool isError;
  final bool isLoading;

  BankAccountsState({
    this.bankAccounts = const [],
    this.isError = false,
    this.isLoading = true,
  });

  BankAccountsState copyWith({
    List<BankAccount>? bankAccounts,
    bool? isError,
    bool? isLoading,
  }) {
    return BankAccountsState(
      bankAccounts: bankAccounts ?? this.bankAccounts,
      isError: isError ?? this.isError,
      isLoading: isLoading ?? this.isLoading,
    );
  }
}
