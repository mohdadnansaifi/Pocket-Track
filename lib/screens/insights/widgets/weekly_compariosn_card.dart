import 'package:flutter/material.dart';


class WeeklyComparisonCard extends StatelessWidget {
  final double thisWeek;
  final double lastWeek;

  const WeeklyComparisonCard({
    super.key,
    required this.thisWeek,
    required this.lastWeek,
  });

  @override
  Widget build(BuildContext context) {
    final maxValue = thisWeek > lastWeek ? thisWeek : lastWeek;

    final thisRatio = maxValue == 0 ? 0 : thisWeek / maxValue;
    final lastRatio = maxValue == 0 ? 0 : lastWeek / maxValue;

    final percent = lastWeek == 0
        ? 0
        : ((thisWeek - lastWeek) / lastWeek) * 100;

    final increased = thisWeek > lastWeek;

    final color = increased ? Colors.red : Colors.green;

    return Card(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 5),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 10,),
            const Text(
              "Weekly Comparison",
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 16),

            // 🔵 THIS WEEK
            _buildBar(
              label: "This Week",
              value: thisWeek,
              ratio: thisRatio.toDouble(),
              color: Colors.blue,
            ),

            const SizedBox(height: 12),

            // ⚫ LAST WEEK
            _buildBar(
              label: "Last Week",
              value: lastWeek,
              ratio: lastRatio.toDouble(),
              color: Colors.grey,
            ),

            const SizedBox(height: 16),

            // 🔥 CHANGE INDICATOR
            Row(
              children: [
                Icon(
                  increased ? Icons.arrow_upward : Icons.arrow_downward,
                  color: color,
                ),
                const SizedBox(width: 6),
                Text(
                  "${percent.abs().toStringAsFixed(1)}%",
                  style: TextStyle(
                    color: color,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(width: 6),
                Text(
                  increased
                      ? "Spending increased"
                      : "Great! You spent less",
                  style: TextStyle(color: color),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildBar({
    required String label,
    required double value,
    required double ratio,
    required Color color,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [

        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(label),
            Text(
              "₹${value.toStringAsFixed(0)}",
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
          ],
        ),

        const SizedBox(height: 6),

        Stack(
          children: [
            Container(
              height: 8,
              width: double.infinity,
              decoration: BoxDecoration(
                color: Colors.grey.shade300,
                borderRadius: BorderRadius.circular(10),
              ),
            ),
            FractionallySizedBox(
              widthFactor: ratio,
              child: Container(
                height: 8,
                decoration: BoxDecoration(
                  color: color,
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}