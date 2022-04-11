import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sandbox_prometeo/common/extensions.dart';
import 'package:sandbox_prometeo/core/movements/application.dart';
import 'package:sandbox_prometeo/core/movements/domain.dart';

import '../../core/auth/application.dart';

class MovementsScreen extends StatefulWidget {
  final String productType;
  final String productNumber;
  final String currency;
  const MovementsScreen({
    Key? key,
    required this.productType,
    required this.productNumber,
    required this.currency,
  }) : super(key: key);

  @override
  State<MovementsScreen> createState() => _MovementsScreenState();
}

class _MovementsScreenState extends State<MovementsScreen> {
  late MovementsBloc bloc;

  @override
  void initState() {
    final authKey = context.read<AuthBloc>().state.authKey;
    bloc = context.read<MovementsBloc>()
      ..add(
        MovementsRequested(
          requiredParams: MovementsReqParams(
            productType: widget.productType,
            productNumber: widget.productNumber,
            authKey: authKey,
            currency: widget.currency,
            dateStart: '01/01/2020',
            dateEnd: '05/01/2020',
          ),
        ),
      );

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Movements'),
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
          return BlocBuilder<MovementsBloc, MovementsState>(
            builder: (context, state) {
              if (state.isLoading) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              } else if (state.isError) {
                return Center(
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      children: [
                        const Text('Error:'),
                        Text(state.errorMessage),
                      ],
                    ),
                  ),
                );
              } else {
                return ListView.separated(
                  itemBuilder: ((context, index) {
                    final movement = state.movements[index];
                    return ListTile(
                      title: Text(movement.detail),
                      subtitle: Text(movement.reference),
                      trailing: Column(
                        children: [
                          Text(movement.amount.toCurrencyFormat()),
                          Text(movement.date),
                        ],
                      ),
                    );
                  }),
                  separatorBuilder: (context, index) =>
                      const SizedBox(height: 8),
                  itemCount: state.movements.length,
                );
              }
            },
          );
        },
      ),
    );
  }
}
