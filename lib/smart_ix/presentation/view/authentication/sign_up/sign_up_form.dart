import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:formz/formz.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:smart_ix/smart_ix/application/authentication/sign_up_cubit/signup_cubit.dart';
import 'package:smart_ix/smart_ix/presentation/view/authentication/sign_in/signin_page.dart';
import 'package:smart_ix/smart_ix/presentation/view/authentication/widgets/input_field.dart';
import 'package:smart_ix/smart_ix/presentation/view/authentication/widgets/social_auth.dart';

class SignupForm extends StatelessWidget {
  const SignupForm({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocListener<SignupCubit, SignupState>(
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
            children: const [
              SizedBox(height: 30),
              Text(
                'Sign up',
                style: TextStyle(fontSize: 31, fontWeight: FontWeight.w700),
              ),
              SizedBox(height: 15),
              Text(
                'Sign up with one of the following options',
                style: TextStyle(fontSize: 14, fontWeight: FontWeight.w300),
              ),
              SizedBox(height: 15),
              GoogleButton(),
              _EmailInput(),
              _PasswordInput(),
              _ConfirmPasswordInput(),
              SizedBox(height: 15),
              _SignUpButton(),
              SizedBox(height: 15),
              _SwitchButton(),
              SizedBox(height: 15),
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
    return BlocBuilder<SignupCubit, SignupState>(
      buildWhen: (previous, current) => previous.email != current.email,
      builder: (context, state) {
        return InputAuthForm(
          errorState: state.email.invalid,
          hintText: 'email address',
          label: 'Email Address',
          onChanged: (email) => context.read<SignupCubit>().emailChanged(email),
        );
      },
    );
  }
}

class _PasswordInput extends StatelessWidget {
  const _PasswordInput({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SignupCubit, SignupState>(
      buildWhen: (previous, current) => previous.password != current.password,
      builder: (context, state) {
        return InputAuthForm(
          errorState: state.password.invalid,
          hintText: 'password',
          label: 'Password',
          onChanged: (password) =>
              context.read<SignupCubit>().passwordChanged(password),
        );
      },
    );
  }
}

class _ConfirmPasswordInput extends StatelessWidget {
  const _ConfirmPasswordInput({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SignupCubit, SignupState>(
      buildWhen: (previous, current) =>
          previous.password != current.password ||
          previous.confirmedPassword != current.confirmedPassword,
      builder: (context, state) {
        return InputAuthForm(
          errorState: state.confirmedPassword.invalid,
          hintText: 'confirm password',
          label: 'Confirm Password',
          onChanged: (confirmPassword) => context
              .read<SignupCubit>()
              .confirmPasswordChanged(confirmPassword),
        );
      },
    );
  }
}

class _SignUpButton extends StatelessWidget {
  const _SignUpButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SignupCubit, SignupState>(
      buildWhen: (previous, current) => previous.password != current.password,
      builder: (context, state) {
        return state.status.isSubmissionInProgress
            ? const CircularProgressIndicator()
            : ElevatedButton(
                onPressed: () =>
                    context.read<SignupCubit>().signupFormSubmitted(),
                key: const Key('signUpForm_continue_raisedButton'),
                style: ElevatedButton.styleFrom(
                  elevation: 0.0,
                  padding: const EdgeInsets.all(20),
                  minimumSize: const Size(double.infinity, 50),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20.0),
                  ),
                  primary: Colors.lightBlueAccent,
                ),
                child: const Text(
                  'sign up',
                  style: TextStyle(color: Colors.white),
                ),
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
          onPressed: () => context.read<SignupCubit>().signUpWithGoogle(),
        ),
        const SizedBox(width: 20),
        SocialAuthButton(
          iconData: FontAwesomeIcons.google,
          onPressed: () => context.read<SignupCubit>().signUpWithGoogle(),
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
        text: 'Already have an account? ',
        style: GoogleFonts.varelaRound(
          fontWeight: FontWeight.w500,
          color: Colors.grey[500],
          fontSize: 16,
        ),
        children: <TextSpan>[
          TextSpan(
            text: 'Log in',
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
                  MaterialPageRoute(builder: (context) => const SigninPage()),
                );
              },
          ),
        ],
      ),
    );
  }
}
