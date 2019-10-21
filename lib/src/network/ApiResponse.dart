// To parse this JSON data, do

//

//     final apiResponse = apiResponseFromJson(jsonString);
import 'dart:convert';

ApiResponse apiResponseFromJson(String str) =>
    ApiResponse.fromJson(json.decode(str));

String apiResponseToJson(ApiResponse data) => json.encode(data.toJson());

class ApiResponse {
  String code;

  bool succeeded;

  String message;

  Data data;

  ApiResponse({
    this.code,
    this.message,
    this.succeeded,
    this.data,
  });

  factory ApiResponse.fromJson(Map<String, dynamic> json) => ApiResponse(
        code: json["code"],
        message: json["message"] == null ? null : json["message"],
        succeeded: json["succeeded"],
        data: json["data"] == null ? null : Data.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "code": code,
        "message": message == null ? null : message,
        "succeeded": succeeded,
        "data": data == null ? null : data.toJson(),
      };
}

class Data {
  String transactionReference;

  int charge;

  String redirectUrl;

  Data({
    this.transactionReference,
    this.charge,
    this.redirectUrl,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        transactionReference: json["transactionReference"],
        charge: json["charge"],
        redirectUrl: json["redirectUrl"],
      );

  Map<String, dynamic> toJson() => {
        "transactionReference": transactionReference,
        "charge": charge,
        "redirectUrl": redirectUrl,
      };
}
