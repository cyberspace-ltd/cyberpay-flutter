import 'package:cyberpaysdkflutter/src/models/TransactionModel.dart';

class TransactionCallBack{
  void onSuccess(String transactionReference){}

  void onOtpRequired(TransactionModel transaction){}

  void onSecure3dRequired(TransactionModel transaction){}

  void onSecure3DMpgsRequired(TransactionModel transaction){}

//  void onError(Throwable error, Transaction transaction){}

//  void onBank(List<BankResponse> bankResponses){}
}