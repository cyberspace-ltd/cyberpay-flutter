class EndPoints {
  static String CYBER_PAY_BASE_URL = 'https://payment-api.staging.cyberpay.ng/api/v1/';

  static String postPaymentsUrl() {
    return CYBER_PAY_BASE_URL + "payments";
  }

  static String postPaymentsCardUrl() {
    return CYBER_PAY_BASE_URL + "payments/card";
  }

  static String getPaymentsTransactionRefUrl(String transactionRef) {
    return CYBER_PAY_BASE_URL + "payments/{$transactionRef}";
  }

  static String getTransactionsByMerchantRefUrl() {
    return CYBER_PAY_BASE_URL + "transactions/transactionsBymerchantRef";
  }

  static String postPaymentsOtpUrl() {
    return CYBER_PAY_BASE_URL + "payments/otp";
  }

  static String postPaymentsOtpValueUrl(String value) {
    return CYBER_PAY_BASE_URL + "payments/bank/otp/{$value}";
  }

  static String postPaymentsBankUrl() {
    return CYBER_PAY_BASE_URL + "payments/bank";
  }

  static String postBankEnrolOtpUrl() {
    return CYBER_PAY_BASE_URL + "payments/bank/enrol/otp";
  }

  static String getBanksUrl() {
    return CYBER_PAY_BASE_URL + "banks";
  }
}