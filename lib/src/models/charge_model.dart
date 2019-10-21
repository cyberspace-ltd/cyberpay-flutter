// To parse this JSON data, do
//
//     final charge = chargeFromJson(jsonString);

import 'dart:convert';

Charge chargeFromJson(String str) => Charge.fromJson(json.decode(str));

String chargeToJson(Charge data) => json.encode(data.toJson());

class Charge {
  String returnUrl;
  String Otp;//only if otp is required
  String name;
  int expiryMonth;
  int expiryYear;
  String cardNumber;
  String cvv;
  String otherInfo;
  String reference;
  String cardPin;
  String channel;
  String processCode;
  int providerId;

  Charge({
    this.returnUrl,
    this.Otp,
    this.name,
    this.expiryMonth,
    this.expiryYear,
    this.cardNumber,
    this.cvv,
    this.otherInfo,
    this.reference,
    this.cardPin,
    this.channel,
    this.processCode,
    this.providerId,
  });

  factory Charge.fromJson(Map<String, dynamic> json) => Charge(
    returnUrl: json["returnUrl"],
    Otp: json["Otp"],
    name: json["name"],
    expiryMonth: json["expiryMonth"],
    expiryYear: json["expiryYear"],
    cardNumber: json["cardNumber"],
    cvv: json["cvv"],
    otherInfo: json["otherInfo"],
    reference: json["reference"],
    cardPin: json["cardPin"],
    channel: json["channel"],
    processCode: json["processCode"],
    providerId: json["providerId"],
  );

  Map<String, dynamic> toJson() => {
    "returnUrl": returnUrl,
    "Otp": Otp,
    "name": name,
    "expiryMonth": expiryMonth,
    "expiryYear": expiryYear,
    "cardNumber": cardNumber,
    "cvv": cvv,
    "otherInfo": otherInfo,
    "reference": reference,
    "cardPin": cardPin,
    "channel": channel,
    "processCode": processCode,
    "providerId": providerId,
  };
}
