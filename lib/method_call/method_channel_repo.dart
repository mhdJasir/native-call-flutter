import 'package:flutter/services.dart';

class PlatformRepository {
  static const platform = MethodChannel('flutter.native/helper');

  Future<void> authenticate() async {
    await canAuthenticate();
    try {
      platform.setMethodCallHandler((call) => _fromNative(call));

      await platform.invokeMethod("auth", {
        "title": "Hiii plzz Login",
        "subTitle": "Hoooooooooooooi",
        "description": "Description goes here",
        "passwordButtonName": "poooooooodaaaaaaaaa",
        "confirmationRequired": false,
      });
    } on PlatformException catch (e) {
      print(e.message);
    } on FormatException catch (e) {
      print(e.message + e.source);
    }
  }

  Future<void> _fromNative(MethodCall call) async {
    if (call.method == "error") {
      showToast(call.arguments);
    } else if (call.method == "success") {
      showToast(call.arguments);
    } else {
      showToast(call.arguments);
    }
  }

  Future<void> canAuthenticate() async {
    final data = await platform.invokeMethod('canAuthenticate');
    print(data);
  }

  Future<void> showToast(String text) async {
    await platform.invokeMethod('showToast', {
      "text": text,
      "length": 0,
    });
  }
}
