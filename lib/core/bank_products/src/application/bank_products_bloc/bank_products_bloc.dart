import 'package:bloc/bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:sandbox_prometeo/core/bank_products/domain.dart';

part 'bank_products_event.dart';
part 'bank_products_state.dart';

@injectable
class BankProductsBloc extends Bloc<BankAccountsEvent, BankAccountsState> {
  final BankProductsRepository accountRepository;

  BankProductsBloc(
    this.accountRepository,
  ) : super(BankAccountsState()) {
    on<UserBankAccountsRequested>(_onUserBankAccountsRequested);
  }

  Future<void> _onUserBankAccountsRequested(
    UserBankAccountsRequested event,
    Emitter<BankAccountsState> emit,
  ) async {
    emit(state.copyWith(isError: false, isLoading: true));
    List<BankAccount> _accounts = [];
    List<CreditCard> _creditCards = [];

    await accountRepository.getUserBankAccounts(event.authKey).then(
        ((value) => value.fold(() {}, (accounts) => _accounts = accounts)));

    await accountRepository.getUserCreditCards(event.authKey).then(((value) =>
        value.fold(() {}, (creditCards) => _creditCards = creditCards)));

    emit(
      state.copyWith(
        bankAccounts: _accounts,
        creditCards: _creditCards,
        isLoading: false,
      ),
    );
  }
}
