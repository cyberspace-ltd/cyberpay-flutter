class EndPoints {
  static String cyberPayBaseUrl = 'https://payment-api.cyberpay.ng/api/v1/';
     // 'https://payment-api.staging.cyberpay.ng/api/v1/';

  static String postPaymentsUrl() {
    return cyberPayBaseUrl + "payments";
  }

  static String postPaymentsCardUrl() {
    return cyberPayBaseUrl + "payments/card";
  }

  static String getPaymentsTransactionRefUrl(String transactionRef) {
    return cyberPayBaseUrl + "payments/{$transactionRef}";
  }

  static String getTransactionsByMerchantRefUrl() {
    return cyberPayBaseUrl + "transactions/transactionsBymerchantRef";
  }

  static String postPaymentsOtpUrl() {
    return cyberPayBaseUrl + "payments/otp";
  }

  static String postPaymentsOtpValueUrl(String value) {
    return cyberPayBaseUrl + "payments/bank/otp/{$value}";
  }

  static String postPaymentsBankUrl() {
    return cyberPayBaseUrl + "payments/bank";
  }

  static String postBankEnrolOtpUrl() {
    return cyberPayBaseUrl + "payments/bank/enrol/otp";
  }

  static String getBanksUrl() {
    return cyberPayBaseUrl + "banks";
  }
}
