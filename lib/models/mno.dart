import 'package:flutter/material.dart';

class MNO {
  final String name;
  final List<String> instructions;

  MNO({@required this.name, @required this.instructions});
}

final List<MNO> automnoList = [
    MNO(name: 'M-Pesa', instructions: [
      '1. Dial *150*00#',
      '2. Choose 4 - Lipa by M-Pesa',
      '3. Choose 4 - Enter business number',
      '4. Enter 123123 (As Selcom Pay/Masterpass business number)',
      '5. Enter reference number (Pay Number)',
      '6. Enter amount',
      '7. Enter PIN',
      '8. You will receive confirmation SMS '
    ]),
    MNO(name: 'TigoPesa', instructions: [
      '1. Dial *150*01#',
      '2. Choose 5 - Lipia bidhaa',
      '3. Choose 2 - Pay by Matercard QR',
      '4. Enter reference number (Pay Number)',
      '5. Enter amount',
      '6. Enter PIN',
      '7. You will receive confirmation SMS'
    ]),
    MNO(name: 'AirtelMoney', instructions: [
      '1. Dial *150*60#',
      '2. Choose 5 - Make Payments',
      '3. Choose 1 - Merchant Payments',
      '4. Choose 1 - Pay with SelcomPay/Masterpass',
      '5. Enter Amount',
      '6. Enter the reference number (Pay Number)',
      '7. Enter PIN to confirm'
    ]),
    MNO(name: 'HaloPesa', instructions: [
      '1. Dial *150*88#',
      '2. Choose 5-Make Payments',
      '3. Choose 3 – Selcom Pay/Masterpass',
      '4. Enter Pay Number (Pay Number)',
      '5. Enter amount',
      '6. Enter PIN',
      '7. You will receive confirmation SMS'
    ]),
    MNO(name: 'EzyPesa', instructions: [
      '1. Dial *150*02#',
      '2. Choose 5 - Payments',
      '3. Choose 1 - Lipa Hapa',
      '4. Choose 2 - Pay by Masterpass QR',
      '5. Enter Merchant Number (Pay Number)',
      '6. Enter Amount',
      '7. Enter PIN',
      '8. You will receive confirmation SMS'
    ]),
    MNO(name: 'TTCLPesa', instructions: [
      '1. Dial *150*71#',
      '2. Choose 6 - Pay Merchant',
      '3. Choose 2 – SelcomPay/Masterpass',
      '4. Enter Pay Number (Pay Number)',
      '5. Enter amount',
      '6. Enter PIN',
      '7. You will receive confirmation SMS'
    ])
  ];