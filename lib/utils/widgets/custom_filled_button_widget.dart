import 'package:flutter/material.dart';

class CustomFilledButtonWidget extends StatelessWidget {
  final void Function()? onPressed;
  final String title;

  const CustomFilledButtonWidget({
    super.key,
    required this.onPressed,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return FilledButton(
      onPressed: onPressed,
      child: Text(title),
    );
  }
}
