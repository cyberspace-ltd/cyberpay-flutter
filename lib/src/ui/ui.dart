import 'dart:math';

import 'package:cyberpaysdkflutter/src/apis/CyberPayApi.dart';
import 'package:cyberpaysdkflutter/src/models/TransactionModel.dart';
import 'package:flutter/material.dart';
class CreateCustomerScreen extends StatefulWidget {
  @override
  State createState() => _CreateCustomerScreenState();
}

class _CreateCustomerScreenState extends State<CreateCustomerScreen> {
  static TextEditingController _amount;
  static TextEditingController _cardNumber;
  static TextEditingController _expDate;
  static TextEditingController _cvv;
  CyberPayApi _api = CyberPayApi();


  @override
  void initState() {
    _amount = TextEditingController();
    _cardNumber = TextEditingController();
    _expDate = TextEditingController();
    _cvv = TextEditingController();
    super.initState();
  }

  /*TransactionModel _transModel = TransactionModel(
    merchantRef: Random(4324).toString(),
    amount: int.parse(_amount.text),
    customerEmail: "ihowaonaro@gmail.com",
    integrationKey: "d5355204f9cf495f853c8f8d26ada19b",
    returnUrl: "https://www.google.com/",
    customerMobile: "080234252524",
    customerName: "Mich Shabba",
    description:"Hello",
  );*/


  @override
  void dispose() {
    _amount.dispose();
    _cardNumber.dispose();
    _expDate.dispose();
    _cvv.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('CyberPay-Flutter'),
      ),
      body: Column(
        children: <Widget>[
          TextField(
            controller: _amount,
            decoration: InputDecoration(
              labelText: "Amount"
            ),
          ),
          TextField(
            controller: _cardNumber,
            decoration: InputDecoration(
                labelText: "Card Number"
            ),
          ),
          Row(
            children: <Widget>[
              TextField(
                controller: _expDate,
                decoration: InputDecoration(
                    labelText: "Amount"
                ),
              ),
              TextField(
                controller: _cvv,
                decoration: InputDecoration(
                    labelText: "Amount"
                ),
              ),
            ],
          ),
          RaisedButton(
            child: Text("Pay", style: TextStyle(color: Colors.white),),
            onPressed: null,//() => _api.beginTransaction(transactionModelToJson(_transModel)),
            color: Colors.blueAccent,
          ),
        ],
      ),
        
    );
  }
}