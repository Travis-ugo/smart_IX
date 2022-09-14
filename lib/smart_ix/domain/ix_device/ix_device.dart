// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

class IxDevice extends Equatable {
  final String id;
  final String deviceName;
  final IconData deviceIcon;
  final Color deviceColor;
  const IxDevice({
    required this.id,
    required this.deviceName,
    required this.deviceIcon,
    required this.deviceColor,
  });

  IxDevice copyWith({
    String? id,
    String? deviceName,
    IconData? deviceIcon,
    Color? deviceColor,
  }) {
    return IxDevice(
      id: id ?? this.id,
      deviceName: deviceName ?? this.deviceName,
      deviceIcon: deviceIcon ?? this.deviceIcon,
      deviceColor: deviceColor ?? this.deviceColor,
    );
  }

  @override
  List<Object?> get props => [id, deviceName, deviceIcon, deviceColor];
}
