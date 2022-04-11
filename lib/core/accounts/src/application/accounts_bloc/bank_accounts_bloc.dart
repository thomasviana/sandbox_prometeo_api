import 'package:bloc/bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:meta/meta.dart';
import 'package:sandbox_prometeo/core/accounts/domain.dart';

part 'bank_accounts_event.dart';
part 'bank_accounts_state.dart';

@injectable
class BankAccountsBloc extends Bloc<BankAccountsEvent, BankAccountsState> {
  final BankAccountRepository accountRepository;

  BankAccountsBloc(
    this.accountRepository,
  ) : super(BankAccountsState()) {
    on<UserBankAccountsRequested>(_onUserBankAccountsRequested);
  }

  Future<void> _onUserBankAccountsRequested(
    UserBankAccountsRequested event,
    Emitter<BankAccountsState> emit,
  ) async {
    emit(state.copyWith(isError: false, isLoading: true));
    final userAccounts =
        await accountRepository.getUserBankAccounts(event.authKey);
    userAccounts.fold(
      () => emit(
        state.copyWith(
          isError: true,
          isLoading: false,
        ),
      ),
      (accounts) => emit(
        state.copyWith(
          bankAccounts: accounts,
          isLoading: false,
        ),
      ),
    );
  }
}
