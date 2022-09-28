// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'routine_bloc.dart';

abstract class RoutinesState extends Equatable {
  const RoutinesState();

  @override
  List<Object> get props => [];
}

class RoutineLoading extends RoutinesState {}

class RoutineLoaded extends RoutinesState {
  final List<SmartRoutines> routine;
  const RoutineLoaded({
    this.routine = const <SmartRoutines>[],
  });

  @override
  List<Object> get props => [routine];
}
