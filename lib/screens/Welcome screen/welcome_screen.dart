import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import '../../common_widgets/button.dart';
import 'add_details_screen.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [

            const Text(
              "Welcome to PocketTrack 💰",
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),

            Lottie.asset("assets/animations/money.json"),

            const SizedBox(height: 20),

            const Text(
              "Track your expenses and manage your money smartly",
              textAlign: TextAlign.center,
            ),

            const SizedBox(height: 40),

            UElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => const AddDetailsScreen(),
                  ),
                );
              },
              child: const Text("Get Started"),
            ),
          ],
        ),
      ),
    );
  }
}