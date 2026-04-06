import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import '../../common_widgets/button.dart';
import 'add_details_screen.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [

              const Spacer(),

              const Text(
                "Welcome to PocketTrack 💰",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),

              const SizedBox(height: 20),

              // 🔥 Lottie with error handling
              Lottie.asset(
                "assets/animations/money.json",
                height: 220,
                repeat: true,
                frameRate: FrameRate(100),
                errorBuilder: (context, error, stackTrace) {
                  return const Icon(Icons.error, size: 80);
                },
              ),

              const SizedBox(height: 20),

              const Text(
                "Track your expenses and manage your money smartly",
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 14, color: Colors.grey),
              ),

              const Spacer(),

              // 🔥 Button with safe navigation

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
              

              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}