import 'package:cyberpaysdkflutter/src/exceptions/CleanerException.dart';
import 'package:cyberpaysdkflutter/src/interface/transactionCallBack.dart';
import 'package:cyberpaysdkflutter/src/models/TransactionModel.dart';
import 'package:cyberpaysdkflutter/src/models/cardModel.dart';
import 'package:cyberpaysdkflutter/src/models/charge_model.dart';
import 'package:cyberpaysdkflutter/src/network/ApiResponse.dart';
import 'package:cyberpaysdkflutter/src/network/ChargeResponse.dart';
import 'package:dio/dio.dart';

import 'EndPoint.dart';

class CyberPayApi {
  onSuccess success;
  onProvidePin providePin;
  onOtpRequired otpRequired;
  onBankOtpRequired bankOtpRequired;
  onSecure3dRequired secure3dRequired;
  onSecure3DMpgsRequired secure3DMpgsRequired;
  onEnrolOtp enrolOtp;
  onError error;

  TransactionModel transactionModel;
  Charge charge;
  Card card;

  // ignore: missing_return
  Future<ApiResponse> beginTransaction(
      String encodedBody, onSuccess success, onError error) async {
    this.success = success;
    this.error = error;

    print('Encoded json: $encodedBody');
    this.transactionModel = transactionModelFromJson(encodedBody);

    Dio dio = new Dio();
    Response response;

    try {
      response = await dio.post(EndPoints.postPaymentsUrl(), data: encodedBody);

      if (response.statusCode == 200) {
        print('${response.data}');
        var ref = ApiResponse.fromJson(response.data);

        this.success(ref.data.transactionReference, "");

      } else {
        throw Exception('An error has occurred');
      }
    } catch (error) {
      print(error);

      if (error is DioError) {
        print(error.response);

        if (error.response?.statusCode == 403) {
          var value = ApiResponse.fromJson(error.response?.data);
          this.error(value.message.toString());
          //throw Exception(value.message.toString());
        } else if (error.response?.statusCode == 500) {
          var value = ApiResponse.fromJson(error.response?.data);
          this.error(value.message.toString());

//          throw Exception(value.message.toString());
        } else {
          this.error(_handleError(error));

          //throw Exception(_handleError(error));
        }
      } else {
        this.error(
            'We are having issues sending the account to the server. Try again later. ');
//        throw Exception(
//            'We are having issues sending the account to the server. Try again later. ');
      }
    }
  }

  //CardModel
  // ignore: missing_return
  Future<CardPaymentResponse> chargeCard(
      String encodedBody,
      onSuccess succ,
      onOtpRequired otpRequired,
      onProvidePin providePin,
      onEnrolOtp enrolOtp,
      onSecure3dRequired secure3dRequired,
      onSecure3DMpgsRequired secure3dMpgsRequired,
      onError err) async {
    this.success = succ;
    this.otpRequired = otpRequired;
    this.providePin = providePin;
    this.enrolOtp = enrolOtp;
    this.secure3dRequired = secure3dRequired;
    this.secure3DMpgsRequired = secure3dMpgsRequired;
    this.error = err;
    print('Encoded json: $encodedBody');

    this.charge = chargeFromJson(encodedBody);

    this.card = cardFromJson(encodedBody);
    Dio dio = new Dio();
    Response response;
    CardPaymentResponse ref;

    try {
      final response =
          await dio.post(EndPoints.postPaymentsCardUrl(), data: encodedBody);

      if (response.statusCode == 200) {
        print('${response.data}');
        ref = CardPaymentResponse.fromJson(response.data);

        if (response.data != null && ref.data.status == "Success") {
          this.success(ref.data.reference, ref.message);
        }
        if (response.data != null && ref.data.status == "Successful") {
          this.success(ref.data.reference, ref.message);
        }
        if (response.data != null && ref.data.status == "ProvidePin") {
          this.providePin(charge);
        }
        else if (response.data != null && ref.data.status == "Failed") {
          this.error(ref.data.message);
        }
        if (response.data != null && ref.data.status == "EnrollOtp") {
          if (ref.data.redirectUrl != null) {
            transactionModel.returnUrl = ref.data.redirectUrl;
          }
          this.enrolOtp(charge);
        }
        if (response.data != null && ref.data.status == "Otp") {
          this.otpRequired(charge, card);
        }
        if (response.data != null && ref.data.status == "Secure3D") {
          if (ref.data.redirectUrl != null) {
            transactionModel.returnUrl = ref.data.redirectUrl;
          }
          this.secure3dRequired(charge);
        } else if (response.data != null && ref.data.status == "Secure3DMpgs") {
          if (ref.data.redirectUrl != null) {
            transactionModel.returnUrl = ref.data.redirectUrl;
          }
          this.secure3DMpgsRequired(charge);
        } 
      } else {
        this.error(
            'An error has occurred  ${ref.data.message != null ? ref.data.message : ref.message} ');
//        throw Exception('An error has occurred ${ref.data.message}');
      }
    } catch (error) {
      print(error);

//      print("Exception occured: $error stackTrace: $stacktrace");
      if (error is DioError) {
        print(error.response);

        if (error.response?.statusCode == 403) {
          var value = CardPaymentResponse.fromJson(error.response?.data);
          this.error(value.data.message != null
              ? value.data.message
              : value.message.toString());
        } else if (error.response?.statusCode == 500) {
          var value = CardPaymentResponse.fromJson(error.response?.data);
          this.error(value.data.message != null
              ? value.data.message
              : value.message.toString());
        } else {
          this.error(_handleError(error));

//          throw Exception(_handleError(error));
        }
      }
    }
  }

  //TransactionReference
  // ignore: missing_return
  Future<ApiResponse> verifyTransaction(String encodedBody, onSuccess succ, onError err) async {
    this.success = succ;
    this.error = err;

    Dio dio = new Dio();
    ApiResponse ref;


    try {
      final response =
          await dio.get(EndPoints.getPaymentsTransactionRefUrl(encodedBody));

      if (response.statusCode == 200) {
        print('${response.data}');

        ref = ApiResponse.fromJson(response.data);
//        if (response.data != null && ref.data.status == "Success") {
//          this.success(ref.data.reference);
//        }
//        if (response.data != null && ref.data.status == "Successful") {
//          this.success(ref.data.reference);
//        }
      } else {
        throw CleanerException('Failed to verify transaction');
      }
    } catch (error) {
      print(error);

      if (error is DioError) {
        print(error.response);

        if (error.response?.statusCode == 403) {
          var value = CardPaymentResponse.fromJson(error.response?.data);
          throw Exception(value.toString());
        } else if (error.response?.statusCode == 500) {
          var value = CardPaymentResponse.fromJson(error.response?.data);
          this.error(value.data.message != null
              ? value.data.message
              : value.message.toString());
        } else {
          throw Exception(_handleError(error));
        }
      } else {
        throw Exception(
            'We are having issues sending the account to the server. Try again later. ');
      }
    }
  }

  //OtpRequestModel
  // ignore: missing_return
  Future<CardPaymentResponse> verifyOtp(String encodedBody, onSuccess succ, onError err) async {
    this.success = succ;
    this.error = err;
    print('Encoded json: $encodedBody');

    Dio dio = new Dio();
    CardPaymentResponse ref;

    try {
      final response =
          await dio.post(EndPoints.postPaymentsOtpUrl(), data: encodedBody);

      if (response.statusCode == 200) {
        print('${response.data}');

        ref = CardPaymentResponse.fromJson(response.data);

        if(response.data != null && ref.data.status == "Success"){
          this.success(ref.data.reference, ref.data.message);
        } else if(response.data != null && ref.data.status == "Successful"){
          this.success(ref.data.reference, ref.data.message);
        } else if (response.data != null && ref.data.status == "ProvidePin") {
          this.providePin(charge);
        }
        else if (response.data != null && ref.data.status == "EnrollOtp") {
          if (ref.data.redirectUrl != null) {
            transactionModel.returnUrl = ref.data.redirectUrl;
          }
          this.enrolOtp(charge);
        }
        else if (response.data != null && ref.data.status == "Otp") {
          this.otpRequired(charge, card);
        }
        else if (response.data != null && ref.data.status == "Failed") {
          this.error(ref.data.message);
        }
        else if (response.data != null && ref.data.status == "Secure3D") {
          if (ref.data.redirectUrl != null) {
            transactionModel.returnUrl = ref.data.redirectUrl;
          }
          this.secure3dRequired(charge);
        } else if (response.data != null && ref.data.status == "Secure3DMpgs") {
          if (ref.data.redirectUrl != null) {
            transactionModel.returnUrl = ref.data.redirectUrl;
          }
          this.secure3DMpgsRequired(charge);
        }
      } else {
        this.error('Failed to verify otp ${ref.data.message != null ? ref.data.message : ref.message}');
//        throw CleanerException('Failed to verify otp');
      }
    } catch (error) {
      print(error);

      if (error is DioError) {
        print(error.response);

        if (error.response?.statusCode == 403) {
          var value = CardPaymentResponse.fromJson(error.response?.data);
          this.error(value.message != null
              ? value.message
              : value.data.message);
          //throw Exception(value.message.toString());
        } else if (error.response?.statusCode == 500) {
          var value = CardPaymentResponse.fromJson(error.response?.data);
          //throw Exception(value.message.toString());
          this.error(value.message != null ? value.message : value.data.message);
        } else {
          this.error(_handleError(error));
//          throw Exception(_handleError(error));
        }
      } else {
        this.error('We are having issues sending the account to the server. Try again later. ');
//        throw Exception(
//            'We are having issues sending the account to the server. Try again later. ');
      }
    }
  }

  //BankOtpRequestModel
  // ignore: missing_return
  Future<CardPaymentResponse> verifyBankOtp(String value, onSuccess succ, onError err) async {
    this.error = err;
    this.success = succ;
    CardPaymentResponse ref;
    Dio dio = new Dio();
    try {
      final response = await dio.post(
        EndPoints.postPaymentsOtpValueUrl(value),
      );

      if (response.statusCode == 200) {
        print('${response.data}');

       ref =  CardPaymentResponse.fromJson(response.data);
       this.success(ref.data.reference, ref.data.message);
      } else {
        this.error('Failed to verify Bank Otp');
//        throw CleanerException('Failed to verify Bank Otp');
      }
    } catch (error) {
      print(error);

      if (error is DioError) {
        print(error.response);

        if (error.response?.statusCode == 403) {
          var value = CardPaymentResponse.fromJson(error.response?.data);
          throw Exception(value.message.toString());
        } else if (error.response?.statusCode == 500) {
          var value = CardPaymentResponse.fromJson(error.response?.data);
          throw Exception(value.message.toString());
        } else {
          throw Exception(_handleError(error));
        }
      }
    }
  }

  //BankModel
  Future<ApiResponse> chargeBank(String encodedBody) async {
    Dio dio = new Dio();
    try {
      final response = await dio.post(EndPoints.postPaymentsBankUrl());

      if (response.statusCode == 200) {
        print('${response.data}');
        return ApiResponse.fromJson(response.data);
      } else {
        throw CleanerException('Failed to charge bank');
      }
    } catch (error) {
      print(error);

//      print("Exception occured: $error stackTrace: $stacktrace");
      if (error is DioError) {
        print(error.response);

        if (error.response?.statusCode == 403) {
          var value = CardPaymentResponse.fromJson(error.response?.data);
          throw Exception(value.message.toString());
        } else if (error.response?.statusCode == 500) {
          var value = CardPaymentResponse.fromJson(error.response?.data);
          throw Exception(value.message.toString());
        } else {
          throw Exception(_handleError(error));
        }
      } else {
        throw Exception(
            'We are having issues sending the account to the server. Try again later. ');
      }
    }
  }

  //BankOtpRequestModel
  Future<CardPaymentResponse> enrolOtpAPI(String encodedBody) async {
    Dio dio = new Dio();
    try {
      final response =
          await dio.post(EndPoints.postBankEnrolOtpUrl(), data: encodedBody);

      if (response.statusCode == 200) {
        print('${response.data}');
        return CardPaymentResponse.fromJson(response.data);
      } else {
        throw CleanerException('Failed to enrol Otp');
      }
    } catch (error) {
      print(error);

//      print("Exception occured: $error stackTrace: $stacktrace");
      if (error is DioError) {
        print(error.response);

        if (error.response?.statusCode == 403) {
          var value = CardPaymentResponse.fromJson(error.response?.data);
          throw Exception(value.message.toString());
        } else if (error.response?.statusCode == 500) {
          var value = CardPaymentResponse.fromJson(error.response?.data);
          throw Exception(value.message.toString());
        } else {
          throw Exception(_handleError(error));
        }
      } else {
        throw Exception(
            'We are having issues sending the account to the server. Try again later. ');
      }
    }
  }

  //not exactly api response
  Future<ApiResponse> getBank() async {
    Dio dio = new Dio();
    try {
      final response = await dio.get(EndPoints.getBanksUrl());

      if (response.statusCode == 200) {
        print('${response.data}');
        return ApiResponse.fromJson(response.data);
      } else {
        throw CleanerException('Failed to get bank');
      }
    } catch (error) {
      print(error);

//      print("Exception occured: $error stackTrace: $stacktrace");
      if (error is DioError) {
        print(error.response);

        if (error.response?.statusCode == 403) {
          var value = ApiResponse.fromJson(error.response?.data);
          throw Exception(value.message.toString());
        } else if (error.response?.statusCode == 500) {
          var value = ApiResponse.fromJson(error.response?.data);
          throw Exception(value.message.toString());
        } else {
          throw Exception(_handleError(error));
        }
      } else {
        throw Exception(
            'We are having issues sending the account to the server. Try again later. ');
      }
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

//class AppConfig extends InheritedWidget {
//  final String apiBaseUrl;
//  final bool isStaging;
//  final Widget child;
//
//  AppConfig({@required this.apiBaseUrl, @required this.isStaging, this.child});
//
//  static AppConfig of(BuildContext context) {
//    return context.inheritFromWidgetOfExactType(AppConfig);
//  }
//
//  @override
//  bool updateShouldNotify(InheritedWidget oldWidget) => false;
//}
