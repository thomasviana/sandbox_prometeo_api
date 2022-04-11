import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sandbox_prometeo/common/extensions.dart';
import 'package:sandbox_prometeo/core/accounts/application.dart';

import '../../core/auth/application.dart';

class AccountsScreen extends StatefulWidget {
  const AccountsScreen({Key? key}) : super(key: key);

  @override
  State<AccountsScreen> createState() => _AccountsScreenState();
}

class _AccountsScreenState extends State<AccountsScreen> {
  late BankAccountsBloc bankAccountsBloc;

  @override
  void initState() {
    final authKey = context.read<AuthBloc>().state.authKey;
    bankAccountsBloc = context.read<BankAccountsBloc>()
      ..add(UserBankAccountsRequested(authKey: authKey));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Accounts'),
        actions: [
          IconButton(
            onPressed: () => context.read<AuthBloc>().add(LogoutRequested()),
            icon: const Icon(Icons.logout),
          )
        ],
      ),
      body: BlocConsumer<AuthBloc, AuthState>(
        listener: (context, state) {
          print(state.authKey);
          if (state.status == LinkStatus.unlinked) {
            Navigator.pop(context);
          } else {}
        },
        builder: (context, state) {
          return BlocBuilder<BankAccountsBloc, BankAccountsState>(
            builder: (context, state) {
              if (state.isLoading) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              } else if (state.isError) {
                return const Center(
                  child: Text('Error'),
                );
              } else {
                return ListView.separated(
                  itemBuilder: ((context, index) {
                    final account = state.bankAccounts[index];
                    return ListTile(
                      title: Text(account.name),
                      subtitle: Text(account.number),
                      trailing: Text(account.balance.toCurrencyFormat()),
                    );
                  }),
                  separatorBuilder: (context, index) =>
                      const SizedBox(height: 8),
                  itemCount: state.bankAccounts.length,
                );
              }
            },
          );
        },
      ),
    );
  }
}
