
import 'package:flutter/material.dart';

class TransactionObject {
  TransactionObject({ @required this.integrationKey, @required this.amount, @required this.customerEmail,@required this.liveMode});

  final String integrationKey;
  final String customerEmail;
  final double amount;
  final bool liveMode;

  bool isTransactionObjectFilled() {
    if(integrationKey.isNotEmpty && customerEmail.isNotEmpty ){
      return true;
    }
    return false;
  }


  Map<String, dynamic> toJson() =>
      {
        "integrationKey": integrationKey,
        "amount": amount,
        "customerEmail": customerEmail,
        "liveMode": liveMode
      };

}