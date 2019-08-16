// To parse this JSON data, do
//
//     final bankModel = bankModelFromJson(jsonString);

import 'dart:convert';

BankModel bankModelFromJson(String str) => BankModel.fromJson(json.decode(str));

String bankModelToJson(BankModel data) => json.encode(data.toJson());

class BankModel {
  String bankCode;
  String accountNumber;
  String reference;
  String accountName;

  BankModel({
    this.bankCode,
    this.accountNumber,
    this.reference,
    this.accountName,
  });

  factory BankModel.fromJson(Map<String, dynamic> json) => BankModel(
    bankCode: json["bankCode"],
    accountNumber: json["accountNumber"],
    reference: json["reference"],
    accountName: json["accountName"],
  );

  Map<String, dynamic> toJson() => {
    "bankCode": bankCode,
    "accountNumber": accountNumber,
    "reference": reference,
    "accountName": accountName,
  };
}
