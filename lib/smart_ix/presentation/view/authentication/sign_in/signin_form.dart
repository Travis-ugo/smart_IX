// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:formz/formz.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:smart_ix/smart_ix/application/authentication/sign_in_cubit/signin_cubit.dart';
import 'package:smart_ix/smart_ix/presentation/view/authentication/sign_up/sign_up_page.dart';
import 'package:smart_ix/smart_ix/presentation/view/authentication/widgets/input_field.dart';
import 'package:smart_ix/smart_ix/presentation/view/authentication/widgets/social_auth.dart';

class SigninForm extends StatelessWidget {
  const SigninForm({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocListener<SigninCubit, SigninState>(
      listener: (context, state) {
        if (state.status.isSubmissionSuccess) {
          Navigator.pop(context);
        } else if (state.status.isSubmissionFailure) {
          ScaffoldMessenger.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(
              SnackBar(
                content: Text(state.errorMessage ?? 'Authentication Failure'),
              ),
            );
        }
      },
      child: Align(
        alignment: const Alignment(0, -1 / 3),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: ListView(
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 30, bottom: 15),
                child: Text(
                  'Log in',
                  style: GoogleFonts.varelaRound(
                    fontSize: 31,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
              Text(
                'Log in with one of the following options',
                style: GoogleFonts.varelaRound(
                  fontSize: 14,
                  fontWeight: FontWeight.w300,
                ),
              ),
              const SizedBox(height: 15),
              const GoogleButton(),
              const _EmailInput(),
              const _PassWordInput(),
              const SizedBox(height: 15),
              const _SignUpButton(),
              const SizedBox(height: 15),
              const _SwitchButton(),
            ],
          ),
        ),
      ),
    );
  }
}

class _EmailInput extends StatelessWidget {
  const _EmailInput({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SigninCubit, SigninState>(
      buildWhen: (previous, current) => previous.email != current.email,
      builder: (context, state) {
        return InputAuthForm(
          errorState: state.email.invalid,
          hintText: 'email address',
          label: 'Email Address',
          onChanged: (email) => context.read<SigninCubit>().emailChanged(email),
        );
      },
    );
  }
}

class _PassWordInput extends StatelessWidget {
  const _PassWordInput({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SigninCubit, SigninState>(
        buildWhen: (previous, current) => previous.password != current.password,
        builder: (context, state) {
          return InputAuthForm(
            errorState: state.password.invalid,
            hintText: 'password',
            label: 'Password',
            onChanged: (password) =>
                context.read<SigninCubit>().passwordChanged(password),
          );
        });
  }
}

class _SignUpButton extends StatelessWidget {
  const _SignUpButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SigninCubit, SigninState>(
      buildWhen: (previous, current) => previous.password != current.password,
      builder: (context, state) {
        return state.status.isSubmissionInProgress
            ? const CircularProgressIndicator()
            : ElevatedButton(
                onPressed: () =>
                    context.read<SigninCubit>().signInWithCredentials(),
                key: const Key('SigninForm_continue_raisedButton'),
                style: ElevatedButton.styleFrom(
                  elevation: 0.0,
                  padding: const EdgeInsets.all(20),
                  minimumSize: const Size(double.infinity, 45),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20.0),
                  ),
                  primary: Colors.lightBlueAccent,
                ),
                child: const Text('log in'),
              );
      },
    );
  }
}

class GoogleButton extends StatelessWidget {
  const GoogleButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        SocialAuthButton(
          iconData: FontAwesomeIcons.google,
          onPressed: () => context.read<SigninCubit>().signInWithGoogle(),
        ),
        const SizedBox(width: 20),
        SocialAuthButton(
          iconData: FontAwesomeIcons.google,
          onPressed: () => context.read<SigninCubit>().signInWithGoogle(),
        ),
      ],
    );
  }
}

class _SwitchButton extends StatelessWidget {
  const _SwitchButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return RichText(
      text: TextSpan(
        text: "Don't have an account? ",
        style: GoogleFonts.varelaRound(
          fontWeight: FontWeight.w500,
          color: Colors.grey[500],
          fontSize: 16,
        ),
        children: <TextSpan>[
          TextSpan(
            text: 'Sign up',
            style: GoogleFonts.varelaRound(
              fontWeight: FontWeight.w700,
              color: Colors.grey[200],
              fontSize: 16,
            ),
            recognizer: TapGestureRecognizer()
              ..onTap = () {
                print('button tapped');
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const SignupPage()),
                );
              },
          ),
        ],
      ),
    );
  }
}
