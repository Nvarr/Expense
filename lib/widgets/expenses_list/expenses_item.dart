import 'package:flutter/material.dart';
import 'package:nintyseven/model/expense.dart';

class ExpenseItem extends StatelessWidget {
  const ExpenseItem(this.expense, {super.key});
  final Expense expense;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Card(
        elevation: 10,
        child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 20,
              vertical: 16,
            ),
            child: Column(children: [
              Text(
                expense.title,
                style: Theme.of(context).textTheme.titleLarge,
              ),
              SizedBox(
                height: 10,
              ),
              Row(
                children: [
                  Text('\IQD ${expense.amount.toStringAsFixed(2)}'),
                  Spacer(),
                  Row(
                    children: [
                      Icon(categoryIcon[expense.category]),
                      Text('${expense.formattedDate}'),
                    ],
                  )
                ],
              )
            ])),
      ),
    );
  }
}
