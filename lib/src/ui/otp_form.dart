import 'package:cyberpaysdkflutter/src/models/otp_model.dart';
import 'package:cyberpaysdkflutter/ui/flutter_credit_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class OtpForm extends StatefulWidget {
  const OtpForm({
    Key key,
    this.otpNumber,
    @required this.onOtpModelChange,
    this.themeColor,
    this.textColor = Colors.black,
    this.cursorColor,
  }) : super(key: key);

  final String otpNumber;

  final void Function(OtpModel) onOtpModelChange;
  final Color themeColor;
  final Color textColor;
  final Color cursorColor;

  @override
  _OtpFormState createState() => _OtpFormState();
}

class _OtpFormState extends State<OtpForm> {
  String otpNumber;

  Color themeColor;

  void Function(OtpModel) onOtpModelChange;
  OtpModel otpModel;

  final MaskedTextController _otpController =
      MaskedTextController(mask: '0 0 0 0 0 0');

  FocusNode cvvFocusNode = FocusNode();

  void createOtpModel() {
    otpNumber = widget.otpNumber ?? '';

    otpModel = OtpModel(
      otpNumber,
    );
  }

  @override
  void initState() {
    super.initState();

    createOtpModel();

    onOtpModelChange = widget.onOtpModelChange;

    _otpController.addListener(() {
      setState(() {
        otpNumber = _otpController.text;
        otpModel.otpNumber = otpNumber;
        onOtpModelChange(otpModel);
      });
    });
  }

  @override
  void didChangeDependencies() {
    themeColor = widget.themeColor ?? Theme.of(context).primaryColor;
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: ThemeData(
        primaryColor: themeColor.withOpacity(0.8),
        primaryColorDark: themeColor,
      ),
      child: Form(
        child: Column(
          children: <Widget>[
            Container(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              margin: const EdgeInsets.only(left: 16, top: 16, right: 16),
              child: TextFormField(
                controller: _otpController,
                cursorColor: widget.cursorColor ?? themeColor,
                style: TextStyle(
                  color: widget.textColor,
                ),
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'OTP CODE',
                  hintText: 'x x x x x x',
                ),
                keyboardType: TextInputType.number,
                textInputAction: TextInputAction.next,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
