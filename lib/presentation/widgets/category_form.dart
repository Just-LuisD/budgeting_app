import 'package:budgeting_app/domain/entities/category.dart';
import 'package:budgeting_app/currency_input_formatter.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';

class CategoryForm extends StatefulWidget {
  final Category? category;
  final void Function(Category) onSubmit;
  final void Function(int)? onDelete;
  final void Function(int)? onClip;

  const CategoryForm({
    super.key,
    required this.onSubmit,
    this.onDelete,
    this.onClip,
    this.category,
  });

  @override
  State<CategoryForm> createState() => _CategoryFormState();
}

class _CategoryFormState extends State<CategoryForm> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _limitController = TextEditingController();
  String selectedTag = "";

  @override
  void initState() {
    super.initState();
    if (widget.category != null) {
      _nameController.text = widget.category!.name;
      _limitController.text = NumberFormat.simpleCurrency()
          .format(widget.category!.spendingLimit / 100);
    }
  }

  void _onSubmit() {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    final name = _nameController.text;
    final limit =
        int.tryParse(_limitController.text.replaceAll(RegExp("[.,\$]"), ""));
    Category newCategory;

    if (widget.category == null) {
      newCategory =
          Category(name: name, spendingLimit: limit!, tag: selectedTag);
    } else {
      newCategory = widget.category!.copy(
        name: name,
        spendingLimit: limit!,
        tag: selectedTag,
      );
    }

    widget.onSubmit(newCategory);
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(18),
      child: Form(
        key: _formKey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              children: [
                if (widget.category != null && widget.onClip != null)
                  IconButton(
                    onPressed: () {
                      widget.onClip!(widget.category!.id!);
                      Navigator.of(context).pop();
                    },
                    icon: const Icon(Icons.cut),
                  ),
                Expanded(
                  child: Text(
                    widget.category == null || widget.category!.id == null
                        ? "Add Category"
                        : "Edit Category",
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                if (widget.category != null && widget.onDelete != null)
                  IconButton(
                    onPressed: () {
                      widget.onDelete!(widget.category!.id!);
                      Navigator.of(context).pop();
                    },
                    icon: const Icon(Icons.delete),
                  ),
              ],
            ),
            TextFormField(
              controller: _nameController,
              decoration: const InputDecoration(
                labelText: 'Name',
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Your transaction must have a title.';
                }
                return null;
              },
            ),
            TextFormField(
              controller: _limitController,
              inputFormatters: [
                FilteringTextInputFormatter.digitsOnly,
                CurrencyInputFormatter(),
              ],
              decoration: const InputDecoration(
                labelText: "Limit",
              ),
              keyboardType: TextInputType.number,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter an limit amount';
                }
                String parsedValue = value.replaceAll(RegExp("[.,\$]"), "");
                if (int.tryParse(parsedValue) == null) {
                  return 'Please entee a valid number';
                }
                return null;
              },
            ),
            DropdownMenu(
              label: const Text("Tag"),
              initialSelection: widget.category == null
                  ? 0
                  : validTags.indexOf(widget.category!.tag!),
              onSelected: (value) {
                setState(() {
                  selectedTag = validTags[value ?? 0];
                });
              },
              dropdownMenuEntries: validTags.map((tag) {
                String label = tag == "" ? "none" : tag;
                int value = validTags.indexOf(tag);
                return DropdownMenuEntry(value: value, label: label);
              }).toList(),
            ),
            const SizedBox(
              height: 16,
            ),
            ElevatedButton(
              onPressed: _onSubmit,
              child: Text(widget.category == null || widget.category!.id == null
                  ? "Add"
                  : "Save"),
            ),
          ],
        ),
      ),
    );
  }
}
