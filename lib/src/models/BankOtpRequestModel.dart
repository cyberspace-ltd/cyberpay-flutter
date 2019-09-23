// To parse this JSON data, do
//
//     final bankOtpRequestModel = bankOtpRequestModelFromJson(jsonString);

import 'dart:convert';

BankOtpRequestModel bankOtpRequestModelFromJson(String str) =>
    BankOtpRequestModel.fromJson(json.decode(str));

String bankOtpRequestModelToJson(BankOtpRequestModel data) =>
    json.encode(data.toJson());

class BankOtpRequestModel {
  String reference;
  String otp;

  BankOtpRequestModel({
    this.reference,
    this.otp,
  });

  factory BankOtpRequestModel.fromJson(Map<String, dynamic> json) =>
      BankOtpRequestModel(
        reference: json["reference"],
        otp: json["otp"],
      );

  Map<String, dynamic> toJson() => {
        "reference": reference,
        "otp": otp,
      };
}
