import 'package:budgeting_app/clean_architecture/domain/entities/budget.dart';
import 'package:budgeting_app/clean_architecture/domain/entities/category.dart';
import 'package:budgeting_app/clean_architecture/presentation/blocs/budget_bloc.dart';
import 'package:budgeting_app/clean_architecture/presentation/blocs/budget_event.dart';
import 'package:budgeting_app/clean_architecture/presentation/widgets/category_input.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CategoryInputStructure {
  CategoryInput inputField;
  TextEditingController nameController;
  TextEditingController limitController;

  CategoryInputStructure(
    this.inputField,
    this.nameController,
    this.limitController,
  );
}

class BudgetFormScreen extends StatefulWidget {
  final Budget? budget;

  const BudgetFormScreen({super.key, this.budget});

  @override
  _BudgetFormScreenState createState() => _BudgetFormScreenState();
}

class _BudgetFormScreenState extends State<BudgetFormScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _incomeController = TextEditingController();
  List<CategoryInputStructure> _categoryInputs = [];

  @override
  void initState() {
    super.initState();
    if (widget.budget != null) {
      _nameController.text = widget.budget!.name;
      _incomeController.text = widget.budget!.income.toString();
      if (widget.budget!.categories != null) {
        _categoryInputs = widget.budget!.categories!.map((e) {
          final nameController = TextEditingController();
          final limitController = TextEditingController();
          nameController.text = e.name;
          limitController.text = e.spendingLimit.toString();
          final inputKey = UniqueKey();
          final inputField = CategoryInput(
            key: inputKey,
            onDelete: () {
              _deleteCategory(inputKey);
            },
            nameController: nameController,
            limitController: limitController,
          );
          return CategoryInputStructure(
            inputField,
            nameController,
            limitController,
          );
        }).toList();
      }
    }
  }

  void _submitForm(BuildContext context) async {
    if (_formKey.currentState!.validate()) {
      final String name = _nameController.text;
      final double income = double.parse(_incomeController.text);
      final List<Category> categories = [];

      for (CategoryInputStructure categoryInput in _categoryInputs) {
        final categoryName = categoryInput.nameController.text;
        final categoryLimit =
            double.tryParse(categoryInput.limitController.text);
        categories
            .add(Category(name: categoryName, spendingLimit: categoryLimit!));
      }

      if (widget.budget == null) {
        final newBudget = Budget(
          name: name,
          income: income,
          categories: categories,
        );
        context.read<BudgetBloc>().add(AddBudget(newBudget));
      } else {
        final updatedBudget = widget.budget!.copy(
          name: name,
          income: income,
          categories: categories,
        );
        context.read<BudgetBloc>().add(UpdateBudget(updatedBudget));
      }
      Navigator.pop(context, true);
    }
  }

  void _deleteCategory(UniqueKey key) {
    int idx =
        _categoryInputs.indexWhere((element) => element.inputField.key == key);
    setState(() {
      _categoryInputs.removeAt(idx);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.budget == null ? 'Add Budget' : 'Edit Budget'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                TextFormField(
                  controller: _nameController,
                  decoration: const InputDecoration(labelText: 'Budget Name'),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter a budget name';
                    }
                    return null;
                  },
                ),
                TextFormField(
                  controller: _incomeController,
                  decoration: const InputDecoration(labelText: 'Income'),
                  keyboardType:
                      const TextInputType.numberWithOptions(decimal: true),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter an income amount';
                    }
                    if (double.tryParse(value) == null) {
                      return 'Please enter a valid number';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 20),
                Container(
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        Row(
                          children: [
                            Expanded(child: Text("Categories")),
                            IconButton(
                              onPressed: () {
                                final nameController = TextEditingController();
                                final limitController = TextEditingController();
                                final inputKey = UniqueKey();
                                final inputField = CategoryInput(
                                  key: inputKey,
                                  onDelete: () {
                                    _deleteCategory(inputKey);
                                  },
                                  nameController: nameController,
                                  limitController: limitController,
                                );
                                final newInput = CategoryInputStructure(
                                    inputField,
                                    nameController,
                                    limitController);
                                setState(() {
                                  _categoryInputs = [
                                    newInput,
                                    ..._categoryInputs
                                  ];
                                });
                              },
                              icon: Icon(Icons.add),
                            ),
                          ],
                        ),
                        ..._categoryInputs.map((e) => e.inputField)
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () => _submitForm(context),
                  child: Text(widget.budget == null ? 'Save' : "Update"),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _nameController.dispose();
    _incomeController.dispose();
    for (CategoryInputStructure st in _categoryInputs) {
      st.nameController.dispose();
      st.limitController.dispose();
    }
    super.dispose();
  }
}
