// To parse this JSON data, do

//

//     final apiResponse = apiResponseFromJson(jsonString);
import 'dart:convert';
ApiResponse apiResponseFromJson(String str) => ApiResponse.fromJson(json.decode(str));

String apiResponseToJson(ApiResponse data) => json.encode(data.toJson());



class ApiResponse {

  String code;

  bool succeeded;

  Data data;



  ApiResponse({

    this.code,

    this.succeeded,

    this.data,

  });

  factory ApiResponse.fromJson(Map<String, dynamic> json) => ApiResponse(

    code: json["code"],

    succeeded: json["succeeded"],

    data: Data.fromJson(json["data"]),

  );



  Map<String, dynamic> toJson() => {

    "code": code,

    "succeeded": succeeded,

    "data": data.toJson(),

  };

}



class Data {

  String transactionReference;

  int charge;

  String redirectUrl;



  Data({

    this.transactionReference,

    this.charge,

    this.redirectUrl,

  });



  factory Data.fromJson(Map<String, dynamic> json) => Data(

    transactionReference: json["transactionReference"],

    charge: json["charge"],

    redirectUrl: json["redirectUrl"],

  );



  Map<String, dynamic> toJson() => {

    "transactionReference": transactionReference,

    "charge": charge,

    "redirectUrl": redirectUrl,

  };

}

 