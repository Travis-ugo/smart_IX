import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smart_ix/smart_ix/application/authentication/sign_up_cubit/signup_cubit.dart';
import 'package:smart_ix/smart_ix/infrastructure/authentication/firebase_auth.dart';

import 'sign_up_form.dart';

class SignupPage extends StatelessWidget {
  const SignupPage({Key? key}) : super(key: key);

  static Page<void> page() => const MaterialPage<void>(child: SignupPage());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(8),
        child: BlocProvider<SignupCubit>(
          child: const SignupForm(),
          create: (_) => SignupCubit(
            context.read<AuthenticationRepository>(),
          ),
        ),
      ),
    );
  }
}
