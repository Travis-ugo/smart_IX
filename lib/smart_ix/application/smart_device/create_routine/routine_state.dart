// ignore_for_file: public_member_api_docs, sort_constructors_first

part of 'routine_cubit.dart';

class RoutineState extends Equatable {
  final String userId;
  final bool smartDeviceState;
  final String routineAction;
  final String smartDevice;
  final Title routineTitle;

  final FormzStatus status;

  const RoutineState({
    this.userId = '',
    this.smartDeviceState = false,
    this.routineAction = '',
    this.smartDevice = '',
    this.routineTitle = const Title.pure(),
    this.status = FormzStatus.pure,
  });

  @override
  List<Object> get props => [
        routineTitle,
        status,
        smartDevice,
        smartDeviceState,
        routineAction,
        userId,
      ];

  RoutineState copyWith({
    String? userId,
    bool? smartDeviceState,
    String? routineAction,
    String? smartDevice,
    Title? routineTitle,
    FormzStatus? status,
  }) {
    return RoutineState(
      userId: userId ?? this.userId,
      smartDeviceState: smartDeviceState ?? this.smartDeviceState,
      routineAction: routineAction ?? this.routineAction,
      smartDevice: smartDevice ?? this.smartDevice,
      routineTitle: routineTitle ?? this.routineTitle,
      status: status ?? this.status,
    );
  }
}
