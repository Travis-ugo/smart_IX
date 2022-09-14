part of 'ix_device_bloc.dart';

abstract class IxDeviceState extends Equatable {
  const IxDeviceState();

  @override
  List<Object> get props => [];
}

class IxDeviceLoading extends IxDeviceState {}

@JsonSerializable()
class IxDeviceLoaded extends IxDeviceState {
  final List<IxDevice> ixDevice;

  const IxDeviceLoaded({this.ixDevice = const <IxDevice>[]});

  // factory IxDeviceLoaded.fromJson(Map<String, dynamic> json) =>
  //     IxDeviceLoadedFromJson();

  @override
  List<Object> get props => [ixDevice];
}
