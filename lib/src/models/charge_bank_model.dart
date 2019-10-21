import 'dart:convert';

ChargeBank chargeBankFromJson(String str) =>
    ChargeBank.fromJson(json.decode(str));

String chargeBankToJson(ChargeBank data) => json.encode(data.toJson());

class ChargeBank {
  String bankCode;
  String accountNumber;
  String reference;
  String accountName;
  String dateOfBirth;
  String bvn;

  ChargeBank({
    this.bankCode,
    this.accountNumber,
    this.reference,
    this.accountName,
    this.dateOfBirth,
    this.bvn,
  });

  factory ChargeBank.fromJson(Map<String, dynamic> json) => ChargeBank(
        bankCode: json["bankCode"],
        accountNumber: json["accountNumber"],
        reference: json["reference"],
        accountName: json["accountName"],
        dateOfBirth: json["dateOfBirth"],
        bvn: json["bvn"],
      );

  Map<String, dynamic> toJson() => {
        "bankCode": bankCode,
        "accountNumber": accountNumber,
        "reference": reference,
        "accountName": accountName,
        "dateOfBirth": dateOfBirth,
        "bvn": bvn,
      };
}
