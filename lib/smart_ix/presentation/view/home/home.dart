import 'home_model.dart';

class CentralWidget extends StatefulWidget {
  static Page<void> page() => const MaterialPage<void>(child: CentralWidget());
  const CentralWidget({Key? key}) : super(key: key);

  @override
  State<CentralWidget> createState() => _CentralWidgetState();
}

class _CentralWidgetState extends State<CentralWidget> {
  int currentPageIndex = 0;
  final screenWidget = const [
    FirstPage(),
    LogOutWidget(),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        backgroundColor: const Color(0xFF121212),
        unselectedItemColor: Colors.grey,
        selectedItemColor: Colors.white,
        elevation: 0.0,
        currentIndex: currentPageIndex,
        onTap: (index) => setState(() {
          currentPageIndex = index;
          print(currentPageIndex);
        }),
        items: const [
          BottomNavigationBarItem(
            label: 'Home',
            icon: Icon(FontAwesomeIcons.house),
          ),
          BottomNavigationBarItem(
            label: 'Sign out',
            icon: Icon(FontAwesomeIcons.arrowRightFromBracket),
          ),
        ],
      ),
      body: screenWidget[currentPageIndex],
    );
  }
}

class FirstPage extends StatelessWidget {
  const FirstPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        const HomeAppBar(),
        SliverToBoxAdapter(
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 10,
              vertical: 40,
            ),
            child: Text(
              'Routines',
              style: GoogleFonts.varelaRound(
                fontSize: 28,
                fontWeight: FontWeight.w800,
              ),
            ),
          ),
        ),
        const SliverToBoxAdapter(
          child: WeatherWidget(),
        ),
        SliverToBoxAdapter(
          child: Padding(
            padding: const EdgeInsets.only(bottom: 30),
            child: CreateCard(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => const CreateRoutine(),
                  ),
                );
              },
              title: 'Create routine',
              subTitle:
                  'Make your devices respond automatically to different circumstances',
            ),
          ),
        ),
        const RoutineDisplay(),
      ],
    );
  }
}
