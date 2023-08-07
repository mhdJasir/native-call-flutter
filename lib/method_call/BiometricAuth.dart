import 'package:flutter/services.dart';

class BiometricAuth {
  BiometricAuth._();

  static final instance = BiometricAuth._();

  static const platform = MethodChannel('flutter.native/helper');

  Future<Auth> get canAuthenticate => _canAuthenticate();

  Future<Auth> _canAuthenticate() async {
    final data = await platform.invokeMethod('canAuthenticate');
    switch (data) {
      case "CanAuthenticate":
        return Auth.canAuthenticate;
      case "NoHardWare":
        return Auth.noHardWare;
      case "unAvailable":
        return Auth.unAvailable;
      case "noneEnrolled":
        return Auth.noneEnrolled;
      default:
        return Auth.unAvailable;
    }
  }

  Future<void> authenticate({required BiometricDetails details}) async {
    try {
      platform.setMethodCallHandler((call) => _fromNative(call));

      await platform.invokeMethod("auth", details.toJson());
    } on PlatformException catch (_) {
      rethrow;
    } on FormatException catch (_) {
      rethrow;
    }
  }

  Future<void> _fromNative(MethodCall call) async {
    if (call.method == "error") {
      throw PlatformException(code: '0');
    } else if (call.method == "success") {
      throw PlatformException(code: '0');
    } else {
      throw PlatformException(code: '0');
    }
  }
}

enum Auth {
  canAuthenticate,
  noHardWare,
  unAvailable,
  noneEnrolled,
}

class BiometricDetails {
  String title;
  String subTitle;
  String description;
  String passwordButtonName;
  bool confirmationRequired;

  BiometricDetails({
    required this.title,
    required this.subTitle,
    this.confirmationRequired = true,
    required this.description,
    required this.passwordButtonName,
  });

  Map toJson() {
    Map data = {};
    data["title"] = title;
    data["subTitle"] = subTitle;
    data["confirmationRequired"] = confirmationRequired;
    data["description"] = description;
    data["passwordButtonName"] = passwordButtonName;
    return data;
  }
}
