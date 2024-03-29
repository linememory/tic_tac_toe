import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tic_tac_toe/features/core/providers/statistics_provider.dart';
import 'package:tic_tac_toe/features/core/widgets/dialog_title.dart';

class StatisticsDialog extends ConsumerWidget {
  const StatisticsDialog({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, ref) {
    final statistics = ref.watch(statisticsProvider);
    return SimpleDialog(
      titlePadding: const EdgeInsets.all(10),
      contentPadding: const EdgeInsets.all(10),
      title: const DialogTitle(title: "Statistics"),
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
        const SizedBox(
          height: 10,
        ),
        Container(
          alignment: Alignment.center,
          child: ElevatedButton(
              onPressed: () => ref.read(statisticsProvider.notifier).reset(),
              child: Container(
                  padding: const EdgeInsets.all(10),
                  child: const Text("Reset"))),
        )
      ],
    );
  }
}
