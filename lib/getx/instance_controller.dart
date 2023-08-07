import 'package:get/get.dart';

class InstanceController extends GetxController {
  var count = 0;

  void increment() {
    count++;
    update();
  }

  void decrement() {
    count--;
    update();
  }
}
