import 'package:expense_tracker/models/expense.dart';
import 'package:flutter/material.dart';

class NewExpense extends StatefulWidget {
  const NewExpense({super.key});

  @override
  State<NewExpense> createState() {
    return _NewExpenseState();
  }
}

class _NewExpenseState extends State<NewExpense> {
  final _titleController = TextEditingController();
  final _amountController = TextEditingController();
  DateTime? selectedDate;

  void _presentDatePicker() async {
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

  @override
  void dispose() {
    _titleController.dispose();
    _amountController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              TextField(
                controller: _titleController,
                maxLength: 50,
                decoration: const InputDecoration(
                  label: Text('Title'),
                ),
              ),
              Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: _amountController,
                      keyboardType: TextInputType.number,
                      decoration: const InputDecoration(
                        prefixText: "\$",
                        label: Text('Amount'),
                      ),
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                      child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      selectedDate == null
                          ? const Text('No Date Chosen')
                          : Text(formatter.format(selectedDate!)),
                      IconButton(
                          onPressed: () {
                            _presentDatePicker();
                          },
                          icon: const Icon(Icons.calendar_today)),
                    ],
                  ))
                ],
              ),
              Row(
                children: [
                  DropdownButton(
                      items: Category.values.map((category) {
                        return DropdownMenuItem(
                          value: category,
                          child: Text(category.toString().split('.').last.toUpperCase()),
                        );
                      }).toList(),
                      onChanged: (value) {
                        print(value);
                      }),
                  TextButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: const Text('cancell')),
                  const SizedBox(width: 8),
                  ElevatedButton(
                    onPressed: () {
                      print(_titleController.text);
                      print(_amountController.text);
                    },
                    child: const Text('Add Expense'),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
