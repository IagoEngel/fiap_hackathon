import 'package:flutter/material.dart';

class LabeledTextFieldWidget extends StatefulWidget {
  final TextEditingController controller;
  final String label;
  final bool isPassword;
  final int maxLines;

  const LabeledTextFieldWidget({
    super.key,
    required this.controller,
    required this.label,
    this.isPassword = false,
    this.maxLines = 1,
  });

  @override
  State<LabeledTextFieldWidget> createState() => _LabeledTextFieldWidgetState();
}

class _LabeledTextFieldWidgetState extends State<LabeledTextFieldWidget> {
  bool showPassword = false;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(widget.label),
        const SizedBox(height: 6),
        TextFormField(
          controller: widget.controller,
          obscureText: widget.isPassword,
          minLines: 1,
          maxLines: widget.maxLines,
          decoration: InputDecoration(
            suffixIcon: widget.isPassword
                ? IconButton(
                    onPressed: () =>
                        setState(() => showPassword = !showPassword),
                    icon: const Icon(Icons.remove_red_eye),
                  )
                : null,
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
