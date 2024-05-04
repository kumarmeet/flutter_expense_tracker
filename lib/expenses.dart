import 'package:exprense_tracker/expenses_list.dart';
import 'package:exprense_tracker/models/expenses.dart';
import 'package:exprense_tracker/next_expense.dart';
import 'package:exprense_tracker/widgets/charts/chart.dart';
import 'package:flutter/material.dart';

class Expenses extends StatefulWidget {
  const Expenses({super.key});

  @override
  State<Expenses> createState() {
    return _ExpensesState();
  }
}

class _ExpensesState extends State<Expenses> {
  final List<Expense> _registeredExpenses = [
    Expense(
        title: "Title one",
        amount: 44.4,
        date: DateTime.now(),
        category: Category.food),
    Expense(
        title: "Title two",
        amount: 44.2,
        date: DateTime.now(),
        category: Category.travel),
  ];

  void _addExpense(Expense expense) {
    setState(() {
      _registeredExpenses.add(expense);
    });
  }

  void _openAddExpenseOverlay() {
    showModalBottomSheet(
        isScrollControlled: true,
        // constraints: const BoxConstraints.expand(height: 800),
        context: context,
        builder: (ctx) {
          // return SizedBox(
          //     height: 450,
          //     child: NewExpense(
          //       addExpense: _addExpense,
          //     ));
          //
          return FractionallySizedBox(
              heightFactor: 0.9,
              child: NewExpense(
                addExpense: _addExpense,
              ));
        });
  }

  void _removeExpense(Expense expense) {
    final expenseIndex = _registeredExpenses.indexOf(expense);

    setState(() {
      _registeredExpenses.remove(expense);
    });

    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        duration: const Duration(seconds: 5),
        action: SnackBarAction(
            label: "Undo",
            onPressed: () {
              setState(() {
                _registeredExpenses.insert(expenseIndex, expense);
              });
            }),
        content: const Text("Deleted!")));
  }

  @override
  Widget build(BuildContext context) {
    // print(MediaQuery.of(context).size.width);
    // print(MediaQuery.of(context).size.height);

    // final screenHeight = MediaQuery.of(context).size.height;
    final screenWidht = MediaQuery.of(context).size.width;

    Widget mainContent = const Center(
        child: Text("You dont have any expenses list yet. Please add one!"));

    if (_registeredExpenses.isNotEmpty) {
      mainContent = ExpensesList(
          expenses: _registeredExpenses, removeExpense: _removeExpense);
    }

    return Scaffold(
      appBar: AppBar(title: const Text("Expense Tracker"), actions: [
        IconButton(
            onPressed: _openAddExpenseOverlay, icon: const Icon(Icons.add))
      ]),
      body: screenWidht < 600
          ? Column(
              children: [
                Chart(expenses: _registeredExpenses),
                Expanded(child: mainContent)
              ],
            )
          : Row(
              children: [
                Expanded(child: Chart(expenses: _registeredExpenses)),
                Expanded(child: mainContent)
              ],
            ),
    );
  }
}
