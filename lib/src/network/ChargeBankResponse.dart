import 'package:serializable/serializable.dart';

@serializable
class ChargeBankResponse {

  String _status;

  String _message;


  String _responseAction;


  ChargeBankResponse();

  String get status => _status;

  String get message => _message;


}