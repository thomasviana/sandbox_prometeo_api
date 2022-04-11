part of 'bank_products_bloc.dart';

class BankAccountsState {
  final List<BankAccount> bankAccounts;
  final List<CreditCard> creditCards;
  final bool isError;
  final bool isLoading;

  BankAccountsState({
    this.bankAccounts = const [],
    this.creditCards = const [],
    this.isError = false,
    this.isLoading = true,
  });

  BankAccountsState copyWith({
    List<BankAccount>? bankAccounts,
    List<CreditCard>? creditCards,
    bool? isError,
    bool? isLoading,
  }) {
    return BankAccountsState(
      bankAccounts: bankAccounts ?? this.bankAccounts,
      creditCards: creditCards ?? this.creditCards,
      isError: isError ?? this.isError,
      isLoading: isLoading ?? this.isLoading,
    );
  }
}
