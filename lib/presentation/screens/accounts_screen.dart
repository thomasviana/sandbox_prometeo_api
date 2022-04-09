import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../core/auth/application.dart';

class AccountsScreen extends StatelessWidget {
  const AccountsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Transactions'),
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
          }
        },
        builder: (context, state) {
          return Center(
            child: Container(
              child: Text('AuthKey: ${state.authKey}'),
            ),
          );
        },
      ),
    );
  }
}
