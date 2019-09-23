import 'package:cyberpaysdkflutter/src/exceptions/CleanerException.dart';
import 'package:cyberpaysdkflutter/src/interface/transactionCallBack.dart';
import 'package:cyberpaysdkflutter/src/models/TransactionModel.dart';
import 'package:cyberpaysdkflutter/src/network/ApiResponse.dart';
import 'package:cyberpaysdkflutter/src/network/ChargeResponse.dart';
import 'package:dio/dio.dart';

import 'EndPoint.dart';

class CyberPayApi {
  TransactionModel transactionModel;

  Future<ApiResponse> beginTransaction(
      String encodedBody, final TransactionCallBack transactionCallBack) async {
    print('Encoded json: $encodedBody');
    this.transactionModel = transactionModelFromJson(encodedBody);

    Dio dio = new Dio();
    Response response;

    try {
      response = await dio.post(EndPoints.postPaymentsUrl(), data: encodedBody);

      if (response.statusCode == 200) {
        print('${response.data}');
        var ref = ApiResponse.fromJson(response.data);
        transactionCallBack.onSuccess(ref.data.transactionReference);
        return ApiResponse.fromJson(response.data);
      } else {
        throw Exception('An error has occurred');
      }
    } catch (error) {
      print(error);

      if (error is DioError) {
        print(error.response);

        if (error.response?.statusCode == 403) {
          var value = ApiResponse.fromJson(error.response?.data);
          throw Exception(value.toString());
        } else if (error.response?.statusCode == 500) {
          var value = ApiResponse.fromJson(error.response?.data);
          throw Exception(value.toString());
        } else {
          throw Exception(_handleError(error));
        }
      } else {
        throw Exception(
            'We are having issues sending the account to the server. Try again later. ');
      }
    }
  }

  //CardModel
  Future<CardPaymentResponse> chargeCard(
      String encodedBody, final TransactionCallBack transactionCallBack) async {
    print('Encoded json: $encodedBody');
    Dio dio = new Dio();
    Response response;
    var ref;

    try {
      final response =
          await dio.post(EndPoints.postPaymentsCardUrl(), data: encodedBody);

      if (response.statusCode == 200) {
        print('${response.data}');
        ref = CardPaymentResponse.fromJson(response.data);
        return CardPaymentResponse.fromJson(response.data);
//        if (response.data != null && ref.data.status == "Success") {
//          transactionCallBack.onSuccess(ref.data.reference);
//          return CardPaymentResponse.fromJson(response.data);
//        }
//        if (response.data != null && ref.data.status == "Successful") {
//          transactionCallBack.onSuccess(ref.data.reference);
//          return CardPaymentResponse.fromJson(response.data);
//        }
//        if (response.data != null && ref.data.status == "EnrollOtp") {
//          if (ref.data.redirectUrl != null) {
//            transactionModel.returnUrl = ref.data.redirectUrl;
//          }
//          transactionCallBack.onEnrolOtp(transactionModel);
//          return CardPaymentResponse.fromJson(response.data);
//        }
//        if (response.data != null && ref.data.status == "Secure3D") {
//          if (ref.data.redirectUrl != null) {
//            transactionModel.returnUrl = ref.data.redirectUrl;
//          }
//          transactionCallBack.onSecure3dRequired(transactionModel);
//          return CardPaymentResponse.fromJson(response.data);
//        } else if (response.data != null && ref.data.status == "Secure3DMpgs") {
//          if (ref.data.redirectUrl != null) {
//            transactionModel.returnUrl = ref.data.redirectUrl;
//          }
//          transactionCallBack.onSecure3DMpgsRequired(transactionModel);
//          return CardPaymentResponse.fromJson(response.data);
//        }
      } else {
        throw Exception('An error has occurred ${ref.data.message}');
      }
    } catch (error) {
      print(error);

//      print("Exception occured: $error stackTrace: $stacktrace");
      if (error is DioError) {
        print(error.response);

        if (error.response?.statusCode == 403) {
          var value = CardPaymentResponse.fromJson(error.response?.data);
          throw Exception(value.toString());
        } else if (error.response?.statusCode == 500) {
          var value = CardPaymentResponse.fromJson(error.response?.data);
          throw Exception(value.toString());
        } else {
          throw Exception(_handleError(error));
        }
      } else {
        throw Exception(
            'We are having issues sending the account to the server. Try again later. ');
      }
    }
  }

  //TransactionReference
  Future<ApiResponse> VerifyTransaction(String transactionRef) async {
    Dio dio = new Dio();
    final response =
        await dio.get(EndPoints.getPaymentsTransactionRefUrl(transactionRef));

    if (response.statusCode == 200) {
      print('${response.data}');

      return ApiResponse.fromJson(response.data);
    } else {
      throw CleanerException('Failed to verify transaction');
    }
  }

  //OtpRequestModel
  Future<CardPaymentResponse> VerifyOtp(String encodedBody) async {
    print('Encoded json: $encodedBody');

    Dio dio = new Dio();
    final response =
        await dio.post(EndPoints.postPaymentsOtpUrl(), data: encodedBody);

    if (response.statusCode == 200) {
      print('${response.data}');

      return CardPaymentResponse.fromJson(response.data);
    } else {
      throw CleanerException('Failed to verify otp');
    }
  }

  //BankOtpRequestModel
  Future<CardPaymentResponse> VerifyBankOtp(String value) async {
    Dio dio = new Dio();
    final response = await dio.post(
      EndPoints.postPaymentsOtpValueUrl(value),
    );

    if (response.statusCode == 200) {
      print('${response.data}');

      return CardPaymentResponse.fromJson(response.data);
    } else {
      throw CleanerException('Failed to verify Bank Otp');
    }
  }

  //BankModel
  Future<ApiResponse> chargeBank(String encodedBody) async {
    Dio dio = new Dio();
    final response = await dio.post(EndPoints.postPaymentsBankUrl());

    if (response.statusCode == 200) {
      print('${response.data}');
      return ApiResponse.fromJson(response.data);
    } else {
      throw CleanerException('Failed to charge bank');
    }
  }

  //BankOtpRequestModel
  Future<ApiResponse> enrolOtp(String encodedBody) async {
    Dio dio = new Dio();
    final response =
        await dio.post(EndPoints.postBankEnrolOtpUrl(), data: encodedBody);

    if (response.statusCode == 200) {
      print('${response.data}');
      return ApiResponse.fromJson(response.data);
    } else {
      throw CleanerException('Failed to enrol Otp');
    }
  }

  //not exactly api response
  Future<ApiResponse> getBank() async {
    Dio dio = new Dio();
    final response = await dio.get(EndPoints.getBanksUrl());

    if (response.statusCode == 200) {
      print('${response.data}');
      return ApiResponse.fromJson(response.data);
    } else {
      throw CleanerException('Failed to get bank');
    }
  }

  String _handleError(DioError error) {
    String errorDescription = "";
    if (error is DioError) {
      switch (error.type) {
        case DioErrorType.CANCEL:
          errorDescription = "Request to API server was cancelled";
          break;
        case DioErrorType.CONNECT_TIMEOUT:
          errorDescription = "Connection timeout with API server";
          break;
        case DioErrorType.DEFAULT:
          errorDescription =
              "Connection to API server failed due to internet connection";
          break;
        case DioErrorType.RECEIVE_TIMEOUT:
          errorDescription = "Receive timeout in connection with API server";
          break;
        case DioErrorType.RESPONSE:
          if (error.response?.statusCode == 401) {
            errorDescription = "401. Session expired. Kindly login again.";
          } else {
            errorDescription =
                "Received invalid status code: ${error.response.statusCode}";
          }

          break;
        case DioErrorType.SEND_TIMEOUT:
          errorDescription = "Send timeout in connection with API server";
          break;
      }
    } else {
      errorDescription = "Unexpected error occured";
    }
    return errorDescription;
  }
}
