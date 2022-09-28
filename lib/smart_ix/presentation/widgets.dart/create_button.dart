import 'package:flutter/material.dart';

class CreateCard extends StatelessWidget {
  const CreateCard({
    Key? key,
    required this.subTitle,
    required this.title,
    required this.onTap,
  }) : super(key: key);
  final String subTitle;
  final String title;
  final Function() onTap;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0.0,
      margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
      color: Colors.grey[900],
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            SizedBox(
              height: 100,
              width: 230,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: const [
                  Icon(Icons.star, size: 30, color: Colors.orangeAccent),
                  Icon(Icons.access_time_filled_rounded,
                      size: 30, color: Colors.blueAccent),
                  Icon(Icons.favorite, size: 30, color: Colors.redAccent),
                  Icon(Icons.flatware_rounded,
                      size: 30, color: Colors.pinkAccent),
                  Icon(Icons.lightbulb, size: 30, color: Colors.yellowAccent),
                ],
              ),
            ),
            const SizedBox(height: 10),
            Text(
              subTitle,
              style: const TextStyle(
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 10),
            ElevatedButton(
              onPressed: onTap,
              key: const Key('addDevice_raisedButton'),
              style: ElevatedButton.styleFrom(
                elevation: 0.0,
                minimumSize: const Size(double.infinity, 45),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20.0),
                ),
                primary: Colors.grey[500],
              ),
              child: Text(
                title,
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w600,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
