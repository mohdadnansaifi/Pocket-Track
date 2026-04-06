import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../models/transaction_model.dart';
import '../../../providers/transactions_provider.dart';
import '../../../utils/constants/colors.dart';
import '../widgets/update_transaction_sheet.dart';

class TransactionHistoryList extends StatelessWidget {
  const TransactionHistoryList({
    super.key,
    required this.transactions,
  });

  final List<TransactionModel> transactions;

  @override
  Widget build(BuildContext context) {
    final provider =
    Provider.of<TransactionProvider>(context, listen: false);

    return ListView.builder(
      itemCount: transactions.length,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemBuilder: (context, index) {
        final tx = transactions[index];

        return Card(
          margin: const EdgeInsets.symmetric( vertical:6),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: UColors.primary,
            ),
            child: Card(
              child: ListTile(
                onTap: () {
                  // 👉 EDIT TRANSACTION
                  showModalBottomSheet(
                    context: context,
                    isScrollControlled: true,
                    builder: (_) => UpdateTransactionSheet(
                      existingTransaction: tx,
                    ),
                  );
                },

                leading: CircleAvatar(
                  backgroundColor:
                  tx.type == 'income' ? Colors.green : Colors.red,
                  child: Icon(
                    tx.type == 'income'
                        ? Icons.add
                        : Icons.remove,
                    color: Colors.white,
                  ),
                ),

                title: tx.type == 'income'?Text(

                  "₹${tx.amount}",
                  style: const TextStyle(fontWeight: FontWeight.bold,color: Colors.green),
                ):Text(
                  "₹${tx.amount}",
                  style: const TextStyle(fontWeight: FontWeight.bold,color: Colors.red),
                ),


                subtitle: Column(
                  // mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "${tx.category} •  ${tx.note}",
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    SizedBox(height: 4,),
                    Text(
                      "${tx.date.day}/${tx.date.month}/${tx.date.year}",
                      style: const TextStyle(fontSize: 10),
                    )
                  ],
                ),

                trailing: SizedBox(
                  width: 60,
                  child: IconButton(
                    constraints: const BoxConstraints(),
                    padding: EdgeInsets.zero,
                    icon: const Icon(Icons.delete, color: Colors.grey,),
                    onPressed: () {
                      _confirmDelete(context, provider, tx.id);
                    },
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  void _confirmDelete(
      BuildContext context,
      TransactionProvider provider,
      String id,
      ) {
    showDialog(
      context: context,
      builder: (_) {
        return AlertDialog(
          title: const Text("Delete Transaction"),
          content: const Text("Are you sure you want to delete?"),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text("Cancel"),
            ),
            TextButton(
              onPressed: () {
                provider.deleteTransaction(id);
                Navigator.pop(context);
              },
              child: const Text("Delete"),
            ),
          ],
        );
      },
    );
  }
}
