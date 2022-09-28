import 'package:smart_ix/smart_ix/presentation/view/automation/automation.dart';

class IfRoutinePage extends StatelessWidget {
  const IfRoutinePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          const CustomAppBarSmaller(
            appBarTitle: 'If',
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
                              builder: ((context) => const Time()),
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
                      bottomLeft: Radius.circular(
                          index == ifActions.length - 1 ? 25 : 0),
                      bottomRight: Radius.circular(
                          index == ifActions.length - 1 ? 25 : 0),
                    ),
                  ),
                  tileColor: Colors.grey[900],
                  minVerticalPadding: 10,
                  leading: Icon(
                    ifActions[index].iconData,
                    color: ifActions[index].iconColor,
                    size: 35,
                  ),
                  subtitle: Text(
                    ifActions[index].subTitle,
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w100,
                      color: Colors.grey,
                    ),
                  ),
                  title: Text(
                    ifActions[index].title,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
              ),
              childCount: ifActions.length,
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
