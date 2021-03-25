import 'package:cloud_9_agent/provider/utility_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';

class WalletCard extends StatelessWidget {
  final formatCurrency = NumberFormat.simpleCurrency(name: 'TZS',locale: 'en_TZ');
  @override
  Widget build(BuildContext context) {
    UtilityProvider _utilityProvider = Provider.of<UtilityProvider>(context);
    return Container(
      width: MediaQuery.of(context).size.width,
      height: 200,
      decoration: BoxDecoration(
          color: Colors.blue,
          borderRadius: BorderRadius.all(Radius.circular(20))),
      child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
        Text(
          'Total Amount',
          style: TextStyle(
              color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),
        ),
        Text(
          '${formatCurrency.format(_utilityProvider.myWallet.amount)} /-',
          style: TextStyle(color: Colors.white, fontSize: 20),
        )
      ]),
    );
  }
}
