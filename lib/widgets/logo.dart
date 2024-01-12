import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Logo extends StatelessWidget {
  const Logo({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.only(right: 16.0),
            child: Image(image: AssetImage("assets/img/logo.png"), height: 48),
          ),
          Text(
            "ValueVoyage",
            style: GoogleFonts.inter(
                fontSize: 24, fontWeight: FontWeight.w200, color: Colors.white),
          )
        ],
      ),
    );
  }
}