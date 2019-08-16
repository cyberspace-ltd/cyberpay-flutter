// To parse this JSON data, do
//
//     final otpRequestModel = otpRequestModelFromJson(jsonString);

import 'dart:convert';

OtpRequestModel otpRequestModelFromJson(String str) => OtpRequestModel.fromJson(json.decode(str));

String otpRequestModelToJson(OtpRequestModel data) => json.encode(data.toJson());

class OtpRequestModel {
  AdviceModel adviceModel;
  String otp;
  String reference;
  String otpReference;
  Card cardModel;
  String paymentId;
  String transactionIdentifier;
  String eciFlag;
  String registeredPhoneNumber;

  OtpRequestModel({
    this.adviceModel,
    this.otp,
    this.reference,
    this.otpReference,
    this.cardModel,
    this.paymentId,
    this.transactionIdentifier,
    this.eciFlag,
    this.registeredPhoneNumber,
  });

  factory OtpRequestModel.fromJson(Map<String, dynamic> json) => OtpRequestModel(
    adviceModel: AdviceModel.fromJson(json["adviceModel"]),
    otp: json["otp"],
    reference: json["reference"],
    otpReference: json["otpReference"],
    cardModel: Card.fromJson(json["cardModel"]),
    paymentId: json["paymentId"],
    transactionIdentifier: json["transactionIdentifier"],
    eciFlag: json["eciFlag"],
    registeredPhoneNumber: json["registeredPhoneNumber"],
  );

  Map<String, dynamic> toJson() => {
    "adviceModel": adviceModel.toJson(),
    "otp": otp,
    "reference": reference,
    "otpReference": otpReference,
    "cardModel": cardModel.toJson(),
    "paymentId": paymentId,
    "transactionIdentifier": transactionIdentifier,
    "eciFlag": eciFlag,
    "registeredPhoneNumber": registeredPhoneNumber,
  };
}

class AdviceModel {
  int adviceId;
  String currency;
  String reference;
  String processorRef;
  String merchantRef;
  int originalAmount;
  int amountAfterCharge;
  String description;
  String customerId;
  String customerName;
  String customerEmail;
  String customerMobile;
  int charge;
  String status;
  String message;
  String integrationKey;
  int integrationId;
  String returnUrl;
  String walletId;
  String cyberpayReturnUrl;
  String cyberpayNotificationUrl;
  String processorCode;
  String productCode;
  String channelCode;
  Card card;
  Integration integration;
  DateTime createdOn;
  List<Transaction> transactions;
  List<Split> splits;
  String paRes;
  String otherInfo;
  String adviceTransactionType;
  bool isWalletCredited;

  AdviceModel({
    this.adviceId,
    this.currency,
    this.reference,
    this.processorRef,
    this.merchantRef,
    this.originalAmount,
    this.amountAfterCharge,
    this.description,
    this.customerId,
    this.customerName,
    this.customerEmail,
    this.customerMobile,
    this.charge,
    this.status,
    this.message,
    this.integrationKey,
    this.integrationId,
    this.returnUrl,
    this.walletId,
    this.cyberpayReturnUrl,
    this.cyberpayNotificationUrl,
    this.processorCode,
    this.productCode,
    this.channelCode,
    this.card,
    this.integration,
    this.createdOn,
    this.transactions,
    this.splits,
    this.paRes,
    this.otherInfo,
    this.adviceTransactionType,
    this.isWalletCredited,
  });

  factory AdviceModel.fromJson(Map<String, dynamic> json) => AdviceModel(
    adviceId: json["adviceId"],
    currency: json["currency"],
    reference: json["reference"],
    processorRef: json["processorRef"],
    merchantRef: json["merchantRef"],
    originalAmount: json["originalAmount"],
    amountAfterCharge: json["amountAfterCharge"],
    description: json["description"],
    customerId: json["customerId"],
    customerName: json["customerName"],
    customerEmail: json["customerEmail"],
    customerMobile: json["customerMobile"],
    charge: json["charge"],
    status: json["status"],
    message: json["message"],
    integrationKey: json["integrationKey"],
    integrationId: json["integrationId"],
    returnUrl: json["returnUrl"],
    walletId: json["walletId"],
    cyberpayReturnUrl: json["cyberpayReturnUrl"],
    cyberpayNotificationUrl: json["cyberpayNotificationUrl"],
    processorCode: json["processorCode"],
    productCode: json["productCode"],
    channelCode: json["channelCode"],
    card: Card.fromJson(json["card"]),
    integration: Integration.fromJson(json["integration"]),
    createdOn: DateTime.parse(json["createdOn"]),
    transactions: List<Transaction>.from(json["transactions"].map((x) => Transaction.fromJson(x))),
    splits: List<Split>.from(json["splits"].map((x) => Split.fromJson(x))),
    paRes: json["paRes"],
    otherInfo: json["otherInfo"],
    adviceTransactionType: json["adviceTransactionType"],
    isWalletCredited: json["isWalletCredited"],
  );

  Map<String, dynamic> toJson() => {
    "adviceId": adviceId,
    "currency": currency,
    "reference": reference,
    "processorRef": processorRef,
    "merchantRef": merchantRef,
    "originalAmount": originalAmount,
    "amountAfterCharge": amountAfterCharge,
    "description": description,
    "customerId": customerId,
    "customerName": customerName,
    "customerEmail": customerEmail,
    "customerMobile": customerMobile,
    "charge": charge,
    "status": status,
    "message": message,
    "integrationKey": integrationKey,
    "integrationId": integrationId,
    "returnUrl": returnUrl,
    "walletId": walletId,
    "cyberpayReturnUrl": cyberpayReturnUrl,
    "cyberpayNotificationUrl": cyberpayNotificationUrl,
    "processorCode": processorCode,
    "productCode": productCode,
    "channelCode": channelCode,
    "card": card.toJson(),
    "integration": integration.toJson(),
    "createdOn": createdOn.toIso8601String(),
    "transactions": List<dynamic>.from(transactions.map((x) => x.toJson())),
    "splits": List<dynamic>.from(splits.map((x) => x.toJson())),
    "paRes": paRes,
    "otherInfo": otherInfo,
    "adviceTransactionType": adviceTransactionType,
    "isWalletCredited": isWalletCredited,
  };
}

class Card {
  String name;
  int expiryMonth;
  int expiryYear;
  String cardNumber;
  String cvv;
  String otherInfo;
  String reference;
  String cardPin;
  String channel;
  String processCode;
  int providerId;

  Card({
    this.name,
    this.expiryMonth,
    this.expiryYear,
    this.cardNumber,
    this.cvv,
    this.otherInfo,
    this.reference,
    this.cardPin,
    this.channel,
    this.processCode,
    this.providerId,
  });

  factory Card.fromJson(Map<String, dynamic> json) => Card(
    name: json["name"],
    expiryMonth: json["expiryMonth"],
    expiryYear: json["expiryYear"],
    cardNumber: json["cardNumber"],
    cvv: json["cvv"],
    otherInfo: json["otherInfo"],
    reference: json["reference"],
    cardPin: json["cardPin"],
    channel: json["channel"],
    processCode: json["processCode"],
    providerId: json["providerId"],
  );

  Map<String, dynamic> toJson() => {
    "name": name,
    "expiryMonth": expiryMonth,
    "expiryYear": expiryYear,
    "cardNumber": cardNumber,
    "cvv": cvv,
    "otherInfo": otherInfo,
    "reference": reference,
    "cardPin": cardPin,
    "channel": channel,
    "processCode": processCode,
    "providerId": providerId,
  };
}

class Integration {
  int integrationId;
  String name;
  String businessCode;
  String businessName;
  String integrationKey;
  String status;
  String businessStatus;
  bool isDynamicSpliting;
  List<String> channels;
  List<IntegrationChannel> integrationChannels;
  List<Transaction> transactions;

  Integration({
    this.integrationId,
    this.name,
    this.businessCode,
    this.businessName,
    this.integrationKey,
    this.status,
    this.businessStatus,
    this.isDynamicSpliting,
    this.channels,
    this.integrationChannels,
    this.transactions,
  });

  factory Integration.fromJson(Map<String, dynamic> json) => Integration(
    integrationId: json["integrationId"],
    name: json["name"],
    businessCode: json["businessCode"],
    businessName: json["businessName"],
    integrationKey: json["integrationKey"],
    status: json["status"],
    businessStatus: json["businessStatus"],
    isDynamicSpliting: json["isDynamicSpliting"],
    channels: List<String>.from(json["channels"].map((x) => x)),
    integrationChannels: List<IntegrationChannel>.from(json["integrationChannels"].map((x) => IntegrationChannel.fromJson(x))),
    transactions: List<Transaction>.from(json["transactions"].map((x) => Transaction.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "integrationId": integrationId,
    "name": name,
    "businessCode": businessCode,
    "businessName": businessName,
    "integrationKey": integrationKey,
    "status": status,
    "businessStatus": businessStatus,
    "isDynamicSpliting": isDynamicSpliting,
    "channels": List<dynamic>.from(channels.map((x) => x)),
    "integrationChannels": List<dynamic>.from(integrationChannels.map((x) => x.toJson())),
    "transactions": List<dynamic>.from(transactions.map((x) => x.toJson())),
  };
}

class IntegrationChannel {
  int integrationChannelId;
  int integrationId;
  int channelId;
  Channel channel;
  String status;
  String secretKey;

  IntegrationChannel({
    this.integrationChannelId,
    this.integrationId,
    this.channelId,
    this.channel,
    this.status,
    this.secretKey,
  });

  factory IntegrationChannel.fromJson(Map<String, dynamic> json) => IntegrationChannel(
    integrationChannelId: json["integrationChannelId"],
    integrationId: json["integrationId"],
    channelId: json["channelId"],
    channel: Channel.fromJson(json["channel"]),
    status: json["status"],
    secretKey: json["secretKey"],
  );

  Map<String, dynamic> toJson() => {
    "integrationChannelId": integrationChannelId,
    "integrationId": integrationId,
    "channelId": channelId,
    "channel": channel.toJson(),
    "status": status,
    "secretKey": secretKey,
  };
}

class Channel {
  int channelId;
  String name;
  String code;
  bool isDefault;
  bool isKeyRequired;
  bool isActive;
  List<dynamic> providers;

  Channel({
    this.channelId,
    this.name,
    this.code,
    this.isDefault,
    this.isKeyRequired,
    this.isActive,
    this.providers,
  });

  factory Channel.fromJson(Map<String, dynamic> json) => Channel(
    channelId: json["channelId"],
    name: json["name"],
    code: json["code"],
    isDefault: json["isDefault"],
    isKeyRequired: json["isKeyRequired"],
    isActive: json["isActive"],
    providers: List<dynamic>.from(json["providers"].map((x) => x)),
  );

  Map<String, dynamic> toJson() => {
    "channelId": channelId,
    "name": name,
    "code": code,
    "isDefault": isDefault,
    "isKeyRequired": isKeyRequired,
    "isActive": isActive,
    "providers": List<dynamic>.from(providers.map((x) => x)),
  };
}

class Transaction {
  int transactionId;
  String maskedCard;
  String reference;
  String processorRef;
  String channelCode;
  int adviceId;
  String processorCode;
  int providerId;
  String status;
  String message;
  Provider provider;
  DateTime createdOn;
  String otherInfo;
  String transactionType;
  String transactionIdentifier;
  String eciFlag;

  Transaction({
    this.transactionId,
    this.maskedCard,
    this.reference,
    this.processorRef,
    this.channelCode,
    this.adviceId,
    this.processorCode,
    this.providerId,
    this.status,
    this.message,
    this.provider,
    this.createdOn,
    this.otherInfo,
    this.transactionType,
    this.transactionIdentifier,
    this.eciFlag,
  });

  factory Transaction.fromJson(Map<String, dynamic> json) => Transaction(
    transactionId: json["transactionId"],
    maskedCard: json["maskedCard"],
    reference: json["reference"],
    processorRef: json["processorRef"],
    channelCode: json["channelCode"],
    adviceId: json["adviceId"],
    processorCode: json["processorCode"],
    providerId: json["providerId"],
    status: json["status"],
    message: json["message"],
    provider: Provider.fromJson(json["provider"]),
    createdOn: DateTime.parse(json["createdOn"]),
    otherInfo: json["otherInfo"],
    transactionType: json["transactionType"],
    transactionIdentifier: json["transactionIdentifier"],
    eciFlag: json["eciFlag"],
  );

  Map<String, dynamic> toJson() => {
    "transactionId": transactionId,
    "maskedCard": maskedCard,
    "reference": reference,
    "processorRef": processorRef,
    "channelCode": channelCode,
    "adviceId": adviceId,
    "processorCode": processorCode,
    "providerId": providerId,
    "status": status,
    "message": message,
    "provider": provider.toJson(),
    "createdOn": createdOn.toIso8601String(),
    "otherInfo": otherInfo,
    "transactionType": transactionType,
    "transactionIdentifier": transactionIdentifier,
    "eciFlag": eciFlag,
  };
}

class Provider {
  int providerId;
  String code;
  String name;
  int channelId;
  String channelCode;
  Channel channel;
  String status;
  List<dynamic> transactions;
  List<Parameter> parameters;
  List<Bin> bins;
  String processorRef;
  String walletCode;

  Provider({
    this.providerId,
    this.code,
    this.name,
    this.channelId,
    this.channelCode,
    this.channel,
    this.status,
    this.transactions,
    this.parameters,
    this.bins,
    this.processorRef,
    this.walletCode,
  });

  factory Provider.fromJson(Map<String, dynamic> json) => Provider(
    providerId: json["providerId"],
    code: json["code"],
    name: json["name"],
    channelId: json["channelId"],
    channelCode: json["channelCode"],
    channel: Channel.fromJson(json["channel"]),
    status: json["status"],
    transactions: List<dynamic>.from(json["transactions"].map((x) => x)),
    parameters: List<Parameter>.from(json["parameters"].map((x) => Parameter.fromJson(x))),
    bins: List<Bin>.from(json["bins"].map((x) => Bin.fromJson(x))),
    processorRef: json["processorRef"],
    walletCode: json["walletCode"],
  );

  Map<String, dynamic> toJson() => {
    "providerId": providerId,
    "code": code,
    "name": name,
    "channelId": channelId,
    "channelCode": channelCode,
    "channel": channel.toJson(),
    "status": status,
    "transactions": List<dynamic>.from(transactions.map((x) => x)),
    "parameters": List<dynamic>.from(parameters.map((x) => x.toJson())),
    "bins": List<dynamic>.from(bins.map((x) => x.toJson())),
    "processorRef": processorRef,
    "walletCode": walletCode,
  };
}

class Bin {
  int binId;
  int providerId;
  String binValue;
  String status;
  String cardScheme;

  Bin({
    this.binId,
    this.providerId,
    this.binValue,
    this.status,
    this.cardScheme,
  });

  factory Bin.fromJson(Map<String, dynamic> json) => Bin(
    binId: json["binId"],
    providerId: json["providerId"],
    binValue: json["binValue"],
    status: json["status"],
    cardScheme: json["cardScheme"],
  );

  Map<String, dynamic> toJson() => {
    "binId": binId,
    "providerId": providerId,
    "binValue": binValue,
    "status": status,
    "cardScheme": cardScheme,
  };
}

class Parameter {
  int parameterId;
  String key;
  String value;
  String description;
  int providerId;
  String env;

  Parameter({
    this.parameterId,
    this.key,
    this.value,
    this.description,
    this.providerId,
    this.env,
  });

  factory Parameter.fromJson(Map<String, dynamic> json) => Parameter(
    parameterId: json["parameterId"],
    key: json["key"],
    value: json["value"],
    description: json["description"],
    providerId: json["providerId"],
    env: json["env"],
  );

  Map<String, dynamic> toJson() => {
    "parameterId": parameterId,
    "key": key,
    "value": value,
    "description": description,
    "providerId": providerId,
    "env": env,
  };
}

class Split {
  int sharedSplitId;
  String itemCode;
  int amount;
  bool shouldDeductFrom;

  Split({
    this.sharedSplitId,
    this.itemCode,
    this.amount,
    this.shouldDeductFrom,
  });

  factory Split.fromJson(Map<String, dynamic> json) => Split(
    sharedSplitId: json["sharedSplitId"],
    itemCode: json["itemCode"],
    amount: json["amount"],
    shouldDeductFrom: json["shouldDeductFrom"],
  );

  Map<String, dynamic> toJson() => {
    "sharedSplitId": sharedSplitId,
    "itemCode": itemCode,
    "amount": amount,
    "shouldDeductFrom": shouldDeductFrom,
  };
}
