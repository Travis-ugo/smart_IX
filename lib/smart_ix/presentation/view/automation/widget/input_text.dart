import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:smart_ix/smart_ix/application/smart_device/create_routine/routine_cubit.dart';

class InputTagField extends StatelessWidget {
  const InputTagField({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RoutineCubit, RoutineState>(
      buildWhen: (previous, current) =>
          previous.routineTitle != current.routineTitle,
      builder: (context, state) {
        return Container(
          width: double.infinity,
          height: 100,
          decoration: BoxDecoration(
            color: Colors.grey[200],
            borderRadius: BorderRadius.circular(
              20,
            ),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 30),
          margin: const EdgeInsets.symmetric(horizontal: 10),
          child: Center(
            child: TextField(
              autofocus: false,
              key: const Key('routine_tag_textField'),
              onChanged: (routineTitle) =>
                  context.read<RoutineCubit>().routineTitle(routineTitle),
              style: GoogleFonts.varelaRound(
                fontSize: 26,
                fontWeight: FontWeight.w200,
              ),
              decoration: InputDecoration(
                filled: false,
                hintStyle: GoogleFonts.varelaRound(
                  fontSize: 26,
                  fontWeight: FontWeight.w200,
                ),
                hintText: 'Routine Tag',
                errorText: state.routineTitle.invalid ? 'Add a tag' : null,
              ),
            ),
          ),
        );
      },
    );
  }
}
