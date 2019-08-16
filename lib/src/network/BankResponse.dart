class BankResponse {

  int _id;

  String _bankCode;

  String _bankName;

  int get id => _id;

  set id(int value) {
    _id = value;
  }

  String get bankCode => _bankCode;

  String get bankName => _bankName;

  set bankName(String value) {
    _bankName = value;
  }

  set bankCode(String value) {
    _bankCode = value;
  }


}