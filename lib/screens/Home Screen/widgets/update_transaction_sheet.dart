import 'package:flutter/material.dart';
import 'package:pocket_track/common_widgets/custom_text_fields.dart';
import 'package:provider/provider.dart';
import 'package:uuid/uuid.dart';
import '../../../common_widgets/button.dart';
import '../../../common_widgets/custom_drop_down_fields.dart';
import '../../../models/transaction_model.dart';
import '../../../providers/transactions_provider.dart';

class UpdateTransactionSheet extends StatefulWidget {
  final TransactionModel? existingTransaction;

  const UpdateTransactionSheet({
    this.existingTransaction,
    super.key,
  });

  @override
  State<UpdateTransactionSheet> createState() => _UpdateTransactionSheetState();
}

class _UpdateTransactionSheetState extends State<UpdateTransactionSheet> {
  final _amountController = TextEditingController();
  final _noteController = TextEditingController();

  String _type = 'expense';
  String _category = 'Food';
  DateTime _selectedDate = DateTime.now();

  @override
  void initState() {
    super.initState();

    if (widget.existingTransaction != null) {
      _amountController.text =
          widget.existingTransaction!.amount.toString();

      _noteController.text =
          widget.existingTransaction!.note;

      _type = widget.existingTransaction!.type;
      _category = widget.existingTransaction!.category;
      _selectedDate = widget.existingTransaction!.date;
    }
  }
  void _submit() async {
    final amount = double.tryParse(_amountController.text);
    if (amount == null || amount <= 0) return;

    final provider =
    Provider.of<TransactionProvider>(context, listen: false);

    final transaction = TransactionModel(
      id: widget.existingTransaction?.id ?? const Uuid().v4(),
      amount: amount,
      type: _type,
      category: _category,
      date: _selectedDate,
      note: _noteController.text,
    );

    if (widget.existingTransaction != null) {
      await provider.updateTransaction(transaction);
    } else {
      await provider.addTransaction(transaction);
    }

    if (!mounted) return;

    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        left: 16,
        right: 16,
        top: 16,
        bottom: MediaQuery.of(context).viewInsets.bottom,
      ),
      child: SingleChildScrollView(
        child: Column(
          children: [
            const Text("Update Transaction", style: TextStyle(fontSize: 18)),
            const SizedBox(height: 10),
            CustomTextField(
              controller: _amountController,
              keyboardType: TextInputType.number,
             label: 'Amount',
            ),
            const SizedBox(height: 10),


            CustomDropdown(
              value: _type,
              items: const [
                DropdownMenuItem(value: 'income', child: Text('Income')),
                DropdownMenuItem(value: 'expense', child: Text('Expense')),
              ],
              onChanged: (val) => setState(() => _type = val!),
              label: 'Type',
            ),
          const SizedBox(height: 10),

            CustomDropdown(
              value: _category,
              items: const [
                DropdownMenuItem(value: 'Food', child: Text('Food')),
                DropdownMenuItem(value: 'Travel', child: Text('Travel')),
                DropdownMenuItem(value: 'Bills', child: Text('Bills')),
                DropdownMenuItem(value: 'Shopping', child: Text('Shopping')),
                DropdownMenuItem(value: 'Salary', child: Text('Salary')),
              ],
              onChanged: (val) => setState(() => _category = val!), label: 'Category',
            ),
            const SizedBox(height: 10),

            CustomTextField(
              controller: _noteController,
             label: 'Note',
            ),

            const SizedBox(height: 10),

            UElevatedButton(
              onPressed: _submit,
              child: Text(
                widget.existingTransaction != null ? "Update" : "Add",
              ),
            ),
          ],
        ),
      ),
    );
  }
}