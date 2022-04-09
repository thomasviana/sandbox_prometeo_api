import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:sandbox_prometeo/dependency_injection.dart';
import 'package:sandbox_prometeo/presentation/router/router.dart';

import 'core/auth/application.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await configureInjection(Environment.prod);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          sl<AuthBloc>()..add(AuthRequiredParametersRequested()),
      child: MaterialApp(
        title: 'Sandbox Prometeo',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.amber,
        ),
        onGenerateRoute: AppRouter.routes,
      ),
    );
  }
}
