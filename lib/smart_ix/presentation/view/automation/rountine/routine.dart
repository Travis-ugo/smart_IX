import 'package:smart_ix/smart_ix/presentation/view/automation/automation.dart';

class CreateRoutine extends StatelessWidget {
  final SmartRoutines? smartRoutines;
  const CreateRoutine({
    Key? key,
    this.smartRoutines,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    const userId = Uuid();
    return Scaffold(
      bottomNavigationBar: Container(
        height: 60,
        color: Colors.black,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            TextButton(
              onPressed: () {
                context.read<RoutineCubit>().cancelState();

                Navigator.pop(context);
              },
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (context) {
                    return AlertWidget(
                      onChanged: (String value) {
                        context.read<RoutineCubit>().routineTitle(value);
                      },
                      onTap: () {
                        print('button pressed');
                        context.read<RoutineCubit>().createRoutine(userId.v4());
                        Navigator.of(context).pop();
                      },
                    );
                  },
                );
              },
              child: const Text('Save'),
            ),
          ],
        ),
      ),
      body: BlocConsumer<RoutinesBloc, RoutinesState>(
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
        },
        builder: (context, state) {
          if (state is RoutineLoading) {
            return const Center(child: CircularProgressIndicator());
          }
          if (state is RoutineLoaded) {
            return CustomScrollView(
              slivers: [
                const CustomAppBar(
                  appBarTitle: 'Create Routine',
                ),
                SliverToBoxAdapter(
                  child: ActionsButton(
                    commandLabel: 'Add what will trigger this routine',
                    tileTitle: 'if',
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const IfRoutinePage(),
                        ),
                      );
                    },
                  ),
                ),
                BlocBuilder<RoutineCubit, RoutineState>(
                    builder: (context, state) {
                  print('the current RoutineAction is ${state.routineAction}');
                  return SliverToBoxAdapter(
                    child: state.routineAction.isNotEmpty
                        ? QueueButton(
                            tileTitle: state.routineAction,
                            subTitle: 'Every day',
                            iconLabel: Icons.access_time_filled_rounded,
                          )
                        : const SizedBox(),
                  );
                }),
                SliverToBoxAdapter(
                  child: ActionsButton(
                    commandLabel: 'Add what this routine will do',
                    tileTitle: 'Then',
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const ThenRoutinePage(),
                        ),
                      );
                    },
                  ),
                ),
                BlocBuilder<RoutineCubit, RoutineState>(
                    builder: (context, state) {
                  return SliverToBoxAdapter(
                    child: state.smartDevice.isNotEmpty
                        ? QueueButton(
                            tileTitle: state.smartDevice,
                            subTitle: state.smartDeviceState ? 'On' : 'Off',
                            switcher: Switch(
                              activeColor:
                                  const Color.fromRGBO(105, 240, 174, 1),
                              onChanged: (value) {
                                context
                                    .read<RoutineCubit>()
                                    .smartDeviceState(value);
                              },
                              value: state.smartDeviceState,
                            ),
                            iconLabel: Icons.lightbulb,
                            iconColor: Colors.orangeAccent,
                          )
                        : const SizedBox(),
                  );
                }),
                const SliverToBoxAdapter(
                  child: SizedBox(height: 300),
                )
              ],
            );
          } //

          return const Text('issues found');
        },
      ), //
    );
  }
}
