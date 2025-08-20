import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:haight_puzzle_hunt/sign-up/presentation/pick_date_and_time.dart';
import 'package:haight_puzzle_hunt/sign-up/presentation/title.dart';

import '../../config/app_globals.dart';

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
              const TitleName(text: "Haight Spirit Trail"),
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
          "A real-world puzzle adventure in the Haight",
          textAlign: TextAlign.center,
          style: GoogleFonts.chicle(
            fontSize: 22,
            color: const Color.fromARGB(255, 0, 0, 0),
          ),
        ),
        const SizedBox(height: 16),
        Text(
          '''
A small, almost-forgotten group, the Haight-Ashbury Ambassadors, quietly keeps the spirit of the Haight alive. Not by preaching, but by living it and inviting others in. To join them, you must walk the streets, listen, observe, and solve the Haight Spirit Trail: a series of puzzles and tasks to rediscover the values that built this place and its people.
''',
          style: GoogleFonts.abel(
            fontSize: 16,
            color: const Color.fromARGB(255, 0, 0, 0),
          ),
          textAlign: TextAlign.justify,
        ),
        //const SizedBox(height: 16),
        Text(
          '📍 $location\n'
          //'📆 Thursday through Sunday, $startHour:00 PM – $lastTimeSlot:00
          // PM\n'
          '⏱️ Around $gameLengthHours hours\n'
          '👥 $minPlayers to $maxPlayers curious souls\n'
          '💵 Small purchases (\$5–\$10) at local businesses\n',
          style: GoogleFonts.abel(fontSize: 16, color: Colors.black),
        ),
        //const SizedBox(height: 16),
        Text(
          'Enter your number. Our ambassador Cass will be in touch shortly',
          style: GoogleFonts.abel(fontSize: 16, color: Colors.black),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}
