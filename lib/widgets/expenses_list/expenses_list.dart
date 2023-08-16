import 'package:flutter/material.dart';
import 'package:nintyseven/model/expense.dart';
import 'package:nintyseven/widgets/expenses_list/expenses_item.dart';

class ExpnesesList extends StatelessWidget {
  const ExpnesesList(
      {super.key, required this.expneses, required this.onRemoveExpense});

  final List<Expense> expneses;
  final void Function(Expense expense) onRemoveExpense;
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: expneses.length,
      itemBuilder: (ctx, index) => Dismissible(
        background: Container(
          color: Theme.of(context).colorScheme.error.withOpacity(0.7),
          margin: EdgeInsets.symmetric(
              horizontal: Theme.of(context).cardTheme.margin!.horizontal),
        ),
        child: ExpenseItem(expneses[index]),
        onDismissed: (direction) {
          return onRemoveExpense(expneses[index]);
        },
        key: ValueKey(ExpenseItem(expneses[index])),
      ),
    );
  }
}
