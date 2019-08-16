class ChargeBank {

   String _bankCode;

   String _accountNumber;

   String _reference;

   String _accountName;

  ChargeBank();

   String get accountName => _accountName;

   set accountName(String value) {
     _accountName = value;
   }

   String get reference => _reference;

   set reference(String value) {
     _reference = value;
   }

   String get accountNumber => _accountNumber;

   set accountNumber(String value) {
     _accountNumber = value;
   }

   String get bankCode => _bankCode;

   set bankCode(String value) {
     _bankCode = value;
   }


}