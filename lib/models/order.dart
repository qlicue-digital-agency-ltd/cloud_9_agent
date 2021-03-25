import 'package:cloud_9_agent/models/product.dart';
import 'package:cloud_9_agent/models/service.dart';
import 'package:cloud_9_agent/models/customer.dart';
import 'package:flutter/material.dart';

class Order {
  final int id;
  final String orderId;
  final String buyerEmail;
  final String buyerName;
  final String buyerPhone;
  final String amount;
  final String currency;
  final String noOfItems;
  final String orderFor;
  final String reference;
  final String result;
  final String resultCode;
  final String message;
  final String gatewayBuyerUuid;
  final String paymentToken;
  final String qr;
  final String paymentGatewayUrl;
  final String paymentStatus;
  final Client client;
  Product product;
  Service service;

  Order(
      {@required this.id,
      @required this.orderId,
      @required this.buyerEmail,
      @required this.buyerName,
      @required this.buyerPhone,
      @required this.amount,
      @required this.currency,
      @required this.noOfItems,
      @required this.orderFor,
      @required this.reference,
      @required this.result,
      @required this.resultCode,
      @required this.message,
      @required this.gatewayBuyerUuid,
      @required this.paymentToken,
      @required this.qr,
      @required this.paymentGatewayUrl,
      @required this.paymentStatus,
      @required this.client,
      this.product,
      this.service});

  Order.fromMap(Map<String, dynamic> map)
      : assert(map['id'] != null),
        assert(map['order_id'] != null),
        id = map['id'],
        orderId = map['order_id'].toString(),
        buyerEmail = map['buyer_email'].toString(),
        buyerName = map['buyer_name'].toString(),
        buyerPhone = map['buyer_phone'].toString(),
        amount = map['amount'].toString(),
        currency = map['currency'].toString(),
        noOfItems = map['no_of_items'].toString(),
        orderFor = map['order_for'].toString(),
        reference = map['reference'].toString(),
        result = map['result'].toString(),
        resultCode = map['result_code'].toString(),
        message = map['message'].toString(),
        gatewayBuyerUuid = map['gateway_buyer_uuid'].toString(),
        paymentToken = map['payment_token'].toString(),
        qr = map['qr'].toString(),
        paymentGatewayUrl = map['payment_gateway_url'].toString(),
        client = Client.fromMap(map['user']),
        product = map['orderable_type'] == "App\\Product"
            ? Product.fromMap(map['orderable'])
            : null,
        service = map['orderable_type'] != "App\\Product"
            ? Service.fromMap(map['orderable']['service'])
            : null,
        paymentStatus = map['payment_status'].toString();
}
