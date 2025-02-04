import 'package:flutter/material.dart';

class CustomTextButtonWidget extends StatelessWidget {
  final void Function()? onPressed;
  final String title;

  const CustomTextButtonWidget({
    super.key,
    required this.onPressed,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onPressed,
      style: TextButton.styleFrom(
        textStyle: const TextStyle(
          decoration: TextDecoration.underline,
        ),
      ),
      child: Text(title),
    );
  }
}
