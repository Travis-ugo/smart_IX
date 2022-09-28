import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:smart_ix/smart_ix/application/authentication/sign_in_cubit/signin_cubit.dart';

class SocialAuthButton extends StatelessWidget {
  final IconData iconData;
  final Function() onPressed;
  const SocialAuthButton({
    Key? key,
    required this.iconData,
    required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ElevatedButton(
        onPressed: onPressed,
        key: const Key('socialAuth_button'),
        style: ElevatedButton.styleFrom(
          elevation: 0.0,
          padding: const EdgeInsets.all(20),
          minimumSize: const Size(double.infinity, 45),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20.0),
          ),
          primary: Colors.lightBlueAccent,
        ),
        child: Icon(iconData, color: Colors.white),
      ),
    );
  }
}
