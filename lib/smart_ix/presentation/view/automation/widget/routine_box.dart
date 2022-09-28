import 'package:flutter/material.dart';

class RoutineBox extends StatelessWidget {
  final Function() onTap;
  final String title;

  const RoutineBox({
    Key? key,
    required this.title,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(20),
        margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 15),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            width: 1.0,
            color: const Color.fromRGBO(158, 158, 158, 1),
          ),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Text(
                title,
                style: TextStyle(
                  fontWeight: FontWeight.w200,
                  fontSize: 16,
                  color: Colors.grey[500],
                ),
              ),
            ),
            const SizedBox(width: 10),
            const Icon(
              Icons.play_circle,
              color: Colors.blue,
              size: 30,
            ),
          ],
        ),
      ),
    );
  }
}
