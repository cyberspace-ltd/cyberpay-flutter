import 'dart:math';
import 'package:cyberpay_flutterplugin/model/transaction_model.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';

import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

import 'utils/flushbar_helper.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}



class _MyHomePageState extends State<MyHomePage> {
  TransactionObject transactionObject = TransactionObject(
      integrationKey: 'd5355204f9cf495f853c8f8d26ada19b',
      amount: 70000,
      customerEmail: "shabaokare@gmail.com",
      liveMode: false);
  double amount = 10000;
  bool isSubmitLoading = false;

  static const platform = const MethodChannel('com.startCyberPay/Channel');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text("CyberPay"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[],
        ),
      ),
      floatingActionButton:
          _buildSubmitButton(), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }

  _buildSubmitButton() {
    var ctaText = '';
//    if (state is BookingFormUpdated) {
    ctaText = 'Book - ₦${NumberFormat("###.0#", "en_US").format(amount ?? 0)}';
//    } else {
//      ctaText = 'Book - ₦${NumberFormat("###.0#", "en_US").format(0)}';
//    }
    return Container(
      margin: EdgeInsets.fromLTRB(0, 0, 0, 0),
      height: 44,
      child: FlatButton(
        disabledColor: Colors.blueGrey[300],
        // disabledTextColor: Colors.blueGrey[900],
        color: Colors.blueGrey[900],
        onPressed: () async {
          String response = "";
          try {
            final String result = await platform.invokeMethod(
                'chargeCard', transactionObject.toJson());

            response = result;
          } on PlatformException catch (e) {
            response = "Failed to Invoke: '${e.message}'.";
          }
        },

        // child:
        child: _buildTripButtonChild(false, ctaText),
      ),
    );
  }

  Widget _buildTripButtonChild(bool state, String text) {
    if (state == true) {
      return SpinKitThreeBounce(
        color: Colors.white,
        size: 20,
      );
    } else {
      return Text(
        text,
        style: TextStyle(color: Colors.white, fontWeight: FontWeight.w600),
      );
    }
  }

  @override
  void initState() {
    super.initState();

    platform.setMethodCallHandler((call) {
      final String argument = call.arguments;
      switch (call.method) {
        case "onSuccess":

        print("SUCCESS $argument");

          break;
      }
    });
  }
//  void onTransactionModelChange(TransactionObject transactionObject){
//    setState(() {
//      widget.customerEmail = transactionObject.customerEmail;
//      widget.liveMode = transactionObject.liveMode;
//      widget.amount = transactionObject.amount;
//      widget.integrationKey = transactionObject.integrationKey;
//    });
//  }

}
