import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:haight_puzzle_hunt/sign-up/presentation/pick_date_and_time.dart';

class SignUpScreen extends StatelessWidget {
  const SignUpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: const Scaffold(
        backgroundColor: Color.fromARGB(255, 255, 255, 255), // Cream background
        body: SingleChildScrollView(
          padding: EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const Title(text: "Haight Spirit Trail"),
              const SizedBox(height: 8),
              const ExplanationWidget(),
              const SizedBox(height: 24),
              const PickDateAndTime(),
            ],
          ),
        ),
      ),
    );
  }
}

class ExplanationWidget extends StatelessWidget {
  const ExplanationWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          "A real-world puzzle hunt through Haight Ashbury.",
          textAlign: TextAlign.center,
          style: GoogleFonts.chicle(
            fontSize: 22,
            color: const Color.fromARGB(255, 0, 0, 0),
          ),
        ),
        const SizedBox(height: 16),
        Text(
          'A small, mostly-forgotten group known as the Haight-Ashbury Ambassadors '
          'have quietly worked to keep the spirit of the Haight alive. '
          'Not by preaching, but by living it, sharing it, and inviting'
          ' others in. '
          'To join their ranks, you must walk the streets. Listen. Observe. Solve. '
          'You are invited to complete the Ambassador Trail: a series of tasks and puzzles '
          'designed to help you rediscover the values that built this place.',
          style: GoogleFonts.abel(
            fontSize: 16,
            color: const Color.fromARGB(255, 0, 0, 0),
          ),
          textAlign: TextAlign.justify,
        ),
        const SizedBox(height: 16),
        Text(
          '📍 Haight Street, San Francisco\n'
          '📆 Thursday through Sunday, 12:00 PM – 6:00 PM\n'
          '⏱️ Around 2 hours\n'
          '👥 2 to 4 curious souls\n'
          '💵 Small purchases (\$5–\$10) at local businesses\n',
          style: GoogleFonts.abel(fontSize: 16, color: Colors.black),
        ),
        const SizedBox(height: 16),
        Text(
          'Leave your number and pick your time. Ambassador Cass will be in touch.',
          style: GoogleFonts.abel(fontSize: 16, color: Color(0xFFDA291C)),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}

class Title extends StatelessWidget {
  const Title({required this.text, super.key});
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
