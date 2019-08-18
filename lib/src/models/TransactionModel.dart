// To parse this JSON data, do
//
//     final transactionModel = transactionModelFromJson(jsonString);

import 'dart:convert';

TransactionModel transactionModelFromJson(String str) => TransactionModel.fromJson(json.decode(str));

String transactionModelToJson(TransactionModel data) => json.encode(data.toJson());

class TransactionModel {
  String currency = 'NGN';
  String merchantRef;
  int amount;
  String description;
  String customerId;
  String customerName;
  String customerEmail;
  String customerMobile;
  String returnUrl;
  String integrationKey;
  String productCode;
  String channel;
  List<Split> splits;

  TransactionModel({
    this.merchantRef,
    this.amount,
    this.description,
    this.customerId,
    this.customerName,
    this.customerEmail,
    this.customerMobile,
    this.returnUrl,
    this.integrationKey,
    this.productCode,
    this.channel,
    //this.splits,
  });

  factory TransactionModel.fromJson(Map<String, dynamic> json) => TransactionModel(
    merchantRef: json["merchantRef"],
    amount: json["amount"],
    description: json["description"],
    customerId: json["customerId"],
    customerName: json["customerName"],
    customerEmail: json["customerEmail"],
    customerMobile: json["customerMobile"],
    returnUrl: json["returnUrl"],
    integrationKey: json["integrationKey"],
    productCode: json["productCode"],
    channel: json["channel"],
    //splits: List<Split>.from(json["splits"].map((x) => Split.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "currency": currency,
    "merchantRef": merchantRef,
    "amount": amount,
    "description": description,
    "customerId": customerId,
    "customerName": customerName,
    "customerEmail": customerEmail,
    "customerMobile": customerMobile,
    "returnUrl": returnUrl,
    "integrationKey": integrationKey,
    "productCode": productCode,
    "channel": channel,
    //"splits": List<dynamic>.from(splits.map((x) => x.toJson())),
  };
}

class Split {
  String walletCode;
  int amount;
  bool shouldDeductFrom;

  Split({
    this.walletCode,
    this.amount,
    this.shouldDeductFrom,
  });

  factory Split.fromJson(Map<String, dynamic> json) => Split(
    walletCode: json["walletCode"],
    amount: json["amount"],
    shouldDeductFrom: json["shouldDeductFrom"],
  );

  Map<String, dynamic> toJson() => {
    "walletCode": walletCode,
    "amount": amount,
    "shouldDeductFrom": shouldDeductFrom,
  };
}
