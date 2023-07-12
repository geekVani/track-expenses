import 'package:daily_expense_app/models/expense_model.dart';
import 'package:flutter/material.dart';

// import date formatter package
import 'package:intl/intl.dart';

/// new file to add new expense by user

final formatter = DateFormat.yMd();

class NewExpense extends StatefulWidget {
  const NewExpense({super.key, required this.onAddExpense});

  final void Function(Expense expense)
      onAddExpense; // declaration for onAddExpense

  @override
  State<StatefulWidget> createState() {
    return _NewExpenseState();
  }
}

class _NewExpenseState extends State<NewExpense> {
  final _titleController =
      TextEditingController(); // object optimized to handle user input
  final _amountController = TextEditingController();
  DateTime?
      _selectedDate; // manually adding var as it doesn't support controller
  Category _selectedCategory = Category.leisure;

  // function for opening date picker box
  void _presentDatePicker() async {
    final now = DateTime.now();
    final firstDate = DateTime(now.year - 1, now.month, now.day);
    // use async and await for Future values
    final pickedDate = await showDatePicker(
      context: context,
      initialDate: now,
      firstDate: firstDate,
      lastDate: now,
    );
    setState(() {
      _selectedDate = pickedDate;
    });
  }

  // function to save data with validation
  void _submitExpenseData() {
    final enteredAmount = double.tryParse(_amountController
        .text); // try parse converts text to number, if possible
    final amountIsInvalid = enteredAmount == null || enteredAmount <= 0;
    if (_titleController.text.trim().isEmpty ||
        amountIsInvalid ||
        _selectedDate == null) {
      // show error message
      showDialog(
        context: context,
        builder: (ctx) => AlertDialog(
          title: const Text('Invalid Input !!'),
          content: const Text(
              'Make sure to enter valid values in title, amount, date and category fields'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(ctx);
              },
              child: const Text('OKAY'),
            ),
          ],
        ),
      );
      return;
    }

    // execute function to pass values
    widget.onAddExpense(
      // creating expense and passing that value to onAddExpense and so to addExpense
      Expense(
        title: _titleController.text,
        amount: enteredAmount,
        date: _selectedDate!,
        category: _selectedCategory,
      ),
    );
    // closing bottom overlay as soon as save btn is clicked
    Navigator.pop(context);
  }

  @override
  void dispose() {
    // dispose controllers mandatory-----
    // as it is not needed anymore, save app from extra consumption & crashing
    _titleController.dispose();
    _amountController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final keyboardSpace = MediaQuery.of(context).viewInsets.bottom;
    return LayoutBuilder(builder: (ctx, constraints) {
      final width = constraints.maxWidth;

      return SizedBox(
        height: double.infinity, // take up entire screen height
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.fromLTRB(16, 16, 16, keyboardSpace + 16),
            child: Column(
              children: [
                // render rows of cols conditionally
                if (width >= 600)
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: TextField(
                          controller: _titleController, // save title
                          maxLength: 50,
                          decoration: const InputDecoration(
                            label: Text('Enter Title'),
                          ),
                        ),
                      ),
                      const SizedBox(width: 20),
                      Expanded(
                        child: TextField(
                          controller: _amountController,
                          keyboardType: TextInputType.number,
                          decoration: const InputDecoration(
                            prefix: Text('\$ '),
                            label: Text('Enter Amount'),
                          ),
                        ),
                      ),
                    ],
                  )
                // title field
                else
                  TextField(
                    controller: _titleController, // save title
                    maxLength: 50,
                    decoration: const InputDecoration(
                      label: Text('Enter Title'),
                    ),
                  ),

                // arrange amount and date field in same row
                if (width >= 600)
                  Row(
                    children: [
                      DropdownButton(
                        value: _selectedCategory,
                        // showing currently selected value
                        items: Category.values
                            .map(
                              (category) => DropdownMenuItem(
                                value: category,
                                child: Text(
                                  category.name.toUpperCase(),
                                ),
                              ),
                            )
                            .toList(),
                        onChanged: (value) {
                          if (value == null) {
                            return; // return nothing
                          } else {
                            setState(() {
                              _selectedCategory = value;
                            });
                          }
                        },
                      ),
                      const SizedBox(width: 20),
                      Expanded(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          // push towards row end
                          crossAxisAlignment: CrossAxisAlignment.center,
                          // center vertically
                          children: [
                            Text(
                              _selectedDate == null
                                  ? 'No date selected'
                                  : formatter.format(_selectedDate!),
                            ),
                            IconButton(
                              onPressed: _presentDatePicker,
                              icon: const Icon(
                                Icons.calendar_month,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  )
                else
                  Row(
                    children: [
                      // amount field
                      Expanded(
                        child: TextField(
                          controller: _amountController,
                          keyboardType: TextInputType.number,
                          decoration: const InputDecoration(
                            prefix: Text('\$ '),
                            label: Text('Enter Amount'),
                          ),
                        ),
                      ),
                      const SizedBox(width: 20.0),
                      // wrap with Expanded widget since it's inside of a Row
                      Expanded(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          // push towards row end
                          crossAxisAlignment: CrossAxisAlignment.center,
                          // center vertically
                          children: [
                            Text(
                              _selectedDate == null
                                  ? 'No date selected'
                                  : formatter.format(_selectedDate!),
                            ),
                            IconButton(
                              onPressed: _presentDatePicker,
                              icon: const Icon(
                                Icons.calendar_month,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),

                const SizedBox(
                  height: 30,
                  width: 25,
                ),

                if (width >= 600)
                  Row(
                    children: [
                      const Spacer(),
                      TextButton(
                        onPressed: () {
                          Navigator.pop(
                              context); // pop removes overlay from screen
                        },
                        child: const Text('Cancel'),
                      ),
                      ElevatedButton(
                        onPressed: _submitExpenseData,
                        child: const Text('Save Expense'),
                      ),
                    ],
                  )
                else
                  // adding buttons
                  Row(
                    children: [
                      // category dropdown
                      DropdownButton(
                        value: _selectedCategory,
                        // showing currently selected value
                        items: Category.values
                            .map(
                              (category) => DropdownMenuItem(
                                value: category,
                                child: Text(
                                  category.name.toUpperCase(),
                                ),
                              ),
                            )
                            .toList(),
                        onChanged: (value) {
                          if (value == null) {
                            return; // return nothing
                          } else {
                            setState(() {
                              _selectedCategory = value;
                            });
                          }
                        },
                      ),
                      const Spacer(),
                      TextButton(
                        onPressed: () {
                          Navigator.pop(
                              context); // pop removes overlay from screen
                        },
                        child: const Text('Cancel'),
                      ),
                      ElevatedButton(
                        onPressed: _submitExpenseData,
                        child: const Text('Save Expense'),
                      ),
                    ],
                  ),
              ],
            ),
          ),
        ),
      );
    });
  }
}
