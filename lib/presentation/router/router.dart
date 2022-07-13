import 'package:flutter/material.dart';
import 'package:sandbox_prometeo/presentation/screens/auth_screen.dart';
import 'package:sandbox_prometeo/presentation/screens/bank_products_screen.dart';
import 'package:sandbox_prometeo/presentation/screens/movements_screen.dart';
import 'package:sandbox_prometeo/presentation/screens/select_bank_screen.dart';

class AppRouter {
  static const SELECT_BANK = '/';
  static const AUTH_SCREEN = '/auth';
  static const ACCOUNTS_SCREEN = '/accounts';
  static const MOVEMENTS_SCREEN = '/movements';

  static Route routes(RouteSettings settings) {
    switch (settings.name) {
      case SELECT_BANK:
        return _buildRoute(const SelectBankScreen());

      case AUTH_SCREEN:
        final argument = settings.arguments! as String;
        return _buildRoute(AuthScreen(
          bank: argument,
        ));

      case ACCOUNTS_SCREEN:
        return _buildRoute(const BankProductsScreen());

      case MOVEMENTS_SCREEN:
        final arguments = settings.arguments! as List;
        return _buildRoute(MovementsScreen(
          productType: arguments[0],
          productNumber: arguments[1],
          currency: arguments[2],
        ));

      default:
        throw ('This raoute name does not exist');
    }
  }

  static MaterialPageRoute _buildRoute(Widget screen) {
    return MaterialPageRoute(builder: (context) => screen);
  }
}
