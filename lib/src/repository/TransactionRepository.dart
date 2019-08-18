

import 'package:cyberpaysdkflutter/src/apis/CyberPayApi.dart';
import 'package:cyberpaysdkflutter/src/interface/transactionCallBack.dart';
import 'package:cyberpaysdkflutter/src/network/ApiResponse.dart';

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
      String encodedBody) async {
    try {
      return _api.beginTransaction(encodedBody,new TransactionCallBack());
    } catch (error) {
      rethrow;
    }
  }

  Future<ApiResponse> chargeCardApi(String encodedBody) async {
    try {
      return _api.chargeCard(encodedBody);
    } catch (error) {
      rethrow;
    }
  }

  Future<ApiResponse> VerifyTransactionApi(String transactionRef) async {
    try {
      return _api.VerifyTransaction(transactionRef);
    } catch (error) {
      rethrow;
    }
  }

  Future<ApiResponse> VerifyOtpApi(String value) async {
    try {
      return _api.VerifyOtp(value);
    } catch (error) {
      rethrow;
    }
  }

  Future<ApiResponse> VerifyBankOtpApi(
      String encodedBody) async {
    try {
      return _api.VerifyBankOtp(encodedBody);
    } catch (error) {
      rethrow;
    }
  }

  Future<ApiResponse> chargeBankApi(
      String encodedBody) async {
    try {
      return _api.chargeBank(encodedBody);
    } catch (error) {
      rethrow;
    }
  }

  Future<ApiResponse> enrolOtpApi(
      String encodedBody) async {
    try {
      return _api.enrolOtp(encodedBody);
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