class Charge {

  String _accountName;

  String _reference;

  String _bankCode;

  String _accountNumber;

  String _cardPin;

  String _cardNameHolder;

  String _cardExpiryMonth;

  String _cardExpiryYear;

  String _cardNumber;

  String _cardCvv;

  String _transactionReference;

  Charge();

  String get transactionReference => _transactionReference;

  set transactionReference(String value) {
    _transactionReference = value;
  }

  String get cardCvv => _cardCvv;

  set cardCvv(String value) {
    _cardCvv = value;
  }

  String get cardNumber => _cardNumber;

  set cardNumber(String value) {
    _cardNumber = value;
  }

  String get cardExpiryYear => _cardExpiryYear;

  set cardExpiryYear(String value) {
    _cardExpiryYear = value;
  }

  String get cardExpiryMonth => _cardExpiryMonth;

  set cardExpiryMonth(String value) {
    _cardExpiryMonth = value;
  }

  String get cardNameHolder => _cardNameHolder;

  set cardNameHolder(String value) {
    _cardNameHolder = value;
  }

  String get cardPin => _cardPin;

  set cardPin(String value) {
    _cardPin = value;
  }

  String get accountNumber => _accountNumber;

  set accountNumber(String value) {
    _accountNumber = value;
  }

  String get bankCode => _bankCode;

  set bankCode(String value) {
    _bankCode = value;
  }

  String get reference => _reference;

  set reference(String value) {
    _reference = value;
  }

  String get accountName => _accountName;

  set accountName(String value) {
    _accountName = value;
  }


}