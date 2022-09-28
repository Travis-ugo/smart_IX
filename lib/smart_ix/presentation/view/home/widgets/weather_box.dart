import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class WeatherBox extends StatelessWidget {
  final IconData iconData;
  final String title;
  final String subTitle;
  final String temperature;
  const WeatherBox(
      {Key? key,
      required this.iconData,
      required this.title,
      required this.subTitle,
      required this.temperature})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: Colors.grey[200],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Icon(
                iconData,
                color: Colors.orangeAccent,
                size: 25,
              ),
              const SizedBox(height: 10),
              RichText(
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
            ],
          ),
          Text(
            temperature,
            style: GoogleFonts.varelaRound(
              fontWeight: FontWeight.w500,
              color: Colors.grey[700],
              fontSize: 44,
            ),
          ),
        ],
      ),
    );
  }
}
