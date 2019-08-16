import 'package:serializable/serializable.dart';
import 'Advice.dart';

@serializable
class MerchantTransactionResponse {


  String _status;

  String _processorCode;

  Advice _advice;


  String get status => _status;

  set status(String value) {
    _status = value;
  }

  MerchantTransactionResponse();

  String get processorCode => _processorCode;

  set processorCode(String value) {
    _processorCode = value;
  }

  Advice get advice => _advice;

  set advice(Advice value) {
    _advice = value;
  }
}