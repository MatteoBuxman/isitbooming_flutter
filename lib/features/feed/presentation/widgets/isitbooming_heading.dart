import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class IsItBoomingHeading extends StatelessWidget {
  const IsItBoomingHeading({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text('IsItBooming',
                style: GoogleFonts.anta(
                    textStyle: const TextStyle(
                        color: Color.fromRGBO(248, 240, 251, 1.0),
                        fontWeight: FontWeight.bold,
                        fontSize: 24)))
          ],
        ),
      ),
    );
  }
}
