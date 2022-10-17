import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:smart_ix/smart_ix/application/authentication/auth_bloc/app_bloc.dart';

class LogOutWidget extends StatelessWidget {
  const LogOutWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final user = context.select((AppBloc appBloc) => appBloc.state.user);
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 40, bottom: 20),
                child: CircleAvatar(
                  backgroundColor: Colors.grey,
                  radius: 35,
                  backgroundImage: user.photo != null
                      ? NetworkImage(user.photo ?? '')
                      : null,
                  child: user.photo != null
                      ? null
                      : const Icon(
                          Icons.person,
                          size: 25,
                        ),
                ),
              ),
              Text(user.name ?? 'Hello'),
              const SizedBox(height: 20),
              Text(user.email ?? ''),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 30, vertical: 50),
                child: Divider(
                  color: Colors.grey,
                  thickness: 3.0,
                ),
              ),
              Text(
                'Smart IX',
                style: GoogleFonts.varelaRound(
                  color: Colors.grey,
                  fontSize: 26,
                  fontWeight: FontWeight.w800,
                ),
              ),
              const SizedBox(height: 30),
              const Text('By'),
              const SizedBox(height: 30),
              const Text('Travis okonicha'),
              const SizedBox(height: 30),
              ElevatedButton(
                onPressed: () =>
                    context.read<AppBloc>().add(AppLogoutRequest()),
                key: const Key('log_out_button'),
                style: ElevatedButton.styleFrom(
                  elevation: 0.0,
                  padding: const EdgeInsets.all(20),
                  minimumSize: const Size(double.infinity, 45),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20.0),
                  ),
                  primary: const Color.fromARGB(255, 236, 68, 68),
                ),
                child: const Text(
                  'log out',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
