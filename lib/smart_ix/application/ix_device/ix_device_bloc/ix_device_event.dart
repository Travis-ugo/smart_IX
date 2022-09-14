part of 'ix_device_bloc.dart';

abstract class IxDeviceEvent extends Equatable {
  const IxDeviceEvent();

  @override
  List<Object> get props => [];
}

class LoadIxDevice extends IxDeviceEvent {
  final List<IxDevice> ixDevice;

  const LoadIxDevice({this.ixDevice = const <IxDevice>[]});

  @override
  List<Object> get props => [ixDevice];
}

class AddIxDevice extends IxDeviceEvent {
  final IxDevice ixDevice;

  const AddIxDevice({required this.ixDevice});

  @override
  List<Object> get props => [ixDevice];
}

class EditIxDevice extends IxDeviceEvent {
  final IxDevice ixDevice;

  const EditIxDevice({required this.ixDevice});

  @override
  List<Object> get props => [ixDevice];
}

class RemoveIxDevice extends IxDeviceEvent {
  final IxDevice ixDevice;

  const RemoveIxDevice({required this.ixDevice});

  @override
  List<Object> get props => [ixDevice];
}
