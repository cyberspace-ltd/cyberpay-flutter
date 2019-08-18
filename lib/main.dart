import 'dart:math';

import 'package:cyberpaysdkflutter/src/apis/CyberPayApi.dart';
import 'package:cyberpaysdkflutter/src/interface/transactionCallBack.dart';
import 'package:cyberpaysdkflutter/src/models/CardModel.dart';
import 'package:cyberpaysdkflutter/src/models/TransactionModel.dart';
import 'package:cyberpaysdkflutter/src/repository/TransactionRepository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_credit_card/credit_card_form.dart';
import 'package:flutter_credit_card/credit_card_model.dart';
import 'package:flutter_credit_card/flutter_credit_card.dart';

void main() => runApp(MySample());

class MySample extends StatefulWidget implements TransactionCallBack {
  @override
  State<StatefulWidget> createState() {
    return MySampleState();
  }

  @override
  void onOtpRequired(TransactionModel transaction) {
    // TODO: implement onOtpRequired
  }

  @override
  void onSecure3DMpgsRequired(TransactionModel transaction) {
    // TODO: implement onSecure3DMpgsRequired
  }

  @override
  void onSecure3dRequired(TransactionModel transaction) {
    // TODO: implement onSecure3dRequired
  }

  @override
  void onSuccess(String transactionReference) {
    // TODO: implement onSuccess
  }
}



class MySampleState extends State<MySample> {
  TextEditingController _amountController;

  String cardNumber = '';
  String expiryDate = '';
  String cardHolderName = '';
  String cvvCode = '';
  bool isCvvFocused = false;

  @override
  void initState() {
    super.initState();
    _amountController = TextEditingController();

  }

  @override
  void dispose() {
    _amountController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Cyber Pay Card',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Scaffold(
        resizeToAvoidBottomInset: true,
        body: SafeArea(
          child: Column(
            children: <Widget>[

              CreditCardWidget(
                cardNumber: cardNumber,
                expiryDate: expiryDate,
                cardHolderName: cardHolderName,
                cvvCode: cvvCode,
                showBackView: isCvvFocused,
              ),

              Padding(
                padding: const EdgeInsets.only(left: 16, top: 8, right: 16, bottom: 8),
                child: _buildAmountWidget(),
              ),
              Expanded(
                child: SingleChildScrollView(
                  child: CreditCardForm(
                    onCreditCardModelChange: onCreditCardModelChange,
                  ),
                ),
              ),
              new RaisedButton(
                color: Colors.blue,
                child: new Text(
                  "PAY",
                  style: TextStyle(color: Colors.white),
                ),
                onPressed: () {


                  var splitDate = expiryDate.split("/");




                  TransactionModel _transModel = TransactionModel(
                    merchantRef: Random(4324).toString(),
                    amount: int.parse(_amountController.text)* 100,
                    customerEmail: "ihowaonaro@gmail.com",
                    integrationKey: "d5355204f9cf495f853c8f8d26ada19b",
                    returnUrl: "https://www.google.com/",
                    customerMobile: "080234252524",
                    customerName: "Michael Shabba",
                    description:"Test transaction from Flutter SDK",
                  );

                  TransactionRepository.getInstance(CyberPayApi()).beginTransactionApi(transactionModelToJson(_transModel)).then((result){

                    var reference = result.data.transactionReference;

                    CardModel _charge = CardModel(
                        name: cardHolderName,
                        cardNumber: cardNumber,
                        expiryMonth: int.parse(splitDate[0]),
                        expiryYear: int.parse(splitDate[1]),
                        cvv: cvvCode,
                        reference: reference

                    );
                    TransactionRepository.getInstance(CyberPayApi()).chargeCardApi(cardModelToJson(_charge)).then((result){

                    });

                  });
//    AccountRepository.getInstance(LetSheGoApi())
//        .depositAmount(depositModelToJson(depositModel))
//        .then((result) {
//    setState(() {
//    isSubmitLoading = false;
//    });

//                  DepositReceipt _depositReceipt = DepositReceipt(
//                      accountName: _namesController.text,
//                      accountNumber: result.data.accountNumber,
//                      currentBalance: result.data.currentAmount.toString(),
//                      amountPayed: _depositAmountController.text
//                  );
//                  Navigator.push(
//                    context,
//                    MaterialPageRoute(
//                        builder: (context) => PrintScreen(depositReceipt: _depositReceipt,)),
//                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildAmountWidget() {
    return Container(
      child: TextFormField(
        autocorrect: false,
        keyboardType: TextInputType.number,
        decoration: defaultTextFieldInputDecoration(label: 'Amount'),
        maxLines: 1,
        controller: _amountController,
      ),
    );
  }
  InputDecoration defaultTextFieldInputDecoration(
      {String hint, String prefix, String label}) {
    return InputDecoration(
      border: new OutlineInputBorder(
          borderSide:
          new BorderSide(color: const Color(0xFFE0E0E0), width: 0.1)),
      hintText: hint,
      labelText: label,
      prefixText: prefix,
    );
  }

  void onCreditCardModelChange(CreditCardModel creditCardModel) {
    setState(() {
      cardNumber = creditCardModel.cardNumber;
      expiryDate = creditCardModel.expiryDate;
      cardHolderName = creditCardModel.cardHolderName;
      cvvCode = creditCardModel.cvvCode;
      isCvvFocused = creditCardModel.isCvvFocused;
    });
  }
}