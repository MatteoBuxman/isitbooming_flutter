import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class IsItBoomingHeading extends StatelessWidget {
  final Color? textColour;

  const IsItBoomingHeading({
    super.key,
    this.textColour
  });

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text('IsItBooming',
                style: GoogleFonts.anta(
                    textStyle: TextStyle(
                        color: textColour ?? const Color.fromRGBO(248, 240, 251, 1.0),
                        fontWeight: FontWeight.bold,
                        fontSize: 24)))
          ],
        ),
      ),
    );
  }
}
