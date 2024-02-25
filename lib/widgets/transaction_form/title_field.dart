import 'package:flutter/material.dart';

class TitleField extends StatelessWidget {
  final TextEditingController inputController;
  const TitleField({
    super.key,
    required this.inputController,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: inputController,
      decoration: const InputDecoration(
        labelText: 'Title',
      ),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Your transaction must have a title.';
        }
        return null;
      },
    );
  }
}
