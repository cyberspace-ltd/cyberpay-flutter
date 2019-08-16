class VerifyTransactionResponse {

  String _status;

  String _message;

  String _reference;


  VerifyTransactionResponse();

  String get reference => _reference;

  set reference(String value) {
    _reference = value;
  }

  String get message => _message;

  set message(String value) {
    _message = value;
  }

  String get status => _status;

  set status(String value) {
    _status = value;
  }


}