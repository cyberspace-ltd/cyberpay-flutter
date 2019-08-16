class PaymentSelection {

  String _paymentType;

  String _paymentInfo;

  int _paymentIcon;

  int _id;

  PaymentSelection(
    this._paymentType,
    this._paymentInfo,
    this._paymentIcon,
    this._id);

  int get id => _id;

  set id(int value) {
    _id = value;
  }

  int get paymentIcon => _paymentIcon;

  set paymentIcon(int value) {
    _paymentIcon = value;
  }

  String get paymentInfo => _paymentInfo;

  set paymentInfo(String value) {
    _paymentInfo = value;
  }

  String get paymentType => _paymentType;

  set paymentType(String value) {
    _paymentType = value;
  }


}