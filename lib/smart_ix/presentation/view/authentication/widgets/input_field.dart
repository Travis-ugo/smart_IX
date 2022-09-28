import 'package:flutter/material.dart';

class InputAuthForm extends StatelessWidget {
  final Function(String) onChanged;
  final String hintText;

  final bool errorState;
  final String label;
  const InputAuthForm({
    Key? key,
    required this.onChanged,
    required this.hintText,
    required this.errorState,
    required this.label,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 15),
      child: Column(
        children: [
          Align(
            alignment: Alignment.topLeft,
            child: Text(
              label,
              textAlign: TextAlign.left,
            ),
          ),
          const SizedBox(height: 15),
          TextField(
            key: const Key('signin_form_field'),
            onChanged: onChanged,
            decoration: InputDecoration(
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(20.0),
              ),
              hintText: hintText,
              errorText: errorState ? 'invalid input' : null,
            ),
          ),
        ],
      ),
    );
  }
}
