import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smart_ix/smart_ix/application/smart_device/create_routine/routine_bloc/routine_bloc.dart';
import 'package:smart_ix/smart_ix/application/smart_device/create_routine/routine_cubit.dart';
import 'package:smart_ix/smart_ix/presentation/view/automation/rountine/edit_routine.dart';
import 'package:smart_ix/smart_ix/presentation/view/automation/widget/routine_box.dart';

class RoutineDisplay extends StatelessWidget {
  const RoutineDisplay({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<RoutinesBloc, RoutinesState>(
        listener: (context, state) {
      if (state is RoutineLoaded) {
        ScaffoldMessenger.of(context)
          ..hideCurrentSnackBar()
          ..showSnackBar(
            SnackBar(
              content: Text('Available routines ${state.routine.length}'),
            ),
          );
      }
    }, builder: (context, state) {
      if (state is RoutineLoading) {
        return const SliverToBoxAdapter(child: CircularProgressIndicator());
      }
      if (state is RoutineLoaded) {
        return SliverGrid(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            childAspectRatio: 3 / 1.5,
            crossAxisCount: 2,
          ),
          delegate: SliverChildBuilderDelegate((context, index) {
            return RoutineBox(
              title: '${state.routine[index].routineTitle}\n',
              onTap: () {
                BlocProvider.of<RoutineCubit>(context)
                  ..routineAction(state.routine[index].routineActionList)
                  ..routineTitle(state.routine[index].routineTitle)
                  ..smartDevice(state.routine[index].smartDeviceList)
                  ..smartDeviceState(state.routine[index].smartDeviceState);

                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: ((context) => EditRoutine(
                          smartRoutines: state.routine[index],
                        )),
                  ),
                );
              },
            );
          }, childCount: state.routine.length),
        );
      }
      return SliverToBoxAdapter(child: Container());
    });
  }
}
