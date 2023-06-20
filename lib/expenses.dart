import 'package:expense_tracker/widgets/add_expense.dart';
import 'package:expense_tracker/widgets/chart.dart';
import 'package:expense_tracker/widgets/expenses_list.dart';
import 'package:expense_tracker/models/expense.dart';
import 'package:flutter/material.dart';

class Expenses extends StatefulWidget {
  const Expenses({super.key});

  @override
  State<Expenses> createState() => _ExpensesState();
}

class _ExpensesState extends State<Expenses> {
  final List<Expense> _registeredExpenses = [
    Expense(
      title: 'Flutter course',
      amount: 500,
      date: DateTime.now(),
      category: Category.work,
    ),
    Expense(
      title: 'Cinema',
      amount: 250.0,
      date: DateTime.now(),
      category: Category.leisure,
    ),
    Expense(
      title: 'Mcdo',
      amount: 100.0,
      date: DateTime.now(),
      category: Category.food,
    ),
    Expense(
      title: 'Boracay Trip',
      amount: 800,
      date: DateTime.now(),
      category: Category.travel,
    ),
    Expense(
      title: 'Jollibee',
      amount: 100.0,
      date: DateTime.now(),
      category: Category.food,
    ),
  ];

  void showAddExpenseOverlay() {
    showModalBottomSheet(
      useSafeArea: true,
      isScrollControlled: true,
      context: context,
      builder: (ctx) => AddExpense(
        onPressed: addExpenseData,
      ),
    );
  }

  void addExpenseData(Expense expense) {
    setState(() {
      _registeredExpenses.add(expense);
    });
  }

  void deleteExpenseData(Expense expense) {
    final expenseIndex = _registeredExpenses.indexOf(expense);
    setState(() {
      _registeredExpenses.remove(expense);
    });

    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: const Text('Item Deleted.'),
        action: SnackBarAction(
            label: 'Undo',
            onPressed: () {
              setState(() {
                _registeredExpenses.insert(expenseIndex, expense);
              });
            }),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Expense Tracker'),
        actions: [
          IconButton(
            onPressed: showAddExpenseOverlay,
            icon: const Icon(Icons.add),
          )
        ],
      ),
      body: _registeredExpenses.isEmpty
          ? const Center(
              child: Text('No expenses found. Start adding some!'),
            )
          : width > 600
              ? Row(
                  children: [
                    Expanded(
                      child: Chart(expenses: _registeredExpenses),
                    ),
                    Expanded(
                      child: ExpensesList(
                        expenses: _registeredExpenses,
                        onDismissed: deleteExpenseData,
                      ),
                    ),
                  ],
                )
              : Column(
                  children: [
                    Chart(expenses: _registeredExpenses),
                    Expanded(
                      child: ExpensesList(
                        expenses: _registeredExpenses,
                        onDismissed: deleteExpenseData,
                      ),
                    ),
                  ],
                ),
    );
  }
}
