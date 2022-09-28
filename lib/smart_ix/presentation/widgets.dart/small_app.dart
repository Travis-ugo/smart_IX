import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomAppBarSmaller extends StatelessWidget {
  final String appBarTitle;

  const CustomAppBarSmaller({
    Key? key,
    required this.appBarTitle,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      backgroundColor: const Color(0xFF121212),
      pinned: true,
      elevation: 0.0,
      expandedHeight: 80,
      collapsedHeight: 80,
      automaticallyImplyLeading: false,
      flexibleSpace: FlexibleSpaceBar(
        titlePadding: const EdgeInsets.only(top: 20),
        expandedTitleScale: 1.0,
        title: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Row(
            children: [
              IconButton(
                  icon: const Icon(
                    Icons.chevron_left,
                    color: Colors.white,
                    size: 35,
                  ),
                  onPressed: () {
                    Navigator.pop(context);
                  }),
              const SizedBox(width: 10),
              Text(
                appBarTitle,
                style: GoogleFonts.varelaRound(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
