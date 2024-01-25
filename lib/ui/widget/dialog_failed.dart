import 'package:flutter/material.dart';

class DialogFailed extends StatelessWidget {
  const DialogFailed({super.key, required this.description});

  final String description;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text("Failed"),
      content: Text(description),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text("OK"),
        ),
      ],
    );
  }
}
