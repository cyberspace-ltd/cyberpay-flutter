# Flutter Cyber Pay SDK 

A Flutter package allows you to easily implement the Cyber Pay Credit Card's UI easily with the Card detection.

[![Codacy Badge](https://api.codacy.com/project/badge/Grade/e546818ff64e4883a18a920f6a1c091c)](https://github.com/cyberspace-ltd/cyberpay-flutter.git)

## Preview

![The example app running in Android](https://github.com/simformsolutions/flutter_credit_card/blob/master/preview/preview.gif)

## Installing

1.  Add dependency to `pubspec.yaml`

    *Get the latest version in the 'Installing' tab on pub.dartlang.org*
    
```dart
dependencies:
    cyberpaysdkflutter: ^1.0.0+14
```

2.  Import the package
```dart
import 'package:cyberpaysdkflutter/ui/credit_card_model.dart';

import 'package:cyberpaysdkflutter/ui/flutter_credit_card.dart';
```

3.  Adding CreditCardWidget

*With required parameters*
```dart

    CreditCardWidget(
        cardNumber: cardNumber.trim(),
        expiryDate: expiryDate,
        cardHolderName: cardHolderName,
        cvvCode: cvvCode,
        showBackView: isCvvFocused, //true when you want to show cvv(back) view
        cardPin: cardPin,
    ),
    
```    
*With optional parameters*
```dart   
    CreditCardWidget(
        cardNumber: cardNumber,
        expiryDate: expiryDate,
        cardHolderName: cardHolderName,
        cvvCode: cvvCode,
        showBackView: isCvvFocused,
        cardbgColor: Colors.black,
        cardPin: cardPin,
        height: 175,
        textStyle: TextStyle(color: Colors.yellowAccent),
        width: MediaQuery.of(context).size.width,
        animationDuration: Duration(milliseconds: 1000),
        ),
``` 
3.  Adding CreditCardForm

```dart

  TransactionModel _transModel = TransactionModel(
      merchantRef: "merch_reference",
      amount: int.parse("amount") * 100,
      customerEmail: "email@gmail.com",
      integrationKey: "INTEGRATION KEY",
      returnUrl: "https://your return url.com/",
      customerMobile: "070949348483",
      customerName: "Surname Middlename",
      description: "Transaction from Flutter SDK",
    );

    TransactionRepository.getInstance(CyberPayApi())
        .beginTransactionApi(
            transactionModelToJson(_transModel))
        .then((result) {

      var reference = result.data.transactionReference;

      CardModel _charge = CardModel(
          name: cardHolderName,
          cardNumber: cardNumber.replaceAll(
              new RegExp(r"\s+\b|\b\s"), ""),
          expiryMonth: int.parse(splitDate[0]),
          expiryYear: int.parse(splitDate[1]),
          cvv: cvvCode,
          cardPin: cardPin,
          reference: reference);

    if (cardResult.data.status == "Failed") {
          var loadingBar = FlushbarHelper.createLoading(
              message: cardResult.data.message,
              linearProgressIndicator: null);
          loadingBar..show(context);
        }
        if (cardResult.data.status == "Otp") {
          Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => new HomeScreen(
                    busSchedule: widget._busSchedule,
                    bookingForm: widget._bookingForm,
                    transactionModel: _charge,
                    payload: payload)),
          );
        }
    
        else if (cardResult.data.status == "Success") {
          var loadingBar = FlushbarHelper.createLoading(
              message:
              "Transaction successful: Transaction Ref: {$reference}",
              linearProgressIndicator: null);
          loadingBar..show(context);
        } else if (cardResult.data.status == "ProvidePin") {
          var loadingBar = FlushbarHelper.createLoading(
              message:
              "Transaction successful: Transaction Ref: {$reference}",
              linearProgressIndicator: null);
          loadingBar..show(context);
        } else if (cardResult.data.status == "Successful") {
          var loadingBar = FlushbarHelper.createLoading(
              message:
              "Transaction successful: with Transaction Ref: {$reference}",
              linearProgressIndicator: null);
          loadingBar..show(context);
        } else if (cardResult.data.status == "EnrollOtp") {
    
        } else if (cardResult.data.status == "Secure3D") {
          var url = cardResult.data.redirectUrl;
          if (await canLaunch(url)) {
        await launch(url);
        }
        } else if (cardResult.data.status == "Secure3DMpgs") {
        var url = cardResult.data.redirectUrl;
        if (await canLaunch(url)) {
        await launch(url);
        }
        } else if (cardResult.data.status == "Successful") {
        var loadingBar = FlushbarHelper.createLoading(
        message:
        "Transaction successful: Transaction Ref: {$reference}",
        linearProgressIndicator: null);
        loadingBar..show(context);
        }

```

## How to use
Check out the **example** app in the [example](example) directory or the 'Example' tab on pub.dartlang.org for a more complete example.

## Getting Started

This project is a starting point for a Dart
[package](https://flutter.dev/developing-packages/),
a library module containing code that can be shared easily across
multiple Flutter or Dart projects.

For help getting started with Flutter, view our 
[online documentation](https://flutter.dev/docs), which offers tutorials, 
samples, guidance on mobile development, and a full API reference.
