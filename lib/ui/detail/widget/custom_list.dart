import 'package:flutter/material.dart';

class CustomList extends StatelessWidget {
  const CustomList({
    super.key,
    required this.dataName,
  });

  final String dataName;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.blueGrey,
        borderRadius: BorderRadius.circular(16),
      ),
      margin: const EdgeInsets.all(4),
      padding: const EdgeInsets.symmetric(
        vertical: 8,
        horizontal: 16,
      ),
      child: Text(
        dataName,
        style: const TextStyle(
          fontSize: 12,
          color: Colors.white,
        ),
      ),
    );
  }
}
