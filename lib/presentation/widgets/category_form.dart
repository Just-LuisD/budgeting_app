import 'package:flutter/material.dart';

class CategoryForm extends StatefulWidget {
  const CategoryForm({super.key});

  @override
  State<CategoryForm> createState() => _CategoryFormState();
}

class _CategoryFormState extends State<CategoryForm> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Add Category"),
      ),
      body: SingleChildScrollView(
        child: Form(
          child: Column(
            children: [
              TextFormField(
                controller: null,
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
                controller: null,
                decoration: InputDecoration(
                  labelText: "Limit",
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
              ElevatedButton(
                onPressed: () {},
                child: Text("Add"),
              ),
            ],
          ),
        ),
      ),
    );
    ;
  }
}
