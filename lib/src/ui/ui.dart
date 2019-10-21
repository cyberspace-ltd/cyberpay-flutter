import 'package:cyberpaysdkflutter/src/apis/CyberPayApi.dart';
import 'package:cyberpaysdkflutter/src/models/OtpRequestModel.dart';
import 'package:cyberpaysdkflutter/src/models/otp_model.dart';
import 'package:cyberpaysdkflutter/src/repository/TransactionRepository.dart';
import 'package:cyberpaysdkflutter/src/ui/otp_form.dart';
import 'package:cyberpaysdkflutter/src/ui/otp_widget.dart';
import 'package:cyberpaysdkflutter/src/utils/flushbar_helper.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  final CardModel transactionModel;

  HomeScreen({this.transactionModel});

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String otpNumber = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: SafeArea(
        child: Column(
          children: <Widget>[
            OtpWidget(
              otpNumber: otpNumber.trim(),
            ),
            Expanded(
              child: SingleChildScrollView(
                child: OtpForm(onOtpModelChange: onOtpModelChange),
              ),
            ),
            RaisedButton(
                color: Colors.blue,
                child: Text(
                  "Verify OTP",
                  style: TextStyle(color: Colors.white),
                ),
                onPressed: () async {
                  OtpRequestModel _otpModel = OtpRequestModel(
                      otp: otpNumber,
                      reference: widget.transactionModel.reference,
                      cardModel: widget.transactionModel);
                  widget.transactionModel.otp = otpNumber;

                  TransactionRepository.getInstance(CyberPayApi()).verifyOtpApi(
                      encodedBody: otpRequestModelToJson(_otpModel),
                      success: (success, message) {
                        var loadingBar = FlushbarHelper.createLoading(
                            message:
                                "Transaction successful: Transaction Ref: {$success}, {$message}",
                            linearProgressIndicator: null);
                        loadingBar..show(context);
                      },
                      error: (error) {
                        FlushbarHelper.createError(message: '$error')
                          ..show(context);
                      });
                }),
          ],
        ),
      ),
    );
  }

  void onOtpModelChange(OtpModel otpModel) {
    setState(() {
      otpNumber = otpModel.otpNumber.replaceAll(new RegExp(r"\s+\b|\b\s"), "");
    });
  }
}
