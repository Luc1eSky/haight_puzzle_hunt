import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class TitleName extends StatelessWidget {
  const TitleName({required this.text, super.key});
  final String text;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: GoogleFonts.chicle(
        fontSize: 42,
        color: const Color(0xFFDA291C), // Red accent
        letterSpacing: 1.5,
        shadows: [
          const Shadow(
            offset: Offset(2, 2),
            color: Color(0xFF005AA7), // Deep blue shadow
            blurRadius: 2,
          ),
        ],
      ),
      textAlign: TextAlign.center,
    );
  }
}
