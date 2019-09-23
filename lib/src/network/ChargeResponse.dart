// To parse this JSON data, do
//
//     final cardPaymentResponse = cardPaymentResponseFromJson(jsonString);

import 'dart:convert';

CardPaymentResponse cardPaymentResponseFromJson(String str) =>
    CardPaymentResponse.fromJson(json.decode(str));

String cardPaymentResponseToJson(CardPaymentResponse data) =>
    json.encode(data.toJson());

class CardPaymentResponse {
  String code;
  bool succeeded;
  Data data;
  String message;

  CardPaymentResponse({
    this.code,
    this.succeeded,
    this.data,
    this.message,
  });

  factory CardPaymentResponse.fromJson(Map<String, dynamic> json) =>
      new CardPaymentResponse(
        code: json["code"],
        succeeded: json["succeeded"],
        data: json["data"] == null ? null : Data.fromJson(json["data"]),
        message: json["message"] == null ? null : json["message"],
      );

  Map<String, dynamic> toJson() => {
        "code": code,
        "succeeded": succeeded,
        "data": data == null ? null : data.toJson(),
        "message": message == null ? null : message,
      };
}

class Data {
  String transactionReference;
  String reference;
  String status;
  String message;
  String reason;
  String adviceTransactionType;
  String responseAction;
  String redirectUrl;


  Data({
    this.transactionReference,
    this.reference,
    this.status,
    this.message,
    this.redirectUrl,
    this.reason,
    this.adviceTransactionType,
    this.responseAction,
  });

  factory Data.fromJson(Map<String, dynamic> json) => new Data(
    transactionReference: json["transactionReference"],
        reference: json["reference"],
        status: json["status"],
        redirectUrl: json["redirectUrl"],
        message: json["message"],
        reason: json["reason"],
        adviceTransactionType: json["adviceTransactionType"],
        responseAction: json["responseAction"],
      );

  Map<String, dynamic> toJson() => {
    "transactionReference": transactionReference,
        "reference": reference,
        "status": status,
        "redirectUrl": redirectUrl,
        "message": message,
        "reason": reason,
        "adviceTransactionType": adviceTransactionType,
        "responseAction": responseAction,
      };
}
