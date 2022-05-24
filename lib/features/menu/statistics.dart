import 'package:flutter/material.dart';

class Statistics extends StatelessWidget {
  const Statistics({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SimpleDialog(
      titlePadding: const EdgeInsets.all(10),
      contentPadding: const EdgeInsets.all(10),
      title: const Text(
        'Statistics',
        textAlign: TextAlign.center,
      ),
      children: [
        const Text("Games won:"),
        Divider(
          thickness: 0.25,
          color: Theme.of(context).primaryColor,
        ),
        const Card(
          color: Colors.green,
          child: ListTile(
            leading: Icon(Icons.circle_outlined),
            title: Text("0"),
          ),
        ),
        const Card(
          color: Colors.red,
          child: ListTile(
            leading: Icon(Icons.clear),
            title: Text("0"),
          ),
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
