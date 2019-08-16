import 'package:serializable/serializable.dart';

@serializable
class ChargeResponse implements Serializable {

  String reference;

  String status;

  String redirectUrl;

  String message;

  String reason;

  String responseAction;


  ChargeResponse();

  String getReference() {
    return reference;
  }

  void setReference(String reference) {
    this.reference = reference;
  }

  String getStatus() {
    return status;
  }

  void setStatus(String status) {
    this.status = status;
  }

  String getRedirectUrl() {
    return redirectUrl;
  }

  void setRedirectUrl(String redirectUrl) {
    this.redirectUrl = redirectUrl;
  }

  String getMessage() {
    return message;
  }

  void setMessage(String message) {
    this.message = message;
  }

  String getReason() {
    return reason;
  }

  void setReason(String reason) {
    this.reason = reason;
  }

  String getResponseAction() {
    return responseAction;
  }

  void setResponseAction(String responseAction) {
    this.responseAction = responseAction;
  }
}