import 'dart:convert';

import 'package:cyberpaysdkflutter/src/exceptions/CleanerException.dart';
import 'package:cyberpaysdkflutter/src/interface/transactionCallBack.dart';
import 'package:cyberpaysdkflutter/src/network/ApiResponse.dart';
import 'package:dio/dio.dart';

import 'EndPoint.dart';

class CyberPayApi {
  Dio dio = new Dio();

  //TransactionModel
  Future<ApiResponse> beginTransaction(String encodedBody, final TransactionCallBack transactionCallBack) async {
    final response = await dio.post(EndPoints.postPaymentsUrl(),
    data: encodedBody);

    if (response.statusCode == 200) {
      print('${response.data}');
      transactionCallBack.onSuccess(response.data);
      return ApiResponse.fromJson(json.decode(response.data));
    } else {
      throw CleanerException('Failed to verify payments');
    }
  }

  //CardModel
  Future<ApiResponse> chargeCard(String encodedBody) async {
    final response = await dio.post(EndPoints.postPaymentsCardUrl(),
    data: encodedBody);

    if (response.statusCode == 200) {
      print('${response.data}');

      return ApiResponse.fromJson(json.decode(response.data));
    } else {
      throw CleanerException('Failed to verify card');
    }
  }

  //TransactionReference
  Future<ApiResponse> VerifyTransaction(String transactionRef) async {
    final response = await dio.get(EndPoints.getPaymentsTransactionRefUrl(transactionRef));

    if (response.statusCode == 200) {
      print('${response.data}');

      return ApiResponse.fromJson(json.decode(response.data));
    } else {
      throw CleanerException('Failed to verify transaction');
    }
  }

  //OtpRequestModel
  Future<ApiResponse> VerifyOtp(String encodedBody) async {
    final response = await dio.post(EndPoints.postPaymentsOtpUrl(), data: encodedBody);

    if (response.statusCode == 200) {
      print('${response.data}');

      return ApiResponse.fromJson(json.decode(response.data));
    } else {
      throw CleanerException('Failed to verify otp');
    }
  }

  //BankOtpRequestModel
  Future<ApiResponse> VerifyBankOtp(String value) async {
    final response = await dio.post(EndPoints.postPaymentsOtpValueUrl(value),
    );

    if (response.statusCode == 200) {
      print('${response.data}');

      return ApiResponse.fromJson(json.decode(response.data));
    } else {
      throw CleanerException('Failed to verify Bank Otp');
    }
  }

  //BankModel
  Future<ApiResponse> chargeBank(String encodedBody) async {
    final response = await dio.post(EndPoints.postPaymentsBankUrl());

    if (response.statusCode == 200) {
      print('${response.data}');
      return ApiResponse.fromJson(json.decode(response.data));
    } else {
      throw CleanerException('Failed to charge bank');
    }
  }

  //BankOtpRequestModel
  Future<ApiResponse> enrolOtp(String encodedBody) async {
    final response = await dio.post(EndPoints.postBankEnrolOtpUrl(), data: encodedBody);

    if (response.statusCode == 200) {
      print('${response.data}');
      return ApiResponse.fromJson(json.decode(response.data));
    } else {
      throw CleanerException('Failed to enrol Otp');
    }
  }

  //not exactly api response
  Future<ApiResponse> getBank() async {
    final response = await dio.get(EndPoints.getBanksUrl());

    if (response.statusCode == 200) {
      print('${response.data}');
      return ApiResponse.fromJson(json.decode(response.data));
    } else {
      throw CleanerException('Failed to get bank');
    }
  }


}