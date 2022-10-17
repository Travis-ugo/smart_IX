import 'package:smart_ix/smart_ix/presentation/view/automation/automation.dart';

class EditRoutine extends StatelessWidget {
  final SmartRoutines smartRoutines;
  const EditRoutine({
    Key? key,
    required this.smartRoutines,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RoutineCubit, RoutineState>(builder: (context, state) {
      return Scaffold(
        bottomNavigationBar: Container(
          height: 60,
          color: Colors.black,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              TextButton(
                onPressed: () {
                  context
                      .read<RoutineCubit>()
                      .deleteRoutine(smartRoutines.userId);
                  Navigator.pop(context);
                },
                child: const Text('Delete'),
              ),
              TextButton(
                onPressed: () {
                  context
                      .read<RoutineCubit>()
                      .createRoutine(smartRoutines.userId);
                  context.read<RoutineCubit>().cancelState();

                  Navigator.pop(context);
                },
                child: const Text('Save'),
              ),
            ],
          ),
        ),
        body: BlocBuilder<RoutineCubit, RoutineState>(
          builder: (context, state) {
            return CustomScrollView(
              slivers: [
                const CustomAppBarSmaller(
                  appBarTitle: '',
                ),
                const SliverToBoxAdapter(
                  child: SizedBox(height: 50),
                ),
                SliverToBoxAdapter(
                  child: EditRoutineName(
                    onChanged: (value) {
                      context.read<RoutineCubit>().routineTitle(value);
                    },
                    initial: state.routineTitle.value,
                  ),
                ),
                SliverToBoxAdapter(
                  child: EditBlock(
                    tag: 'if',
                    tileTitle: state.routineAction,
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const Time(),
                        ),
                      );
                    },
                    iconLabel: Icons.access_time_filled_rounded,
                    subTitle: 'Every day',
                  ),
                ),
                SliverToBoxAdapter(
                  child: EditBlock(
                    tileTitle: state.smartDevice,
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const ControlDevice(),
                        ),
                      );
                    },
                    switcher: Switch(
                      activeColor: const Color.fromRGBO(105, 240, 174, 1),
                      onChanged: (value) {
                        context.read<RoutineCubit>().smartDeviceState(value);
                      },
                      value: state.smartDeviceState,
                    ),
                    iconLabel: Icons.lightbulb,
                    iconColor: Colors.orangeAccent,
                    subTitle: state.smartDeviceState ? 'On' : 'off',
                    tag: 'then',
                  ),
                ),
                const SliverToBoxAdapter(
                  child: SizedBox(height: 300),
                ),
              ],
            );
          },
        ),
      );
    });
  }
}

class InputField extends StatelessWidget {
  final String? initialValue;
  final Function(String) onChanged;
  const InputField({
    Key? key,
    required this.onChanged,
    this.initialValue,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100,
      width: double.infinity,
      margin: const EdgeInsets.only(bottom: 10),
      child: TextFormField(
        initialValue: initialValue,
        onChanged: onChanged,
        style: GoogleFonts.varelaRound(
          fontSize: 20,
          fontWeight: FontWeight.w300,
        ),
      ),
    );
  }
}
