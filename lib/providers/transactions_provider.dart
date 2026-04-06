import 'package:sqflite/sqflite.dart';

import '../models/transaction_model.dart';

import 'package:flutter/material.dart';

import '../services/db_service.dart';

class TransactionProvider with ChangeNotifier {
  final List<TransactionModel> _transactions = [];

  List<TransactionModel> get transactions => _transactions;

  double get totalIncome {
    return _transactions
        .where((tx) => tx.type == 'income')
        .fold(0.0, (sum, tx) => sum + tx.amount);
  }

  double get totalExpense {
    return _transactions
        .where((tx) => tx.type == 'expense')
        .fold(0.0, (sum, tx) => sum + tx.amount);
  }

  double get balance {
    return totalIncome - totalExpense;
  }

  ///real time tracking

  // 🔹 Start of current week (Monday)
  DateTime get startOfThisWeek {
    final now = DateTime.now();
    return DateTime(now.year, now.month, now.day)
        .subtract(Duration(days: now.weekday - 1));
  }

// 🔹 Start of last week
  DateTime get startOfLastWeek {
    return startOfThisWeek.subtract(const Duration(days: 7));
  }

// 🔹 End of last week
  DateTime get endOfLastWeek {
    return startOfThisWeek.subtract(const Duration(seconds: 1));
  }

// 🔹 This week expense
  double get thisWeekExpense {
    final start = startOfThisWeek;

    return _transactions
        .where((tx) =>
    tx.type == 'expense' &&
        !tx.date.isBefore(start))
        .fold(0.0, (sum, tx) => sum + tx.amount);
  }

// 🔹 Last week expense
  double get lastWeekExpense {
    final start = startOfLastWeek;
    final end = endOfLastWeek;

    return _transactions
        .where((tx) =>
    tx.type == 'expense' &&
        !tx.date.isBefore(start) &&
        tx.date.isBefore(end))
        .fold(0.0, (sum, tx) => sum + tx.amount);
  }

  ///add transaction
  Future<void> addTransaction(TransactionModel transaction) async {
    final db = await DBService.database;

    await db.insert(
      'transactions',
      transaction.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );

    _transactions.add(transaction);
    notifyListeners();
  }

  ///update transaction
  Future<void> updateTransaction(TransactionModel transaction) async {
    final db = await DBService.database;

    await db.update(
      'transactions',
      transaction.toMap(),
      where: 'id = ?',
      whereArgs: [transaction.id],
    );

    final index = _transactions.indexWhere((t) => t.id == transaction.id);

    if (index != -1) {
      _transactions[index] = transaction;
      notifyListeners();
    }
  }

  ///deleteTransaction
  Future<void> deleteTransaction(String id) async {
    final db = await DBService.database;

    await db.delete(
      'transactions',
      where: 'id = ?',
      whereArgs: [id],
    );

    _transactions.removeWhere((tx) => tx.id == id);
    notifyListeners();
  }

 ///Fetch transaction
  Future<void> fetchTransactions() async {
    final db = await DBService.database;
    final data = await db.query('transactions');

    _transactions.clear();
    _transactions.addAll(
      data.map((e) => TransactionModel.fromMap(e)).toList(),
    );

    notifyListeners();
  }

  Future<void> clearAllTransactions() async {
    await DBService.clearDatabase();

    _transactions.clear(); // 🔥 clear UI list
    notifyListeners();
  }
  double _monthlyGoal = 10000; // default

  double get monthlyGoal => _monthlyGoal;

  void setGoal(double value) {
    _monthlyGoal = value;
    notifyListeners();
  }

  double get totalSavings {
    return totalIncome - totalExpense;
  }

  double get goalProgress {
    if (_monthlyGoal == 0) return 0;
    return (totalSavings / _monthlyGoal).clamp(0, 1);
  }

  ///top spending category step 6
  String get topCategory {
    if (_transactions.isEmpty) return "N/A";

    Map<String, double> categoryTotals = {};

    for (var tx in _transactions) {
      if (tx.type == 'expense') {
        categoryTotals[tx.category] =
            (categoryTotals[tx.category] ?? 0) + tx.amount;
      }
    }

    if (categoryTotals.isEmpty) return "N/A";

    return categoryTotals.entries
        .reduce((a, b) => a.value > b.value ? a : b)
        .key;
  }

  double get weeklyExpense {
    final now = DateTime.now();

    return _transactions
        .where((tx) =>
    tx.type == 'expense' &&
        tx.date.isAfter(now.subtract(const Duration(days: 7))))
        .fold(0.0, (sum, tx) => sum + tx.amount);
  }

  String get insightMessage {
    if (_transactions.isEmpty) return "Start tracking your expenses!";

    if (totalExpense > totalIncome) {
      return "⚠️ You're spending more than you earn";
    } else if (goalProgress > 0.7) {
      return "🔥 You're doing great with savings!";
    } else {
      return "👍 Keep tracking your expenses!";
    }
  }

  Map<String, double> get categoryTotals {
    Map<String, double> data = {};

    for (var tx in _transactions) {
      if (tx.type == 'expense') {
        data[tx.category] = (data[tx.category] ?? 0) + tx.amount;
      }
    }

    return data;
  }


  String get weeklyComparison {
    if (weeklyExpense > lastWeekExpense) {
      return "⚠️ Spending increased from last week";
    } else if (weeklyExpense < lastWeekExpense) {
      return "🎉 You spent less than last week!";
    } else {
      return "No change from last week";
    }
  }
  


}