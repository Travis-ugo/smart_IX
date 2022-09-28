import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:smart_ix/smart_ix/application/authentication/auth_bloc/app_bloc.dart';

class HomeAppBar extends StatelessWidget {
  const HomeAppBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final user = context.select((AppBloc appBloc) => appBloc.state.user);
    return SliverAppBar(
      automaticallyImplyLeading: false,
      backgroundColor: const Color(0xFF121212),
      elevation: 0.0,
      centerTitle: false,
      collapsedHeight: 80,
      title: Container(
        height: 60,
        width: double.infinity,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(30),
          color: Colors.grey[800],
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Icon(
                Icons.menu,
                color: Colors.white,
              ),
              const Text(
                'Smart Ix',
                style: TextStyle(color: Colors.white),
              ),
              CircleAvatar(
                backgroundColor: Colors.grey,
                radius: 20,
                backgroundImage:
                    user.photo != null ? NetworkImage(user.photo ?? '') : null,
                child: user.photo != null
                    ? null
                    : const Icon(
                        Icons.person,
                        size: 20,
                      ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
