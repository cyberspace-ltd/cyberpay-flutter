//// To parse this JSON data, do
////
////     final cardModel = cardModelFromJson(jsonString);
//
//import 'dart:convert';
//
//import 'package:scoped_model/scoped_model.dart';
//
//CardModel cardModelFromJson(String str) => CardModel.fromJson(json.decode(str));
//
//String cardModelToJson(CardModel data) => json.encode(data.toJson());
//
//class CardModel extends Model {
//  String name;
//  int expiryMonth;
//  int expiryYear;
//  String cardNumber;
//  String cvv;
//  String otherInfo;
//  String reference = "";
//  String cardPin;
//  String channel;
//  String processCode;
//  int providerId;
//
//  CardModel({
//    this.name,
//    this.expiryMonth,
//    this.expiryYear,
//    this.cardNumber,
//    this.cvv,
//    this.otherInfo,
//    this.reference,
//    this.cardPin,
//    this.channel,
//    this.processCode,
//    this.providerId,
//  });
//
//  factory CardModel.fromJson(Map<String, dynamic> json) => CardModel(
//        name: json["name"],
//        expiryMonth: json["expiryMonth"],
//        expiryYear: json["expiryYear"],
//        cardNumber: json["cardNumber"],
//        cvv: json["cvv"],
//        otherInfo: json["otherInfo"],
//        reference: json["reference"],
//        cardPin: json["cardPin"],
//        channel: json["channel"],
//        processCode: json["processCode"],
//        providerId: json["providerId"],
//      );
//
//  Map<String, dynamic> toJson() => {
//        "name": name,
//        "expiryMonth": expiryMonth,
//        "expiryYear": expiryYear,
//        "cardNumber": cardNumber,
//        "cvv": cvv,
//        "otherInfo": otherInfo,
//        "reference": reference,
//        "cardPin": cardPin,
//        "channel": channel,
//        "processCode": processCode,
//        "providerId": providerId,
//      };
//}
