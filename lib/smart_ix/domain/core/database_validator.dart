import 'package:formz/formz.dart';

enum RoutineActionVError { invalid }

class RoutineActionV extends FormzInput<String, RoutineActionVError> {
  const RoutineActionV.pure() : super.pure('');

  const RoutineActionV.dirty([super.value = '']) : super.dirty();

  @override
  RoutineActionVError? validator(String? value) {
    return value!.isEmpty ? null : RoutineActionVError.invalid;
  }
}

enum SmartDeviceVError { invalid }

class SmartDeviceV extends FormzInput<String, SmartDeviceVError> {
  const SmartDeviceV.pure() : super.pure('');

  const SmartDeviceV.dirty([super.value = '']) : super.dirty();

  @override
  SmartDeviceVError? validator(String? value) {
    return value!.isEmpty ? null : SmartDeviceVError.invalid;
  }
}

enum TitleError { invalid }

class Title extends FormzInput<String, TitleError> {
  const Title.pure() : super.pure('');

  const Title.dirty([super.value = '']) : super.dirty();

  static final RegExp _title = RegExp(
    r"^[a-zA-Z0-9_.-]*$",
  );

  @override
  TitleError? validator(String? value) {
    return _title.hasMatch(value ?? '') ? null : TitleError.invalid;
  }
}
