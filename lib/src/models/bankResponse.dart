// To parse this JSON data, do
//
//     final bankResponse = bankResponseFromJson(jsonString);

import 'dart:convert';

BankResponse bankResponseFromJson(String str) =>
    BankResponse.fromJson(json.decode(str));

String bankResponseToJson(BankResponse data) => json.encode(data.toJson());

class BankResponse {
  String code;
  bool succeeded;
  List<Datum> data;

  BankResponse({
    this.code,
    this.succeeded,
    this.data,
  });

  factory BankResponse.fromJson(Map<String, dynamic> json) => BankResponse(
        code: json["code"],
        succeeded: json["succeeded"],
        data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "code": code,
        "succeeded": succeeded,
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
      };
}

class Datum {
  String bankCode;
  String bankName;
  int id;

  Datum({
    this.bankCode,
    this.bankName,
    this.id,
  });

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        bankCode: json["bankCode"],
        bankName: json["bankName"],
        id: json["id"],
      );

  Map<String, dynamic> toJson() => {
        "bankCode": bankCode,
        "bankName": bankName,
        "id": id,
      };
}
