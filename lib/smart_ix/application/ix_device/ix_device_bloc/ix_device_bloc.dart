import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:smart_ix/smart_ix/domain/ix_device/ix_device.dart';

part 'ix_device_event.dart';
part 'ix_device_state.dart';

class IxDeviceBloc extends Bloc<IxDeviceEvent, IxDeviceState> {
  IxDeviceBloc() : super(IxDeviceLoading()) {
    on<LoadIxDevice>(_onLoadIxDevice);
    on<AddIxDevice>(_onAddIxDevice);
    on<EditIxDevice>(_onEditIxDevice);
    on<RemoveIxDevice>(_onRemoveIxDevice);
  }

  void _onLoadIxDevice(LoadIxDevice event, Emitter<IxDeviceState> emit) {
    emit(IxDeviceLoaded(ixDevice: event.ixDevice));
  }

  void _onAddIxDevice(AddIxDevice event, Emitter<IxDeviceState> emit) {
    final state = this.state;
    if (state is IxDeviceLoaded) {
      emit(
        IxDeviceLoaded(
          ixDevice: List.from(state.ixDevice)..add(event.ixDevice),
        ),
      );
    }
  }

  void _onEditIxDevice(EditIxDevice event, Emitter<IxDeviceState> emit) {
    final state = this.state;
    if (state is IxDeviceLoaded) {
      List<IxDevice> ixDevice = (state.ixDevice.map((device) {
        return device.id == event.ixDevice.id ? event.ixDevice : device;
      })).toList();

      emit(IxDeviceLoaded(ixDevice: ixDevice));
    }
  }

  void _onRemoveIxDevice(RemoveIxDevice event, Emitter<IxDeviceState> emit) {
    final state = this.state;

    if (state is IxDeviceLoaded) {
      List<IxDevice> ixDevice = state.ixDevice.where((device) {
        return device.id != event.ixDevice.id;
      }).toList();
    }
  }
}
