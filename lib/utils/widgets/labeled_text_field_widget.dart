import 'package:flutter/material.dart';

class LabeledTextFieldWidget extends StatelessWidget {
  final TextEditingController controller;
  final String label;

  const LabeledTextFieldWidget({
    super.key,
    required this.controller,
    required this.label,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label),
        const SizedBox(height: 6),
        TextFormField(
          controller: controller,
          decoration: const InputDecoration(
            border: OutlineInputBorder(),
          ),
        ),
      ],
    );
  }
}
