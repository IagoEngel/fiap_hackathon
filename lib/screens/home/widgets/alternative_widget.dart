import 'package:flutter/material.dart';

class AlternativeWidget extends StatelessWidget {
  final String title;
  final bool selected;
  final void Function()? onTap;

  const AlternativeWidget({
    super.key,
    required this.title,
    required this.onTap,
    this.selected = false,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        color: selected ? Colors.red : Colors.blue,
        width: double.infinity,
        margin: const EdgeInsets.only(bottom: 8),
        padding: const EdgeInsets.all(8),
        alignment: Alignment.center,
        child: Text(title),
      ),
    );
  }
}