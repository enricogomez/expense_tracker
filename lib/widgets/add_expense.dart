import 'package:expense_tracker/models/expense.dart';
import 'package:flutter/material.dart';

class AddExpense extends StatefulWidget {
  const AddExpense({required this.onPressed, super.key});

  final void Function(Expense expense) onPressed;

  @override
  State<AddExpense> createState() => _AddExpenseState();
}

class _AddExpenseState extends State<AddExpense> {
  final titleController = TextEditingController();
  final amountController = TextEditingController();

  DateTime? selectedDate;
  Category selectedCategory = Category.food;

  void openDatePicker() async {
    final now = DateTime.now();
    final firstDate = DateTime(now.year - 1, now.month, now.day);
    final pickedDate = await showDatePicker(
      context: context,
      initialDate: now,
      firstDate: firstDate,
      lastDate: now,
    );

    setState(() {
      selectedDate = pickedDate;
    });
  }

  void submitExpenseData() {
    final enteredAmount = double.tryParse(amountController.text);
    final isAmountInvalid = enteredAmount == null || enteredAmount <= 0;
    final isTitleEmpty = titleController.text.trim().isEmpty;

    if (isAmountInvalid || isTitleEmpty || selectedDate == null) {
      showDialog(
        context: context,
        builder: (ctx) => AlertDialog(
          title: const Text('Invalid Input'),
          content: const Text('Please select a valid title, amount and date.'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(ctx);
              },
              child: const Text('Okay'),
            )
          ],
        ),
      );
      return;
    }

    final newExpense = Expense(
      title: titleController.text,
      amount: enteredAmount,
      date: selectedDate!,
      category: selectedCategory,
    );
    widget.onPressed(newExpense);
    Navigator.pop(context);
  }

  @override
  void dispose() {
    titleController.dispose();
    amountController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final keyboardSpace = MediaQuery.of(context).viewInsets.bottom;

    return SizedBox(
      height: double.infinity,
      child: SingleChildScrollView(
        child: Padding(
            padding: EdgeInsets.fromLTRB(16, 16, 16, keyboardSpace + 16),
            child: LayoutBuilder(
              builder: (ctx, constraints) {
                final isLandscape = constraints.maxWidth >= 600;
                return Column(
                  children: [
                    if (isLandscape)
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            child: TextField(
                              controller: titleController,
                              maxLength: 50,
                              decoration: const InputDecoration(
                                label: Text('Title'),
                              ),
                            ),
                          ),
                          Expanded(
                            child: TextField(
                              controller: amountController,
                              keyboardType: TextInputType.number,
                              decoration: const InputDecoration(
                                label: Text('Amount'),
                                prefix: Text('₱ '),
                              ),
                            ),
                          ),
                        ],
                      )
                    else
                      TextField(
                        controller: titleController,
                        maxLength: 50,
                        decoration: const InputDecoration(
                          label: Text('Title'),
                        ),
                      ),
                    if (isLandscape)
                      Row(
                        children: [
                          DropdownButton(
                            value: selectedCategory,
                            items: Category.values
                                .map(
                                  (category) => DropdownMenuItem(
                                    value: category,
                                    child: Text(category.name.toUpperCase()),
                                  ),
                                )
                                .toList(),
                            onChanged: (pickedCategory) {
                              if (pickedCategory == null) {
                                return;
                              }
                              setState(() {
                                selectedCategory = pickedCategory;
                              });
                            },
                          ),
                          const Spacer(),
                          Expanded(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Text(
                                  selectedDate == null
                                      ? 'Select Date'
                                      : formatter.format(selectedDate!),
                                ),
                                IconButton(
                                  icon: const Icon(Icons.calendar_month),
                                  onPressed: openDatePicker,
                                ),
                              ],
                            ),
                          )
                        ],
                      )
                    else
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Expanded(
                            child: TextField(
                              controller: amountController,
                              keyboardType: TextInputType.number,
                              decoration: const InputDecoration(
                                label: Text('Amount'),
                                prefix: Text('₱ '),
                              ),
                            ),
                          ),
                          Expanded(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Text(
                                  selectedDate == null
                                      ? 'Select Date'
                                      : formatter.format(selectedDate!),
                                ),
                                IconButton(
                                  icon: const Icon(Icons.calendar_month),
                                  onPressed: openDatePicker,
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                    const SizedBox(
                      height: 10.0,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        if (isLandscape)
                          Container()
                        else
                          DropdownButton(
                            value: selectedCategory,
                            items: Category.values
                                .map(
                                  (category) => DropdownMenuItem(
                                    value: category,
                                    child: Text(category.name.toUpperCase()),
                                  ),
                                )
                                .toList(),
                            onChanged: (pickedCategory) {
                              if (pickedCategory == null) {
                                return;
                              }
                              setState(() {
                                selectedCategory = pickedCategory;
                              });
                            },
                          ),
                        const Spacer(),
                        TextButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child: const Text('Cancel'),
                        ),
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.purple,
                            foregroundColor: Colors.white,
                          ),
                          onPressed: submitExpenseData,
                          child: const Text('Save Expense'),
                        ),
                      ],
                    )
                  ],
                );
              },
            )),
      ),
    );
  }
}
