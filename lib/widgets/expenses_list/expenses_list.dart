import 'package:daily_expense_app/widgets/expenses_list/expense_item.dart';
import 'package:flutter/material.dart';
import '../../models/expense_model.dart';

/// used to create a widget in UI

class ExpensesList extends StatelessWidget {
  const ExpensesList(
      {super.key, required this.expenses, required this.onRemoveExpense});

  final List<Expense> expenses;
  final void Function(Expense expense) onRemoveExpense;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: expenses.length,
      // takes in context and index as parameter and returns a widget
      // Dismissible widget allows to delete item on swipe
      itemBuilder: (ctx, index) => Dismissible(
        // key is used to uniquely identify items to delete
        key: ValueKey(expenses[index]),
        // background color upon swiping
        background: Container(
          color: Theme.of(context).colorScheme.error,
          // margin: EdgeInsets.symmetric(
          //   horizontal: Theme.of(context).cardTheme.margin!.horizontal,
          // ),
        ),
        // after a item is swiped away, clear data as well
        onDismissed: (direction) {
          // removes data not only visually but even internally
          onRemoveExpense(expenses[index]);
        },
        child: ExpenseItem(expenses[index]),
      ), // entering dummy and user data
    );
  }
}
