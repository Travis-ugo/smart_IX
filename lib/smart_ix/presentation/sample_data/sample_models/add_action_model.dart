import 'package:flutter/material.dart';

class AddAction {
  final String title;
  final IconData iconData;
  final Color iconColor;

  final String subTitle;
  const AddAction({
    required this.iconColor,
    required this.title,
    required this.iconData,
    required this.subTitle,
  });
}
