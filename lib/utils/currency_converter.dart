import 'package:flutter/foundation.dart';
import 'package:intl/intl.dart';

class CurrencyConverter {
  final int decimalDigits;
  final String currency;

  CurrencyConverter({@required this.decimalDigits, @required this.currency});
  String currencyCovertor({@required double amount}) {
    final formatter = NumberFormat.simpleCurrency(
        decimalDigits: decimalDigits, name: currency);
    return '${formatter.format(amount)} /-';
  }
}

///currency converter
CurrencyConverter currencyCovertor = CurrencyConverter(
  decimalDigits: 0,
  currency: 'TZ\t',
);
