import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:json_annotation/json_annotation.dart';

import 'package:smart_ix/smart_ix/application/application.dart';

part 'routine.g.dart';

/// Data stored in the cloud are converted to json, and form json
/// using the serializable package generator.
@JsonSerializable()
class SmartRoutines extends Equatable {
  final String userId;
  final String routineTitle;
  final String smartDeviceList;
  final String routineActionList;
  final bool smartDeviceState;

  const SmartRoutines({
    required this.userId,
    required this.routineTitle,
    required this.smartDeviceList,
    required this.routineActionList,
    required this.smartDeviceState,
  });

  @override
  List<Object?> get props => [routineTitle, routineActionList, smartDeviceList];

  factory SmartRoutines.fromJson(DocumentSnapshot json) =>
      _$SmartRoutinesFromJson(json);

  Map<String, dynamic> smartRoutineToJson(SmartRoutines smartRoutines) =>
      _$SmartRoutinesToJson(smartRoutines);
}
