import 'package:cyberpaysdkflutter/src/apis/CyberPayApi.dart';
import 'package:cyberpaysdkflutter/src/interface/transactionCallBack.dart'
    as callback;
import 'package:cyberpaysdkflutter/src/network/ApiResponse.dart';
import 'package:cyberpaysdkflutter/src/network/ChargeResponse.dart';

class TransactionRepository {
  static CyberPayApi _api;
  static TransactionRepository _instance;

  static TransactionRepository getInstance(CyberPayApi api) {
    if (_instance == null) {
      _api = api;
      _instance = TransactionRepository();
    }
    return _instance;
  }

  Future<ApiResponse> beginTransactionApi(
      {String encodedBody,
      callback.onSuccess success,
      callback.onError error}) async {
    try {
      return _api.beginTransaction(encodedBody, success, error);
    } catch (error) {
      rethrow;
    }
  }

  Future<CardPaymentResponse> chargeCardApi(
      {String encodedBody,
      callback.onSuccess success,
      callback.onOtpRequired otpRequired,
      callback.onProvidePin providePin,
      callback.onEnrolOtp enrolOtp,
      callback.onSecure3dRequired secure3dRequired,
      callback.onSecure3DMpgsRequired secure3dMpgsRequired,
      callback.onError error}) async {
    try {
      return _api.chargeCard(encodedBody, success, otpRequired, providePin,
          enrolOtp, secure3dRequired, secure3dMpgsRequired, error);
    } catch (error) {
      rethrow;
    }
  }

  Future<String> getEncodedPayload(String encodedBody) async {
    try {
      return encodedBody;
    } catch (error) {
      rethrow;
    }
  }

  Future<ApiResponse> verifyTransactionApi(
      {String encodedBody,
      callback.onSuccess success,
      callback.onError error}) async {
    try {
      return _api.verifyTransaction(encodedBody, success, error);
    } catch (error) {
      rethrow;
    }
  }

  Future<CardPaymentResponse> verifyOtpApi(
      {String encodedBody,
      callback.onSuccess success,
      callback.onError error}) async {
    try {
      return _api.verifyOtp(encodedBody, success, error);
    } catch (error) {
      rethrow;
    }
  }

  Future<CardPaymentResponse> verifyBankOtpApi(
      {String encodedBody,
      callback.onSuccess success,
      callback.onError error}) async {
    try {
      return _api.verifyBankOtp(encodedBody, success, error);
    } catch (error) {
      rethrow;
    }
  }

  Future<ApiResponse> chargeBankApi(String encodedBody) async {
    try {
      return _api.chargeBank(encodedBody);
    } catch (error) {
      rethrow;
    }
  }

  Future<CardPaymentResponse> enrolOtpApi(String encodedBody) async {
    try {
      return _api.enrolOtpAPI(encodedBody);
    } catch (error) {
      rethrow;
    }
  }

  Future<ApiResponse> getBankApi() async {
    try {
      return _api.getBank();
    } catch (error) {
      rethrow;
    }
  }
}
