# Flutter Cyber Pay SDK 

A Flutter package allows you to easily implement the Cyber Pay Credit Card's UI easily with the Card detection.

[![Codacy Badge](https://api.codacy.com/project/badge/Grade/e546818ff64e4883a18a920f6a1c091c)](https://github.com/cyberspace-ltd/cyberpay-flutter.git)

## Installing

1.  Add dependency to `pubspec.yaml`

    *Get the latest version in the 'Installing' tab on pub.dartlang.org*
    
```dart
dependencies:
    cyberpay_flutterplugin: ^1.0.0+22
```

2.  Import the package
```dart
import 'package:cyberpay_flutterplugin/model/transaction_model.dart';
import 'package:flutter/services.dart';

```

3.  Adding TransactionObject

*With required parameters*
```dart

    TransactionObject transactionObject = TransactionObject(
          integrationKey: 'YOUR INTEGRATION KEY',
          amount: (100000)AMOUNT IN KOBO,
          customerEmail: "name@mail.com",
          liveMode: false);
      
    
      static const platform = const MethodChannel('com.startCyberPay/Channel');
    
```    
3.  Adding To your Payment Button

```dart

 FlatButton(
         onPressed: () async {
           String response = "";
           try {
             final String result = await platform.invokeMethod(
                 'chargeCard', transactionObject.toJson());
 
             response = result;
           } on PlatformException catch (e) {
             response = "Failed to Invoke: '${e.message}'.";
           }
         },

```
4.  Get Response Back from InitState

```dart

 @override
   void initState() {
     super.initState(); 
     
     platform.setMethodCallHandler((call) {
       final String argument = call.arguments;
       switch (call.method) {
         case "onSuccess":
           
           // Perform Action on Success
 
           break;
       }
     });
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
