import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:smart_ix/smart_ix/domain/database/routine.dart';

import 'package:smart_ix/smart_ix/infrastructure/smart_device/routine.dart';

part 'routine_event.dart';
part 'routine_state.dart';

class RoutinesBloc extends Bloc<RoutinesEvent, RoutinesState> {
  final RoutineRepository _routineRepository;
  StreamSubscription? _deviceSubscription;
  RoutinesBloc({
    required RoutineRepository routineRepository,
  })  : _routineRepository = routineRepository,
        super(RoutineLoading()) {
    on<LoadRoutine>(_onLoadDevice);
    on<UpdateRoutine>(_onUpdateDevice);
  }
  void _onLoadDevice(LoadRoutine event, Emitter<RoutinesState> emit) {
    _deviceSubscription?.cancel();
    _deviceSubscription = _routineRepository.getAllRoutine().listen(
          (device) => add(
            UpdateRoutine(device),
          ),
        );
  }

  void _onUpdateDevice(UpdateRoutine event, Emitter<RoutinesState> emit) {
    emit(RoutineLoaded(routine: event.device));
  }
}
