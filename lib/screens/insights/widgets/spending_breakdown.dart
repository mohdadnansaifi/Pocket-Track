import 'package:flutter/material.dart';
import '../../../utils/constants/colors.dart';

class SpendingBreakdown extends StatelessWidget {
  final Map<String, double> data;

  const SpendingBreakdown({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    final total = data.values.fold(0.0, (sum, item) => sum + item);

    if (data.isEmpty) {
      return const Center(child: Text("No data yet"));
    }

    return Card(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 5),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 10,),
            Text(
              "Spending Breakdown",
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 14,),
            Column(

              children:
              data.entries.map((entry) {
                final percentage = entry.value / total;

                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 6),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(entry.key,
                          style: const TextStyle(fontWeight: FontWeight.bold)),

                      const SizedBox(height: 4),

                      ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: LinearProgressIndicator(
                          value: percentage,
                          minHeight: 8,
                          color: UColors.blue,
                          backgroundColor: UColors.grey,
                        ),
                      ),

                      const SizedBox(height: 4),

                      Text("₹${entry.value.toStringAsFixed(0)}"),
                    ],
                  ),
                );
              }).toList(),
            ),
          ],
        ),
      ),
    );
  }
}