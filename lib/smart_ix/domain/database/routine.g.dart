// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'routine.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SmartRoutines _$SmartRoutinesFromJson(DocumentSnapshot json) => SmartRoutines(
      userId: json['userId'] as String,
      routineTitle: json['routineTitle'] as String,
      smartDeviceList: json['smartDeviceList'] as String,
      routineActionList: json['routineActionList'] as String,
      smartDeviceState: json['smartDeviceState'] as bool,
    );

Map<String, dynamic> _$SmartRoutinesToJson(SmartRoutines instance) =>
    <String, dynamic>{
      'userId': instance.userId,
      'routineTitle': instance.routineTitle,
      'smartDeviceList': instance.smartDeviceList,
      'routineActionList': instance.routineActionList,
      'smartDeviceState': instance.smartDeviceState,
    };
