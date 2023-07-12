import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';

// import date formatter package
import 'package:intl/intl.dart';

/// describe data structure used for expense list

const uuid = Uuid(); // calling uuid class

// using date format class provided by intl package
// yMd constructor is provided by intl pkg, DateFormat is a class
final formatter = DateFormat.yMd();

// enum keyword allows to create custom type
// define the categories you want in app
// treated as string by var category
enum Category { food, travel, leisure, work, accomodation }

// enum list for category icons
const categoryIcons = {
  Category.food: Icons.lunch_dining,
  Category.travel: Icons.flight_takeoff,
  Category.leisure: Icons.movie,
  Category.work: Icons.work,
  Category.accomodation: Icons.home,
};

class Expense {
  Expense({
    required this.title,
    required this.amount,
    required this.date,
    required this.category, // named parameters for the variables defined below
    // initializer value
  }) : id = uuid.v4(); // v4 is a method used to generate id

  // want to build unique id dynamically
  final String id; // uniquely identify each item
  final String title;
  final double amount; // 19.20...
  final DateTime date;
  final Category category;

  // method for displaying formatted date
  String get formattedDate {
    return formatter.format(date);
  }
}

// for building charts using buckets
class ExpenseBucket {
  const ExpenseBucket({
    required this.category,
    required this.expenses,
  });

  // additional constructor added manually
  ExpenseBucket.forCategory(List<Expense> allExpenses, this.category)
      : expenses = allExpenses
      .where((expense) => expense.category == category)
      .toList();

  final Category category;
  final List<Expense> expenses;

  // adding getter for chart
  double get totalExpenses {
    double sum = 0;

    for (final item in expenses) {
      sum += item.amount;
    }
    return sum;
  }
}
