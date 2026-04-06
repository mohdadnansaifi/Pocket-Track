import 'package:flutter/material.dart';
import '../../../utils/constants/colors.dart';

class GoalCard extends StatelessWidget {
  final double goal;
  final double savings;
  final double progress;

  const GoalCard({
    super.key,
    required this.goal,
    required this.savings,
    required this.progress,
  });

  @override
  Widget build(BuildContext context) {

    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            const Align(
              alignment: Alignment.centerLeft,
              child: Text(
                "Monthly Goal 🎯",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ),

            const SizedBox(height: 10),

            LinearProgressIndicator(
              value: progress,
              color:UColors.blue,
              backgroundColor: Colors.grey,
              minHeight: 8,
              borderRadius: BorderRadius.circular(10),
            ),

            const SizedBox(height: 10),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("Saved: ₹${savings.toStringAsFixed(0)}"),
                Text("Goal: ₹${goal.toStringAsFixed(0)}"),
              ],
            ),

            const SizedBox(height: 8),

            Text(_getMessage(progress)),
          ],
        ),
      ),
    );
  }

  String _getMessage(double progress) {
    if (progress >= 1) return "🎉 Goal achieved!";
    if (progress > 0.7) return "🔥 Almost there!";
    if (progress > 0.3) return "👍 Good progress!";
    return "Start saving 💪";
  }
}