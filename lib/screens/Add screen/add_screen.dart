import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:uuid/uuid.dart';
import '../../common_widgets/button.dart';
import '../../common_widgets/custom_drop_down_fields.dart';
import '../../common_widgets/custom_snackbar.dart';
import '../../common_widgets/custom_text_fields.dart';
import '../../models/transaction_model.dart';
import '../../providers/transactions_provider.dart';
import '../../utils/constants/colors.dart';

class AddTransactionScreen extends StatefulWidget {
  const AddTransactionScreen({super.key});

  @override
  State<AddTransactionScreen> createState() => _AddTransactionScreenState();
}

class _AddTransactionScreenState extends State<AddTransactionScreen> {
  final _amountController = TextEditingController();
  final _noteController = TextEditingController();

  String _type = 'expense';
  String _category = 'Food';
  DateTime _selectedDate = DateTime.now();

  // void _saveTransaction() async {
  //   final amount = double.tryParse(_amountController.text);
  //
  //   if (amount == null || amount <= 0) return;
  //
  //   final transaction = TransactionModel(
  //     id: const Uuid().v4(),
  //     amount: amount,
  //     type: _type,
  //     category: _category,
  //     date: _selectedDate,
  //     note: _noteController.text,
  //   );
  //
  //   await Provider.of<TransactionProvider>(
  //     context,
  //     listen: false,
  //   ).addTransaction(transaction);
  //   if (!mounted) return;
  //   // ✅ Clear fields
  //   _amountController.clear();
  //   _noteController.clear();
  //
  //   setState(() {
  //     _type = 'expense';
  //     _category = 'Food';
  //     _selectedDate = DateTime.now();
  //   });
  //
  //   // ✅ Show Snackbar
  //   CustomSnackbar.show(context, "Transaction added successfully");
  // }
  void _saveTransaction() async {
    final amountText = _amountController.text.trim();
    final note = _noteController.text.trim();

    // 🔥 VALIDATION
    if (amountText.isEmpty) {
      CustomSnackbar.show(context, "Please enter amount");
      return;
    }

    final amount = double.tryParse(amountText);

    if (amount == null || amount <= 0) {
      CustomSnackbar.show(context, "Enter a valid amount");
      return;
    }

    if (_category.isEmpty) {
      CustomSnackbar.show(context, "Please select category");
      return;
    }


    final transaction = TransactionModel(
      id: const Uuid().v4(),
      amount: amount,
      type: _type,
      category: _category,
      date: _selectedDate,
      note: note,
    );

    final provider =
    Provider.of<TransactionProvider>(context, listen: false);

    try {
      await provider.addTransaction(transaction);

      if (!mounted) return;

      // ✅ Clear fields
      _amountController.clear();
      _noteController.clear();

      setState(() {
        _type = 'expense';
        _category = 'Food';
        _selectedDate = DateTime.now();
      });

      // ✅ Success message
      CustomSnackbar.show(context, "Transaction added successfully");

    } catch (e) {
      if (!mounted) return;

      // ❌ Error message
      CustomSnackbar.show(context, "Failed to save transaction");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Add Expense",
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: UColors.white,
          ),
        ),
        centerTitle: true,
        backgroundColor: Color(0xFF1E4D7B),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: UColors.primary,
            ),
            child: Card(
              elevation: 10,
              borderOnForeground: true,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    CustomTextField(
                      controller: _amountController,
                      keyboardType: TextInputType.number,
                      // decoration: const InputDecoration(labelText: "Amount"),
                      label: 'Amount',
                    ),

                    const SizedBox(height: 12),

                    CustomDropdown(
                      value: _type,
                      // decoration: const InputDecoration(labelText: "Type"),
                      items: const [
                        DropdownMenuItem(
                          value: 'income',
                          child: Text('Income'),
                        ),
                        DropdownMenuItem(
                          value: 'expense',
                          child: Text('Expense'),
                        ),
                      ],
                      onChanged: (val) => setState(() => _type = val!),
                      label: 'Type',
                    ),

                    const SizedBox(height: 12),

                    CustomDropdown(
                      value: _category,
                      // decoration: const InputDecoration(
                      //   labelText: "Category",
                      // ),
                      items: const [
                        DropdownMenuItem(value: 'Food', child: Text('Food')),
                        DropdownMenuItem(
                          value: 'Shopping',
                          child: Text('Shopping'),
                        ),
                        DropdownMenuItem(
                          value: 'Travel',
                          child: Text('Travel'),
                        ),
                        DropdownMenuItem(value: 'Bills', child: Text('Bills')),
                        DropdownMenuItem(
                          value: 'Salary',
                          child: Text('Salary'),
                        ),
                      ],
                      onChanged: (val) => setState(() => _category = val!),
                      label: 'Category',
                    ),

                    const SizedBox(height: 12),

                    CustomTextField(controller: _noteController, label: 'Note (optional)'),

                    const SizedBox(height: 20),

                    UElevatedButton(
                      onPressed: _amountController.text.isEmpty ? null : _saveTransaction,
                      child: const Text("Save Transaction"),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
