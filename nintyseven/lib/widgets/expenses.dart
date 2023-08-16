import 'package:flutter/material.dart';
import 'package:nintyseven/widgets/chart/chart.dart';
import 'package:nintyseven/widgets/expenses_list/expenses_list.dart';
import 'package:nintyseven/model/expense.dart';
import 'package:nintyseven/widgets/new_expense.dart';

class Expenses extends StatefulWidget {
  const Expenses({super.key});

  @override
  State<Expenses> createState() => _ExpensesState();
}

class _ExpensesState extends State<Expenses> {
  final List<Expense> _registeredExpenses = [];

  void _openAddExpenseOverlay() {
    showModalBottomSheet(
      isScrollControlled: true,
      context: context,
      builder: (ctx) => NewExpense(onAddExpense: _addExpense),
    );
  }

  void _addExpense(Expense expense) {
    setState(() {
      _registeredExpenses.add(expense);
    });
  }

  void _removeExpense(Expense expense) {
    final expenseIndex = _registeredExpenses.indexOf(expense);
    setState(() {
      _registeredExpenses.remove(expense);
    });
    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        duration: const Duration(seconds: 3),
        action: SnackBarAction(
            label: 'گەڕانەوە',
            onPressed: () {
              setState(() {
                _registeredExpenses.insert(expenseIndex, expense);
              });
            }),
        content: const Text('سڕایەوە')));
  }

  @override
  Widget build(BuildContext context) {
    Widget mainContent = const Center(
      child: Text('بۆ زیادکردن هێمای + داگرە'),
    );

    if (_registeredExpenses.isNotEmpty) {
      mainContent = ExpnesesList(
        expneses: _registeredExpenses,
        onRemoveExpense: _removeExpense,
      );
    }
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'چۆن پارەکانت سەرف کردووە',
          style: Theme.of(context).textTheme.titleLarge,
        ),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: _openAddExpenseOverlay,
          )
        ],
      ),
      body: Column(children: [
        Chart(expenses: _registeredExpenses),
        Expanded(child: mainContent),
      ]),
    );
  }
}
