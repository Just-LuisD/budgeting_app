import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class IncomeSection extends StatefulWidget {
  const IncomeSection({super.key});

  @override
  State<IncomeSection> createState() => _IncomeSectionState();
}

class _IncomeSectionState extends State<IncomeSection> {
  bool _showCategories = false;
  var _expenseDate = DateTime.now();

  void _pickDate() async {
    DateTime? selectedDate = await showDatePicker(
      context: context,
      initialDate: _expenseDate,
      firstDate: DateTime(_expenseDate.year, _expenseDate.month, 1),
      lastDate: DateTime(_expenseDate.year, _expenseDate.month + 1, 1).subtract(
        Duration(days: 1),
      ),
    );

    if (selectedDate != null) {
      setState(() {
        _expenseDate = selectedDate;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        children: [
          IconButton(
            onPressed: () {
              setState(() {
                _showCategories = !_showCategories;
              });
            },
            icon: Icon(_showCategories
                ? Icons.arrow_drop_down
                : Icons.arrow_right_outlined),
          ),
          Expanded(
            child: Text("Income"),
          ),
          IconButton(
            onPressed: () {
              showModalBottomSheet(
                context: context,
                builder: (context) {
                  return Scaffold(
                    appBar: AppBar(
                      title: Text("Add Income"),
                    ),
                    body: SingleChildScrollView(
                      child: Form(
                        child: Column(
                          children: [
                            TextFormField(
                              controller: null,
                              decoration: const InputDecoration(
                                labelText: 'Title',
                              ),
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Your transaction must have a title.';
                                }
                                return null;
                              },
                            ),
                            TextFormField(
                              controller: null,
                              decoration: InputDecoration(
                                labelText: "Amount",
                              ),
                              keyboardType: TextInputType.number,
                              validator: (value) {
                                if (value == null ||
                                    value.isEmpty ||
                                    double.tryParse(value) == null ||
                                    double.tryParse(value)! <= 0) {
                                  return 'Your transaction amount must be a positive value.';
                                }
                                return null;
                              },
                            ),
                            Row(
                              children: [
                                Expanded(
                                  child: Text(
                                    'Date: ${DateFormat.yMMMd().format(_expenseDate)}',
                                  ),
                                ),
                                IconButton(
                                  alignment: Alignment.centerRight,
                                  onPressed: _pickDate,
                                  icon: Icon(Icons.calendar_month),
                                ),
                              ],
                            ),
                            ElevatedButton(
                              onPressed: () {},
                              child: Text("Add"),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              );
            },
            icon: const Icon(Icons.add),
          ),
        ],
      ),
    );
  }
}
