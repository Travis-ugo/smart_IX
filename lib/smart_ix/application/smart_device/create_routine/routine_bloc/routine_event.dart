part of 'routine_bloc.dart';

abstract class RoutinesEvent extends Equatable {
  const RoutinesEvent();

  @override
  List<Object> get props => [];
}

class LoadRoutine extends RoutinesEvent {}

class UpdateRoutine extends RoutinesEvent {
  final List<SmartRoutines> device;

  const UpdateRoutine(this.device);

  @override
  List<Object> get props => [];
}

class EditRoutineTitle extends RoutinesEvent {
  final String routineTitle;
  const EditRoutineTitle({
    required this.routineTitle,
  });

  @override
  List<Object> get props => [routineTitle];
}

class RoutineSubmitted extends RoutinesEvent {
  const RoutineSubmitted();
}
