import 'package:flutter/material.dart';

class LabeledTextFieldWidget extends StatelessWidget {
  final TextEditingController controller;
  final String label;
  final bool obscureText;

  const LabeledTextFieldWidget({
    super.key,
    required this.controller,
    required this.label,
    this.obscureText = false,
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
          obscureText: obscureText,
          decoration: const InputDecoration(
            border: OutlineInputBorder(),
          ),
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Preencha este campo!';
            }

            return null;
          },
        ),
      ],
    );
  }
}
