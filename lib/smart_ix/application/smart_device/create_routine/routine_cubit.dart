import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:formz/formz.dart';
import 'package:smart_ix/smart_ix/domain/core/database_validator.dart';
import 'package:smart_ix/smart_ix/domain/database/routine.dart';

import 'package:smart_ix/smart_ix/infrastructure/smart_device/routine.dart';

part 'routine_state.dart';

class RoutineCubit extends Cubit<RoutineState> {
  RoutineCubit(
    this._routineRepository,
  ) : super(const RoutineState());

  final RoutineRepository _routineRepository;

  void routineTitle(String value) {
    final routineTitle = Title.dirty(value);

    emit(
      state.copyWith(
        routineTitle: routineTitle,
        status: Formz.validate(
          [routineTitle],
        ),
      ),
    );
  }

  void smartDevice(String value) {
    emit(state.copyWith(smartDevice: value));
  }

  void routineAction(String value) {
    emit(state.copyWith(routineAction: value));
  }

  void smartDeviceState(bool value) {
    emit(state.copyWith(smartDeviceState: value));
  }

  void cancelState() {
    emit(state.copyWith(
      routineAction: '',
      routineTitle: const Title.pure(),
      smartDevice: '',
      smartDeviceState: false,
      status: FormzStatus.pure,
    ));
  }

  Future<void> createRoutine(String id) async {
    if (!state.status.isValidated) return;
    emit(state.copyWith(status: FormzStatus.submissionInProgress));

    try {
      _routineRepository.createRoutine(
          SmartRoutines(
            userId: id,
            routineTitle: state.routineTitle.value,
            smartDeviceList: state.smartDevice,
            routineActionList: state.routineAction,
            smartDeviceState: state.smartDeviceState,
          ),
          id);

      emit(state.copyWith(status: FormzStatus.submissionSuccess));
    } catch (_) {
      emit(state.copyWith(status: FormzStatus.submissionFailure));
    }
  }

  Future<void> deleteRoutine(String id) async {
    try {
      await _routineRepository.deleteRoutine(id);
    } catch (_) {
      emit(state.copyWith(status: FormzStatus.submissionFailure));
    }
  }
}
