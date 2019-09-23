import 'dart:math';

import 'package:cyberpaysdkflutter/src/apis/CyberPayApi.dart';
import 'package:cyberpaysdkflutter/src/interface/transactionCallBack.dart';
import 'package:cyberpaysdkflutter/src/models/OtpRequestModel.dart';
import 'package:cyberpaysdkflutter/src/models/TransactionModel.dart';
import 'package:cyberpaysdkflutter/src/repository/TransactionRepository.dart';
import 'package:cyberpaysdkflutter/src/ui/ui.dart';
import 'package:cyberpaysdkflutter/src/utils/flushbar_helper.dart';
import 'package:cyberpaysdkflutter/ui/credit_card_model.dart';
import 'package:cyberpaysdkflutter/ui/flutter_credit_card.dart';
import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:url_launcher/url_launcher.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return MyAppState();
  }
}

class MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    final CardModel _model = CardModel();
    return ScopedModel<CardModel>(
      model: _model,
      child: MaterialApp(
        title: 'Cyber Pay Card',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: MyHomePage(),
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> with TransactionCallBack {
  TextEditingController _amountController;

  String cardNumber = '';
  String expiryDate = '';
  String cardHolderName = '';
  String cvvCode = '';
  String cardPin = '';
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
    return ScopedModelDescendant<CardModel>(
      builder: (BuildContext context, Widget child, CardModel model) {
        return Scaffold(
          resizeToAvoidBottomInset: true,
          body: SafeArea(
            child: Column(
              children: <Widget>[
                CreditCardWidget(
                  cardNumber: cardNumber.trim(),
                  expiryDate: expiryDate,
                  cardHolderName: cardHolderName,
                  cvvCode: cvvCode,
                  showBackView: isCvvFocused,
                  cardPin: cardPin,
                ),
                Padding(
                  padding: const EdgeInsets.only(
                      left: 16, top: 8, right: 16, bottom: 8),
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
                  onPressed: () async {
                    var loadingBar = FlushbarHelper.createLoading(
                        message: "Please wait...Transaction processing.",
                        linearProgressIndicator: LinearProgressIndicator())
                      ..show(context);
                    var splitDate = expiryDate.split("/");

                    var randomizer =
                        new Random(); // can get a seed as a parameter

                    // Integer between 0 and 100 (0 can be 100 not)
                    var num = randomizer.nextInt(1097640);
                    var numb = randomizer.nextInt(1096640);
                    String merch_reference =
                        'CYBEPAY' + num.toString() + numb.toString();

                    TransactionModel _transModel = TransactionModel(
                      merchantRef: merch_reference,
                      amount: int.parse(_amountController.text) * 100,
                      customerEmail: "ihowaonaro@gmail.com",
                      integrationKey: "d5355204f9cf495f853c8f8d26ada19b",
                      returnUrl: "https://www.google.com/",
                      customerMobile: "080234252524",
                      customerName: cardHolderName,
                      description: "Test transaction from Flutter SDK",
                    );

                    TransactionRepository.getInstance(CyberPayApi())
                        .beginTransactionApi(
                            transactionModelToJson(_transModel))
                        .then((result) {
                      loadingBar.dismiss(context);

                      var reference = result.data.transactionReference;
                      if (reference != null) {
                        CardModel _charge = CardModel(
                            name: cardHolderName,
                            cardNumber: cardNumber.replaceAll(
                                new RegExp(r"\s+\b|\b\s"), ""),
                            expiryMonth: int.parse(splitDate[0]),
                            expiryYear: int.parse(splitDate[1]),
                            cvv: cvvCode,
                            cardPin: cardPin,
                            reference: reference);
                        TransactionRepository.getInstance(CyberPayApi())
                            .chargeCardApi(cardModelToJson(_charge))
                            .then((cardResult) async {
                          var loadingBar = FlushbarHelper.createLoading(
                              message: cardResult.data.message,
                              linearProgressIndicator: null);
                          loadingBar..show(context);

                          if (cardResult.data.status == "Failed") {
                            var loadingBar = FlushbarHelper.createLoading(
                                message: cardResult.data.message,
                                linearProgressIndicator: null);
                            loadingBar..show(context);
                          }
                          if (cardResult.data.status == "Otp") {

                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => new HomeScreen(
                                      transactionModel: _charge)),
                            );
                          } else if (cardResult.data.status == "Success") {
                            var loadingBar = FlushbarHelper.createLoading(
                                message:
                                    "Transaction successful: Transaction Ref: {$reference}",
                                linearProgressIndicator: null);
                            loadingBar..show(context);
                          } else if (cardResult.data.status == "ProvidePin") {
                            var loadingBar = FlushbarHelper.createLoading(
                                message:
                                    "Transaction successful: Transaction Ref: {$reference}",
                                linearProgressIndicator: null);
                            loadingBar..show(context);
                          } else if (cardResult.data.status == "Successful") {
                            var loadingBar = FlushbarHelper.createLoading(
                                message:
                                    "Transaction successful: with Transaction Ref: {$reference}",
                                linearProgressIndicator: null);
                            loadingBar..show(context);
                          } else if (cardResult.data.status == "EnrollOtp") {

                          } else if (cardResult.data.status == "Secure3D") {
                            var url = cardResult.data.redirectUrl;
                            if (await canLaunch(url)) {
                              await launch(url);
                            }
                          } else if (cardResult.data.status == "Secure3DMpgs") {
                            var url = cardResult.data.redirectUrl;
                            if (await canLaunch(url)) {
                              await launch(url);
                            }
                          } else if (cardResult.data.status == "Successful") {
                            var loadingBar = FlushbarHelper.createLoading(
                                message:
                                "Transaction successful: Transaction Ref: {$reference}",
                                linearProgressIndicator: null);
                            loadingBar..show(context);
                          }

                          loadingBar.dismiss(context);
                        });
                      } else {
                        loadingBar = FlushbarHelper.createError(
                            message: "An Error Occured")
                          ..show(context);
                      }
                    });
                  },
                ),
              ],
            ),
          ),
        );
      },
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
      cardPin = creditCardModel.cardPin;
    });
  }
}
