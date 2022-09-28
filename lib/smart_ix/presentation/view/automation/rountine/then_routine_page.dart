import 'package:smart_ix/smart_ix/presentation/view/automation/automation.dart';

class ThenRoutinePage extends StatelessWidget {
  const ThenRoutinePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          const CustomAppBarSmaller(
            appBarTitle: 'Then',
          ),
          const SliverToBoxAdapter(
            child: SizedBox(height: 30),
          ),
          SliverList(
            delegate: SliverChildBuilderDelegate(
              (context, index) => Padding(
                padding: const EdgeInsets.symmetric(vertical: 2),
                child: ListTile(
                  onTap: () {
                    index == 0
                        ? Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: ((context) => const ControlDevice()),
                            ),
                          )
                        : null;
                  },
                  contentPadding:
                      const EdgeInsets.symmetric(horizontal: 30, vertical: 5),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(index == 0 ? 25 : 0),
                      topRight: Radius.circular(index == 0 ? 25 : 0),
                      bottomLeft:
                          Radius.circular(index > thenActins.length ? 25 : 0),
                      bottomRight:
                          Radius.circular(index > thenActins.length ? 25 : 0),
                    ),
                  ),
                  tileColor: Colors.grey[900],
                  minVerticalPadding: 10,
                  leading: Icon(thenActins[index].iconData,
                      size: 30, color: thenActins[index].iconColor),
                  subtitle: Text(thenActins[index].subTitle),
                  title: Text(thenActins[index].title),
                ),
              ),
              childCount: thenActins.length,
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
