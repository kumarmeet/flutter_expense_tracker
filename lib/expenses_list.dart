import 'package:expense_tracker/models/expenses.dart';
import 'package:expense_tracker/widgets/expenses_list/expense_item.dart';
import 'package:flutter/material.dart';

class ExpensesList extends StatelessWidget {
  const ExpensesList(
      {super.key, required this.expenses, required this.removeExpense});

  final List<Expense> expenses;
  final void Function(Expense expense) removeExpense;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: expenses.length,
        itemBuilder: (ctx, idx) => Dismissible(
            key: ValueKey(expenses[idx]),
            onDismissed: (direction) {
              removeExpense(expenses[idx]);
            },
            child: ExpenseItem(expense: expenses[idx])));
  }
}
