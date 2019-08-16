import 'package:serializable/serializable.dart';

@serializable
class OtpResponse {

  String _reference;

  String _processorReference;

  String _status;

  String _redirectUrl;

  String _message;

  String _reason;

  String _responseAction;

  OtpResponse();

  String get responseAction => _responseAction;

  set responseAction(String value) {
    _responseAction = value;
  }

  String get reason => _reason;

  set reason(String value) {
    _reason = value;
  }

  String get message => _message;

  set message(String value) {
    _message = value;
  }

  String get redirectUrl => _redirectUrl;

  set redirectUrl(String value) {
    _redirectUrl = value;
  }

  String get status => _status;

  set status(String value) {
    _status = value;
  }

  String get processorReference => _processorReference;

  set processorReference(String value) {
    _processorReference = value;
  }

  String get reference => _reference;

  set reference(String value) {
    _reference = value;
  }


}