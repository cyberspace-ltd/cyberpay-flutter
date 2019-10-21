import 'package:cyberpaysdkflutter/src/models/cardModel.dart';
import 'package:cyberpaysdkflutter/src/models/charge_bank_model.dart';
import 'package:cyberpaysdkflutter/src/models/charge_model.dart';

typedef onSuccess = void Function(String ref, String message);

typedef onProvidePin = void Function(Charge charge);

typedef onOtpRequired = void Function(Charge charge, Card card);

typedef onBankOtpRequired = void Function(ChargeBank transaction);

typedef onSecure3dRequired = void Function(Charge transaction);

typedef onSecure3DMpgsRequired = void Function(Charge transaction);

typedef onEnrolOtp = void Function(Charge transaction);

typedef onError = void Function(String error);

//typedef onBank = void Function(List<BankResponse> bankResponses);
