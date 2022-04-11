import 'package:intl/intl.dart';

extension MyCurrencyFormat on num {
  static final _currencyWithPrefixSignAndSymbol =
      NumberFormat(' \$ #,##0;- \$ #,##0');
  static final _currencyZero = NumberFormat('\$ #,##0', 'en_US');

  String toCurrencyFormat() {
    return this == 0
        ? _currencyZero.format(this)
        : _currencyWithPrefixSignAndSymbol.format(this);
  }
}
