import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smart_ix/smart_ix/application/authentication/sign_in_cubit/signin_cubit.dart';
import 'package:smart_ix/smart_ix/infrastructure/authentication/firebase_auth.dart';

import 'signin_form.dart';

class SigninPage extends StatelessWidget {
  const SigninPage({Key? key}) : super(key: key);

  static Page<void> page() => const MaterialPage<void>(child: SigninPage());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: BlocProvider(
          child: const SigninForm(),
          create: (_) => SigninCubit(
            context.read<AuthenticationRepository>(),
          ),
        ),
      ),
    );
  }
}
