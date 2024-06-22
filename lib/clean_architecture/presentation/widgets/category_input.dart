import 'package:flutter/material.dart';

class CategoryInput extends StatelessWidget {
  const CategoryInput({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: TextFormField(
            decoration: const InputDecoration(labelText: "Name"),
          ),
        ),
        const SizedBox(width: 8),
        Expanded(
          child: TextFormField(
            decoration: const InputDecoration(labelText: 'Limit'),
            keyboardType: const TextInputType.numberWithOptions(decimal: true),
          ),
        ),
        Container(
          padding: EdgeInsets.only(top: 16),
          alignment: Alignment.bottomCenter,
          child: IconButton(
            onPressed: () {},
            icon: Icon(Icons.delete),
          ),
        )
      ],
    );
  }
}
