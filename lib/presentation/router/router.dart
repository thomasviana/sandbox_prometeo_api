import 'package:flutter/material.dart';
import 'package:sandbox_prometeo/presentation/screens/accounts_screen.dart';
import 'package:sandbox_prometeo/presentation/screens/auth_screen.dart';
import 'package:sandbox_prometeo/presentation/screens/transactions_screen.dart';

class AppRouter {
  static const AUTH_SCREEN = '/';
  static const ACCOUNTS_SCREEN = '/accounts';
  static const TRANSACTIONS_SCREEN = '/transactions';

  static Route routes(RouteSettings settings) {
    switch (settings.name) {
      case AUTH_SCREEN:
        return _buildRoute(const AuthScreen());

      case ACCOUNTS_SCREEN:
        return _buildRoute(const AccountsScreen());

      case TRANSACTIONS_SCREEN:
        return _buildRoute(const TransactionsScreen());

      default:
        throw ('This raoute name does not exist');
    }
  }

  static MaterialPageRoute _buildRoute(Widget screen) {
    return MaterialPageRoute(builder: (context) => screen);
  }
}
