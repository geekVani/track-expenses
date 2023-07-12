import 'package:daily_expense_app/widgets/expenses_list/expenses_list.dart';
import 'package:daily_expense_app/widgets/new_expense.dart';
import 'package:flutter/material.dart';
import 'package:daily_expense_app/models/expense_model.dart';

import 'chart/chart.dart';

/// main UI to keep track of all expenses

// widget class
class Expenses extends StatefulWidget {
  const Expenses({super.key});

  @override
  State<StatefulWidget> createState() {
    return _ExpenseState();
  }
}

// state class
class _ExpenseState extends State<Expenses> {
  // dummy entries
  final List<Expense> _registeredExpense = [
    /// dummy 1
    Expense(
      title: 'Flutter Course',
      amount: 249.65,
      date: DateTime.now(),
      // today's date using inbuilt DateTime function provided by Flutter
      category: Category.work,
    ),

    /// dummy 2
    Expense(
      title: 'Spiderman Comes Home',
      amount: 450.98,
      date: DateTime.now(),
      // today's date using inbuilt DateTime function provided by Flutter
      category: Category.leisure,
    ),
    Expense(
      title: 'Macaroni Pasta',
      amount: 65.21,
      date: DateTime.now(),
      // today's date using inbuilt DateTime function provided by Flutter
      category: Category.food,
    ),
  ];

  // add item event
  void _openAddExpenseOverlay() {
    showModalBottomSheet(
      // to not overlap device features like camera, etc
      useSafeArea: true,
      // create fullscreen modal to not let keyboard obscure widgets
      isScrollControlled: true,
      context: context, // app context
      // modal bottom sheet context
      builder: (ctx) => NewExpense(
          onAddExpense:
              _addExpense), // passing class to open new bottomsheet on button add click
    );
  }

  // to add expense value in list
  void _addExpense(Expense expense) {
    setState(() {
      _registeredExpense.add(expense);
    });
  }

  // to remove item from list
  void _removeExpense(Expense expense) {
    // index of item
    final expenseIndex = _registeredExpense.indexOf(expense);

    setState(() {
      _registeredExpense.remove(expense);
    });
    // remove existing snackbar messages on the screen
    ScaffoldMessenger.of(context).clearSnackBars();
    // show message upon item deletion
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        duration: const Duration(seconds: 7),
        content: const Text('One expense removed'),
        action: SnackBarAction(
          label: 'Undo',
          // bring back item on same place as before
          onPressed: () {
            setState(() {
              _registeredExpense.insert(expenseIndex, expense);
            });
          },
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width; // for displaying chart and list in a row in landscape mode

    Widget mainContent = const Center(
      child: Text('No expenses found... Try adding one'),
    );

    if (_registeredExpense.isNotEmpty) {
      mainContent = ExpensesList(
        expenses: _registeredExpense,
        onRemoveExpense: _removeExpense,
      );
    }
    return Scaffold(
        appBar: AppBar(
          title: const Text('Expense Tracker App'),
          // set add icon
          actions: [
            IconButton(
              onPressed: _openAddExpenseOverlay, // using the fn.
              icon: const Icon(Icons.add),
            ),
          ],
        ),
        // for graph and list, take column
        body: width < 600
            ? Column(
                children: [
                  Chart(expenses: _registeredExpense),
                  Expanded(
                    child: mainContent,
                  ),
                ],
              )
            : Row(
                children: [
                  Expanded(
                    child: Chart(expenses: _registeredExpense),
                  ),
                  Expanded(child: mainContent),
                ],
              ),
    );
  }
}
