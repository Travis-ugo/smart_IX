import 'package:smart_ix/smart_ix/presentation/view/automation/automation.dart';

class Time extends StatelessWidget {
  const Time({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var hourState = 0;
    var minuteState = 0;
    var amState = 0;
    var now = '';
    return Scaffold(
      bottomNavigationBar: Container(
        height: 60,
        color: Colors.black,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            TextButton(
              onPressed: () {
                BlocProvider.of<RoutineCubit>(context).routineAction('');
                Navigator.pop(context);
              },
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                if (amState == 0) {
                  now = 'AM';
                } else {
                  now = 'PM';
                }

                print('$hourState $minuteState $now');
                BlocProvider.of<RoutineCubit>(context)
                    .routineAction('$hourState : $minuteState $now');
                Navigator.pop(context);
              },
              child: const Text('Done'),
            ),
          ],
        ),
      ),
      body: CustomScrollView(
        slivers: [
          const CustomAppBarSmaller(appBarTitle: 'Time'),
          SliverFillRemaining(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Wheel(
                  itemCount: 13,
                  onChanged: (hour) {
                    hourState = hour;
                    print(hourState);
                  },
                ),
                Wheel(
                  itemCount: 60,
                  onChanged: (minute) {
                    minuteState = minute;
                    print(minuteState);
                  },
                ),
                WheelTime(
                  onChanged: (am) {
                    amState = am;
                    print(amState);
                  },
                ),
                Container(height: 5, width: 20, color: Colors.grey),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
