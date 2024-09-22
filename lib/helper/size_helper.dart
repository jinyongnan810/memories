import 'package:flutter/material.dart';

class SizeHelper {
  static bool isSmallDevice(BuildContext context) {
    return MediaQuery.sizeOf(context).width < 500;
  }
}
