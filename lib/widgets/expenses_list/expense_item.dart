import 'package:daily_expense_app/models/expense_model.dart';
import 'package:flutter/material.dart';

class ExpenseItem extends StatelessWidget {
  // variables declaration for each item
  const ExpenseItem(this.expense,
      {super.key}); // constructor with a positional(required) and a named param
  final Expense expense;

  @override
  Widget build(BuildContext context) {
    // getting a cardview
    return Card(
      child: Padding(
        padding: const EdgeInsets.symmetric(
            horizontal: 10,
            vertical: 16,
        ),
        child: Column(
          // ensures that all items are moved to start
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              expense.title,
              // setting general theme of main dart file here
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: 5),
            Row(
              children: [
                Text('\$ ${expense.amount.toStringAsFixed(2)}'), // only display upto 2 decimal places
                // spacer widget takes up necessary space between two widgets i.e. Row(here)
                const Spacer(),
                // adding a row for displaying category icon & date
                Row(
                  children: [
                    Icon(categoryIcons[expense.category]),
                    const SizedBox(width: 8),
                    Text(expense.formattedDate),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
