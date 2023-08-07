import 'package:flutter/cupertino.dart';
import 'package:train/getx/Instance_model.dart';

class Constants {
  static InstanceModel selected = InstanceModel.instances.first;
}

Widget sbh(double h) => SizedBox(height: h);

Widget sbw(double w) => SizedBox(width: w);
