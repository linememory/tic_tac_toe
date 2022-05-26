import 'package:flutter/material.dart';

class CreditsDialog extends StatelessWidget {
  const CreditsDialog({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SimpleDialog(
      titlePadding: const EdgeInsets.all(10),
      contentPadding: const EdgeInsets.all(10),
      title: const Text(
        'Credits',
        textAlign: TextAlign.center,
      ),
      children: [
        const Padding(
          padding: EdgeInsets.all(8.0),
          child: Center(child: Text("Lukas Leitner")),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 80.0),
          child: ElevatedButton(
              onPressed: () => Navigator.pop(context),
              child: const Text("Close")),
        )
      ],
    );
  }
}
