import 'package:flutter/material.dart';
import 'package:pocket_track/utils/constants/colors.dart';
import 'package:pocket_track/utils/constants/size.dart';
import 'package:provider/provider.dart';
import '../../../providers/transactions_provider.dart';
import '../widgets/dashboard_card.dart';
import '../widgets/greeting_with_profile_pic.dart';
import '../widgets/transaction_history_list.dart';
class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState(){
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if(!mounted)return;
      Provider.of<TransactionProvider>(context, listen: false)
          .fetchTransactions();
    });

  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: GreetingWithProfilePic(),
        backgroundColor: UColors.primary,
      ),
      body: Consumer<TransactionProvider>(
        builder: (context, provider, child) {
          final transactions = provider.transactions;

          return SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(USizes.defaultSpace/2),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 10,),
                  ///DashBoard Card , total balance, income, expense
                  DashboardCard(
                    balance: provider.balance,
                    income: provider.totalIncome,
                    expense: provider.totalExpense,
                  ),
                  const SizedBox(height: 20,),
                  Text("Spending history",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 18),),
                  const SizedBox(height: 10,),
                  ///transation history
                  transactions.isEmpty
                      ? const Center(child: Text("No transactions yet 💸"))
                      : TransactionHistoryList(transactions: transactions),
                ],
              ),
            ),
          );
        },
      ),

    );
  }
}




