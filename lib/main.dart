import 'dart:math';

import 'package:cyberpaysdkflutter/src/apis/CyberPayApi.dart';
import 'package:cyberpaysdkflutter/src/interface/transactionCallBack.dart';
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

                    TransactionRepository.getInstance(CyberPayApi()).beginTransactionApi(transactionModelToJson(_transModel)).then((result){

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


//import 'dart:convert';
//
//import 'package:flutter/material.dart';
//import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
//import 'package:letshegodemo/create_customer.dart';
//import 'package:letshegodemo/deposit.dart';
//import 'package:letshegodemo/loan_repayment.dart';
//import 'package:letshegodemo/repository/accountRepository.dart';
//
//import 'apis/letshego_api.dart';
//import 'model/customer_model.dart';
//import 'model/deposit_model.dart';
//
//void main() => runApp(MyApp());
//
//class MyApp extends StatelessWidget {
//  // This widget is the root of your application.
//  @override
//  Widget build(BuildContext context) {
//    return MaterialApp(
//      debugShowCheckedModeBanner: false,
//      title: 'Flutter Demo',
//      theme: ThemeData(
//        // This is the theme of your application.
//        //
//        // Try running your application with "flutter run". You'll see the
//        // application has a blue toolbar. Then, without quitting the app, try
//        // changing the primarySwatch below to Colors.green and then invoke
//        // "hot reload" (press "r" in the console where you ran "flutter run",
//        // or simply save your changes to "hot reload" in a Flutter IDE).
//        // Notice that the counter didn't reset back to zero; the application
//        // is not restarted.
//        primarySwatch: Colors.blue,
//      ),
//      home: MyHomePage(title: 'Flutter Demo Home Page'),
//    );
//  }
//}
//
//class MyHomePage extends StatefulWidget {
//  MyHomePage({Key key, this.title}) : super(key: key);
//
//  final String title;
//
//  @override
//  _MyHomePageState createState() => _MyHomePageState();
//}
//
//class _MyHomePageState extends State<MyHomePage> {
//
//  @override
//  Widget build(BuildContext context) {
//    return Scaffold(
//      appBar: AppBar(
//        elevation: 0,
//        backgroundColor: Colors.white,
//        title: Text('Letshego Demo',
//            style: TextStyle(color: Colors.black, fontSize: 16.0)),
//        actions: <Widget>[
//          Container(
//            margin: EdgeInsets.only(right: 8.0),
//            child: Row(
//              mainAxisAlignment: MainAxisAlignment.center,
//              crossAxisAlignment: CrossAxisAlignment.center,
//              children: <Widget>[
//                Text('Logout',
//                    style: TextStyle(
//                        color: Colors.red,
//                        fontWeight: FontWeight.w700,
//                        fontSize: 14.0)),
//                Icon(Icons.arrow_drop_down, color: Colors.black54)
//              ],
//            ),
//          )
//        ],
//      ),
//      body: StaggeredGridView.count(
//        crossAxisCount: 2,
//        crossAxisSpacing: 12.0,
//        mainAxisSpacing: 12.0,
//        padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
//        children: <Widget>[
//          _buildTile(Padding(
//            padding: const EdgeInsets.all(24.0),
//            child: Row(
//                mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                crossAxisAlignment: CrossAxisAlignment.center,
//                children: <Widget>[
//                  Column(
//                    mainAxisAlignment: MainAxisAlignment.center,
//                    crossAxisAlignment: CrossAxisAlignment.start,
//                    children: <Widget>[
//                      Text('Loans collected',
//                          style: TextStyle(color: Colors.blueAccent)),
//                      Text('2k',
//                          style: TextStyle(
//                              color: Colors.black,
//                              fontWeight: FontWeight.w700,
//                              fontSize: 34.0))
//                    ],
//                  ),
//                  Material(
//                      color: Colors.blue,
//                      borderRadius: BorderRadius.circular(24.0),
//                      child: Center(
//                          child: Padding(
//                            padding: const EdgeInsets.all(16.0),
//                            child: Icon(Icons.verified_user,
//                                color: Colors.white, size: 30.0),
//                          )))
//                ]),
//          )),
//          _buildTile(
//              Padding(
//                padding: const EdgeInsets.all(24.0),
//                child: Column(
//                    mainAxisAlignment: MainAxisAlignment.start,
//                    crossAxisAlignment: CrossAxisAlignment.start,
//                    children: <Widget>[
//                      Material(
//                          color: Colors.teal,
//                          shape: CircleBorder(),
//                          child: Padding(
//                            padding: const EdgeInsets.all(16.0),
//                            child: Icon(Icons.account_balance_wallet,
//                                color: Colors.white, size: 30.0),
//                          )),
//                      Padding(padding: EdgeInsets.only(bottom: 16.0)),
//                      Text('Deposit',
//                          style: TextStyle(
//                              color: Colors.black,
//                              fontWeight: FontWeight.w700,
//                              fontSize: 16.0)),
//                      Text('Deposit funds for customers',
//                          style: TextStyle(color: Colors.black45)),
//                    ]),
//              ), onTap: () {
//            Navigator.push(
//              context,
//              MaterialPageRoute(builder: (context) => DepositScreen()),
//            );
//          }),
//          _buildTile(
//              Padding(
//                padding: const EdgeInsets.all(24.0),
//                child: Column(
//                    mainAxisAlignment: MainAxisAlignment.start,
//                    crossAxisAlignment: CrossAxisAlignment.start,
//                    children: <Widget>[
//                      Material(
//                          color: Colors.amber,
//                          shape: CircleBorder(),
//                          child: Padding(
//                            padding: EdgeInsets.all(16.0),
//                            child: Icon(Icons.account_balance,
//                                color: Colors.white, size: 30.0),
//                          )),
//                      Padding(padding: EdgeInsets.only(bottom: 16.0)),
//                      Text('Loan Collection',
//                          style: TextStyle(
//                              color: Colors.black,
//                              fontWeight: FontWeight.w700,
//                              fontSize: 16.0)),
//                      Text(
//                        'Collect loans on behalf of clients ',
//                        style: TextStyle(
//                          color: Colors.black45,
//                        ),
//                        maxLines: 2,
//                      ),
//                    ]),
//              ), onTap: () {
//            Navigator.push(
//              context,
//              MaterialPageRoute(builder: (context) => LoanRepaymentScreen()),
//            );
//          }),
//          _buildTile(
//              Padding(
//                padding: const EdgeInsets.all(24.0),
//                child: Row(
//                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                    crossAxisAlignment: CrossAxisAlignment.center,
//                    children: <Widget>[
//                      Column(
//                        mainAxisAlignment: MainAxisAlignment.center,
//                        crossAxisAlignment: CrossAxisAlignment.start,
//                        children: <Widget>[
//                          // Text('Shop Items', style: TextStyle(color: Colors.redAccent)),
//                          Text('Account Opening Form',
//                              style: TextStyle(
//                                  color: Colors.black,
//                                  fontWeight: FontWeight.w700,
//                                  fontSize: 16.0))
//                        ],
//                      ),
//                      Material(
//                          color: Colors.red,
//                          borderRadius: BorderRadius.circular(24.0),
//                          child: Center(
//                              child: Padding(
//                                padding: EdgeInsets.all(16.0),
//                                child: Icon(Icons.supervisor_account,
//                                    color: Colors.white, size: 30.0),
//                              )))
//                    ]),
//              ), onTap: () {
//            Navigator.push(
//              context,
//              MaterialPageRoute(builder: (context) => CreateCustomerScreen()),
//            );
//          }),
//          _buildTile(
//            _buildLogo(),
//          ),
//        ],
//        staggeredTiles: [
//          StaggeredTile.extent(2, 110.0),
//          StaggeredTile.extent(1, 220.0),
//          StaggeredTile.extent(1, 220.0),
//          StaggeredTile.extent(2, 110.0),
//          StaggeredTile.extent(2, 220.0),
//        ],
//      ),
//    );
//  }
//
//  Widget _buildTile(Widget child, {Function() onTap}) {
//    return Material(
//        elevation: 14.0,
//        borderRadius: BorderRadius.circular(12.0),
//        shadowColor: Color(0x802196F3),
//        child: InkWell(
//          // Do onTap() if it isn't null, otherwise do print()
//            onTap: onTap != null
//                ? () => onTap()
//                : () {
//              print('Not set yet');
//            },
//            child: child));
//  }
//
//  Widget _buildLogo() {
//    // ...
//    return DecoratedBox(
//      decoration: BoxDecoration(
//        image: DecorationImage(
//          image: AssetImage('images/logo.png'),
//          // ...
//        ),
//        // ...
//      ),
//    );
//    // ...
//  }
//}
