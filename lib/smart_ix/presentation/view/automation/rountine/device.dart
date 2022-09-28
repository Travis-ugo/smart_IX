import 'package:smart_ix/smart_ix/presentation/view/automation/automation.dart';

class ControlDevice extends StatelessWidget {
  const ControlDevice({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          const CustomAppBarSmaller(
            appBarTitle: 'Device',
          ),
          const SliverToBoxAdapter(
            child: SizedBox(height: 30),
          ),
          SliverList(
            delegate: SliverChildBuilderDelegate(
              (context, index) => Padding(
                padding: const EdgeInsets.symmetric(vertical: 2),
                child: ListTile(
                  contentPadding:
                      const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(index == 0 ? 25 : 0),
                      topRight: Radius.circular(index == 0 ? 25 : 0),
                      bottomLeft: Radius.circular(
                          index > availableDevices.length ? 25 : 0),
                      bottomRight: Radius.circular(
                          index > availableDevices.length ? 25 : 0),
                    ),
                  ),
                  tileColor: Colors.grey[900],
                  minVerticalPadding: 10,
                  trailing: Ink(
                    decoration: ShapeDecoration(
                      color: Colors.grey.shade800,
                      shape: const CircleBorder(),
                    ),
                    child: IconButton(
                      icon: const Icon(Icons.add, color: Colors.blueAccent),
                      onPressed: () {
                        context.read<RoutineCubit>().smartDevice(
                              availableDevices[index].deviceName,
                            );
                        Navigator.pop(context);
                      },
                    ),
                  ),
                  leading: Icon(
                    availableDevices[index].iconData,
                    size: 30,
                    color: availableDevices[index].iconColor,
                  ),
                  subtitle: Text(
                    availableDevices[index].deviceIsOn ? 'On' : 'Off',
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w100,
                      color: Colors.grey,
                    ),
                  ),
                  title: Text(
                    availableDevices[index].deviceName,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
              ),
              childCount: availableDevices.length,
            ),
          ),
          const SliverToBoxAdapter(
            child: SizedBox(height: 300),
          ),
        ],
      ),
    );
  }
}
