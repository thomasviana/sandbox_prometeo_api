import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sandbox_prometeo/common/extensions.dart';
import 'package:sandbox_prometeo/core/bank_products/application.dart';

import '../../core/auth/application.dart';

class BankProductsScreen extends StatefulWidget {
  const BankProductsScreen({Key? key}) : super(key: key);

  @override
  State<BankProductsScreen> createState() => _AccountsScreenState();
}

class _AccountsScreenState extends State<BankProductsScreen> {
  late BankProductsBloc bankAccountsBloc;

  @override
  void initState() {
    final authKey = context.read<AuthBloc>().state.authKey;
    bankAccountsBloc = context.read<BankProductsBloc>()
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
          if (state.status == LinkStatus.unlinked) {
            Navigator.pop(context);
          } else {}
        },
        builder: (context, state) {
          return BlocBuilder<BankProductsBloc, BankAccountsState>(
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
                return Column(
                  children: [
                    ListView.separated(
                      shrinkWrap: true,
                      itemBuilder: ((context, index) {
                        final account = state.bankAccounts[index];
                        return ListTile(
                          title: Text(account.name),
                          subtitle: Text(account.number),
                          trailing: Text(account.balance.toCurrencyFormat()),
                          onTap: () => Navigator.pushNamed(
                            context,
                            '/movements',
                            arguments: [
                              'account',
                              account.number,
                              account.currency
                            ],
                          ),
                        );
                      }),
                      separatorBuilder: (context, index) =>
                          const SizedBox(height: 8),
                      itemCount: state.bankAccounts.length,
                    ),
                    const Divider(height: 8),
                    ListView.separated(
                      shrinkWrap: true,
                      itemBuilder: ((context, index) {
                        final creditCard = state.creditCards[index];
                        return ListTile(
                          title: Text(creditCard.name),
                          subtitle: Text(creditCard.number),
                          trailing: Column(
                            children: [
                              Text(creditCard.balanceLocal.toCurrencyFormat()),
                              Text(creditCard.balanceDollar.toCurrencyFormat()),
                            ],
                          ),
                          onTap: () => Navigator.pushNamed(
                            context,
                            '/movements',
                            arguments: ['credit-card', creditCard.number, ''],
                          ),
                        );
                      }),
                      separatorBuilder: (context, index) =>
                          const SizedBox(height: 8),
                      itemCount: state.creditCards.length,
                    ),
                  ],
                );
              }
            },
          );
        },
      ),
    );
  }
}
