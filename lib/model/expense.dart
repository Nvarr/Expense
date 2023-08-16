import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'package:uuid/uuid.dart';

const uuid = Uuid();

final formatter = DateFormat.yMd();

enum Category { work, food, supplies, games }

const categoryIcon = {
  Category.food: Icons.lunch_dining,
  Category.games: Icons.gamepad_outlined,
  Category.supplies: Icons.backpack,
  Category.work: Icons.work
};

class Expense {
  Expense(
      {required this.amount,
      required this.title,
      required this.date,
      required this.category})
      : id = uuid.v4();

  final String id;
  final String title;
  final double amount;
  final DateTime date;
  final Category category;

  String get formattedDate {
    return formatter.format(date);
  }
}

class ExpenseBucket {
  const ExpenseBucket({required this.category, required this.expenses});

  ExpenseBucket.forCategory(List<Expense> allExpenses, this.category)
      : expenses = allExpenses
            .where((expense) => expense.category == expense)
            .toList();

  final Category category;
  final List<Expense> expenses;

  double get totalExpenses {
    double sum = 0;

    for (final expense in expenses) {
      sum += expense.amount;
    }

    return sum;
  }
}