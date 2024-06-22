import 'package:flutter/material.dart';

class CategoryInput extends StatelessWidget {
  final void Function()? onDelete;
  final nameController = TextEditingController();
  final limitController = TextEditingController();

  CategoryInput({super.key, required this.onDelete});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: TextFormField(
            controller: nameController,
            decoration: const InputDecoration(labelText: "Name"),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return "Please enter a valid name";
              }
              return null;
            },
          ),
        ),
        const SizedBox(width: 8),
        Expanded(
          child: TextFormField(
            controller: limitController,
            decoration: const InputDecoration(labelText: 'Limit'),
            keyboardType: const TextInputType.numberWithOptions(decimal: true),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return "Please enter an limit amount";
              }
              if (double.tryParse(value) == null) {
                return "Please enter a valid number";
              }
              return null;
            },
          ),
        ),
        Container(
          padding: EdgeInsets.only(top: 16),
          alignment: Alignment.bottomCenter,
          child: IconButton(
            onPressed: onDelete,
            icon: Icon(Icons.delete),
          ),
        )
      ],
    );
  }
}
