import 'package:flutter/material.dart';

class NotesField extends StatelessWidget {
  final TextEditingController inputController;
  const NotesField({
    super.key,
    required this.inputController,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      maxLines: 8,
      controller: inputController,
      decoration: const InputDecoration(
        label: Text("Notes"),
      ),
    );
  }
}
