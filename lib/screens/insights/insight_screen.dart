import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:pocket_track/common_widgets/button.dart';
import 'package:pocket_track/screens/insights/widgets/spending_breakdown.dart';
import 'package:pocket_track/screens/insights/widgets/weekly_compariosn_card.dart';
import 'package:pocket_track/utils/constants/colors.dart';
import 'package:provider/provider.dart';
import '../../../../providers/transactions_provider.dart';
import '../../common_widgets/custom_text_fields.dart';
import '../../utils/constants/size.dart';
import '../Home Screen/widgets/goal_cards.dart';

class InsightsScreen extends StatelessWidget {
  const InsightsScreen({super.key});

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        leading: Icon(Icons.insights_outlined,color: UColors.white,),
        title: const Text("Insights",style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold,color: Colors.white),),
        actions:[Padding(
          padding: const EdgeInsets.all(8.0),
          child: Lottie.asset('assets/animations/Graph Lottie Animation.json',),
        )],
        centerTitle: true,
        backgroundColor: UColors.primary,
      ),

      body: Consumer<TransactionProvider>(
        builder: (context, provider, child) {
          return SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(USizes.defaultSpace/2),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: USizes.spaceBtwItems / 2),
                  Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: UColors.primary,
                      ),
                      child: SpendingBreakdown(data: provider.categoryTotals)),
                  const SizedBox(height: USizes.spaceBtwItems / 2),
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: UColors.primary,
                    ),
                    child: WeeklyComparisonCard(
                      thisWeek: provider.thisWeekExpense,
                      lastWeek: provider.lastWeekExpense,
                    ),
                  ),
                  const SizedBox(height: USizes.spaceBtwItems / 2),

                  ///Goal Card , monthly goal, savings, progress
                  GestureDetector(
                    onTap: () {
                      _showGoalDialog(context);
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: UColors.primary,
                      ),
                      child: GoalCard(
                        goal: provider.monthlyGoal,
                        savings: provider.totalSavings,
                        progress: provider.goalProgress,
                      ),
                    ),
                  ),
                  const SizedBox(height: USizes.spaceBtwItems / 2),
                  _card("Weekly Trend", provider.weeklyComparison),
                  const SizedBox(height: USizes.spaceBtwItems / 2),
                  _card("Top Category", provider.topCategory),
                  const SizedBox(height: USizes.spaceBtwItems / 2),
                  _card(
                    "Weekly Spending",
                    "₹${provider.weeklyExpense.toStringAsFixed(0)}",
                  ),
                  const SizedBox(height: USizes.spaceBtwItems / 2),
                  _card("Insight", provider.insightMessage),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _card(String title, String value) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: UColors.primary,
      ),
      child: Card(
        // margin: const EdgeInsets.only(bottom: 12),
        child: ListTile(title: Text(title), subtitle: Text(value)),
      ),
    );
  }
}

void _showGoalDialog(BuildContext context) {
  final controller = TextEditingController();

  showDialog(
    context: context,
    builder: (_) {
      return AlertDialog(
        title: const Text("Set Monthly Goal"),
        content: CustomTextField(
          controller: controller,
          keyboardType: TextInputType.number,
         label: 'Enter Amount',
        ),
        actions: [
          UElevatedButton(
            onPressed: () {
              final value = double.tryParse(controller.text);
              if (value != null) {
                Provider.of<TransactionProvider>(
                  context,
                  listen: false,
                ).setGoal(value);
              }
              Navigator.pop(context);
            },
            child: const Text("Save"),
          ),
        ],
      );
    },
  );
}
