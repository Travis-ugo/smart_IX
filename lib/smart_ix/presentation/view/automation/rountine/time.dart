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
                  },
                ),
                Wheel(
                  itemCount: 60,
                  onChanged: (minute) {
                    minuteState = minute;
                  },
                ),
                WheelTime(
                  onChanged: (am) {
                    amState = am;
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
