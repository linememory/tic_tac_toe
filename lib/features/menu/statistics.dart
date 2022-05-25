import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tic_tac_toe/features/menu/statistics_provider.dart';

class Statistics extends ConsumerWidget {
  const Statistics({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, ref) {
    final statistics = ref.watch(statisticsProvider);
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
        Card(
          color: Colors.green,
          child: ListTile(
            leading: const Icon(Icons.circle_outlined),
            title: Text("${statistics.player1}"),
          ),
        ),
        Card(
          color: Colors.red,
          child: ListTile(
            leading: const Icon(Icons.clear),
            title: Text("${statistics.player2}"),
          ),
        ),
        Card(
          color: Colors.amber,
          child: ListTile(
            leading: const Icon(Icons.question_mark),
            title: Text("${statistics.draw}"),
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
