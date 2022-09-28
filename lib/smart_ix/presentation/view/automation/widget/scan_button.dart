import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AddDeviceScanCard extends StatelessWidget {
  final String subTitle;
  final String title;
  final Function() onTap;
  const AddDeviceScanCard({
    Key? key,
    required this.subTitle,
    required this.title,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0.0,
      margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
      color: Colors.blue[50],
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            Row(
              children: [
                Expanded(
                  child: RichText(
                    text: TextSpan(
                      text: title,
                      style: GoogleFonts.varelaRound(
                        fontWeight: FontWeight.w700,
                        color: Colors.grey[900],
                        fontSize: 16,
                      ),
                      children: <TextSpan>[
                        TextSpan(
                          text: subTitle,
                          style: GoogleFonts.varelaRound(
                            fontWeight: FontWeight.w500,
                            color: Colors.grey[700],
                            fontSize: 14,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(width: 15),
                Container(
                  height: 60,
                  width: 150,
                  color: Colors.blueGrey[100],
                ),
              ],
            ),
            const SizedBox(height: 15),
            ElevatedButton(
              onPressed: onTap,
              key: const Key('addDevice_raisedButton'),
              style: ElevatedButton.styleFrom(
                elevation: 0.0,
                minimumSize: const Size(double.infinity, 45),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20.0),
                ),
                primary: Colors.yellow[50],
              ),
              child: Text(
                'scan',
                style: GoogleFonts.varelaRound(
                  color: Colors.black,
                  fontSize: 12,
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
