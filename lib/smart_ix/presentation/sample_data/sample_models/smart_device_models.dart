import 'package:flutter/material.dart';

class SmartDevice {
  final bool deviceIsOn;
  final String deviceName;
  final int deviceState;
  final IconData iconData;
  final Color iconColor;
  SmartDevice({
    required this.deviceIsOn,
    required this.deviceName,
    required this.deviceState,
    required this.iconData,
    required this.iconColor,
  });
}
