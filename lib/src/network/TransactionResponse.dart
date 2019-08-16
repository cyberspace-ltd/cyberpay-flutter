import 'package:serializable/serializable.dart';

@serializable
class TransactionResponse implements Serializable {

  String _transactionReference;

  String _charge;

  String _redirectUrl;


  TransactionResponse();

  String get redirectUrl => _redirectUrl;

  set redirectUrl(String value) {
    _redirectUrl = value;
  }

  String get charge => _charge;

  set charge(String value) {
    _charge = value;
  }

  String get transactionReference => _transactionReference;

  set transactionReference(String value) {
    _transactionReference = value;
  }

}