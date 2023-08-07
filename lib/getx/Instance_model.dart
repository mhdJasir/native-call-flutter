import 'package:get/get.dart';
import 'package:train/getx/instance_controller.dart';

class InstanceModel {
  final InstanceController controller;
  final String name;

  InstanceModel({
    required this.controller,
    required this.name,
  });

  static List<InstanceModel> instances = [
    InstanceModel(
        name: "1",
        controller:
            Get.put<InstanceController>(InstanceController(), tag: "1"),
    ),
    InstanceModel(
        name: "2",
        controller:
            Get.put<InstanceController>(InstanceController(), tag: "2"),
    ),
  ];
}
