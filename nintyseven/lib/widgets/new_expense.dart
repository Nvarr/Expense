import 'package:flutter/material.dart';
import 'package:nintyseven/model/expense.dart';
import 'package:nintyseven/widgets/expenses_list/expenses_item.dart';

class NewExpense extends StatefulWidget {
  const NewExpense({super.key, required this.onAddExpense});

  final void Function(Expense expense) onAddExpense;
  @override
  State<NewExpense> createState() => _NewExpenseState();
}

class _NewExpenseState extends State<NewExpense> {
  final _titleController = TextEditingController();
  final _amountController = TextEditingController();
  DateTime? _selectedDate;
  Category _selectedCategory = Category.games;

  void _submitExpenseData() {
    final enteredAmount = double.tryParse(_amountController.text);
    final amountIsInvalid = enteredAmount == null || enteredAmount <= 0;

    if (_titleController.text.trim().isEmpty ||
        amountIsInvalid ||
        _selectedDate == null) {
      showDialog(
        context: context,
        builder: (ctx) => AlertDialog(
          title: const Text('هەڵەیەک ڕوویدا'),
          content: Text('دڵنیا بەرەوە کە بە جوانی بۆشاییەکانت پڕ کردۆتەوە'),
          actions: [
            TextButton(
                onPressed: () {
                  Navigator.pop(ctx);
                },
                child: const Text('Ok'))
          ],
        ),
      );
      return;
    } else {
      widget.onAddExpense(Expense(
          amount: enteredAmount,
          title: _titleController.text,
          date: _selectedDate!,
          category: _selectedCategory));
      Navigator.pop(context);
    }
  }

  void _precentDatePicker() async {
    final now = DateTime.now();
    final firstDate = DateTime(now.year - 1, now.month, now.day);

    final pickedDate = await showDatePicker(
        context: context,
        initialDate: now,
        firstDate: firstDate,
        lastDate: now);
    print(pickedDate);
    setState(() {
      _selectedDate = pickedDate;
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _amountController.dispose();
    _titleController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 48, 16, 16),
      child: Column(children: [
        TextField(
          controller: _titleController,
          maxLength: 50,
          decoration: InputDecoration(
            label: Text(
              'هۆکاری سەرف',
              style: TextStyle(fontFamily: 'KurdishFont'),
            ),
          ),
        ),
        Row(
          children: [
            Expanded(
              child: TextField(
                keyboardType: TextInputType.number,
                controller: _amountController,
                decoration: const InputDecoration(
                  prefixText: 'IQD ',
                  label: Text('بڕی پارە'),
                ),
              ),
            ),
            Expanded(
                child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text(_selectedDate != null
                    ? formatter.format(_selectedDate!)
                    : 'بەرواری سەرف کردن'),
                IconButton(
                    onPressed: _precentDatePicker,
                    icon: Icon(
                      Icons.calendar_month,
                      size: 60,
                    ))
              ],
            ))
          ],
        ),
        const SizedBox(
          height: 16,
        ),
        Row(
          children: [
            DropdownButton(
                value: _selectedCategory,
                items: Category.values
                    .map((category) => DropdownMenuItem(
                        value: category,
                        child: Text(category.name.toUpperCase())))
                    .toList(),
                onChanged: (value) {
                  setState(() {
                    if (value == null) {
                      return;
                    }
                    _selectedCategory = value;
                  });
                }),
            const Spacer(),
            ElevatedButton(
                onPressed: () {
                  _submitExpenseData();
                },
                child: Text('زیادکردنی سەرف')),
            TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text('پەشیمان بوونەوە'))
          ],
        )
      ]),
    );
  }
}
