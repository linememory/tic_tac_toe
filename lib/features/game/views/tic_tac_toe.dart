import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tic_tac_toe/features/core/settings.dart';
import 'package:tic_tac_toe/features/game/tic_tac_toe_notifier.dart';

final ticTacToeProvider =
    StateNotifierProvider.autoDispose<TicTacToeNotifier, TicTacToeState>((ref) {
  return TicTacToeNotifier();
});

class TicTacToe extends ConsumerWidget {
  const TicTacToe({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.listen<TicTacToeState>(ticTacToeProvider, (previous, next) {
      final settings = ref.watch(settingsProvider);
      Color color = Theme.of(context).primaryColor;
      if (next.winner != null) {
        if (next.winner == Player.player1) {
          color = Colors.green;
        } else if (next.winner == Player.player2) {
          color = Colors.red;
        } else {
          color = Colors.yellow;
        }
        showDialog<String>(
          barrierDismissible: false,
          context: context,
          builder: (BuildContext context) => _WinnerDialog(
            winner: next.winner! == Player.none
                ? "Draw!"
                : next.winner! == Player.player1
                    ? "${settings.player1Name} has won!"
                    : "${settings.player2Name} has won!",
            color: color,
            onAgain: () {
              ref.read(ticTacToeProvider.notifier).resetGame();
              Navigator.pop(context, 'Again');
            },
          ),
        );
      }
    });

    List<Widget> children = generateChildren(ref, context);

    AppBar appBar = AppBar(
      title: const Text("Tic Tac Toe"),
      actions: [
        IconButton(
          onPressed: () {
            ref.read(ticTacToeProvider.notifier).resetGame();
          },
          icon: const Icon(Icons.autorenew),
        ),
      ],
    );

    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      appBar: appBar,
      body: SafeArea(
        child: Center(
          child: Builder(
            builder: (context) {
              double padding = 20;
              double width = MediaQuery.of(context).size.width - padding;
              double height = MediaQuery.of(context).size.height -
                  padding -
                  appBar.preferredSize.height;
              if (height < width) {
                width = height;
              } else {
                height = width;
              }

              return ConstrainedBox(
                constraints: BoxConstraints.loose(Size(width, height)),
                child: GridView(
                  shrinkWrap: true,
                  padding: EdgeInsets.all(padding),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 3),
                  children: children,
                ),
              );
            },
          ),
        ),
      ),
    );
  }

  List<Widget> generateChildren(WidgetRef ref, context) {
    final gameState = ref.watch(ticTacToeProvider);
    List<Widget> children = [];
    for (int i = 0; i < 9; i++) {
      IconData? iconData;
      Color? color = Colors.transparent;
      void Function(int)? onTab;
      switch (gameState.fields[i]) {
        case Player.none:
          iconData = Icons.question_mark;
          color = Theme.of(context).primaryColorLight;
          onTab = (int id) {
            ref.read(ticTacToeProvider.notifier).setField(id);
          };
          break;
        case Player.player1:
          iconData = Icons.circle_outlined;
          color = Colors.green.shade400;
          break;
        case Player.player2:
          iconData = Icons.clear;
          color = Colors.red.shade400;
          break;
        default:
      }
      children.add(
        _Field(
          id: i,
          icon: iconData,
          color: color,
          onTab: onTab,
        ),
      );
    }
    return children;
  }
}

class _Field extends StatelessWidget {
  const _Field({
    Key? key,
    this.icon,
    this.color,
    this.onTab,
    required this.id,
  }) : super(key: key);

  final int id;
  final IconData? icon;
  final Color? color;
  final void Function(int id)? onTab;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(2.0),
      child: GestureDetector(
        onTap: () {
          if (onTab != null) onTab!(id);
        },
        child: Container(
          decoration: BoxDecoration(
              color: color,
              border: Border.all(color: Colors.black54),
              borderRadius: BorderRadius.circular(10)),
          child: Icon(icon ?? Icons.question_mark),
        ),
      ),
    );
  }
}

class _WinnerDialog extends StatelessWidget {
  const _WinnerDialog(
      {Key? key,
      required this.winner,
      required this.onAgain,
      required this.color})
      : super(key: key);

  final String winner;
  final Color color;
  final Function() onAgain;

  @override
  Widget build(BuildContext context) {
    return SimpleDialog(
      backgroundColor: color,
      titlePadding: const EdgeInsets.all(10),
      contentPadding: const EdgeInsets.all(0),
      title: const Text(
        'Game Ended',
        textAlign: TextAlign.center,
      ),
      children: [
        Padding(
          padding: const EdgeInsets.all(18.0),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  winner,
                  textAlign: TextAlign.center,
                ),
                const SizedBox(
                  height: 25,
                ),
                ElevatedButton(
                  onPressed: onAgain,
                  child: const Text("Play Again!"),
                )
              ],
            ),
          ),
        ),
      ],
    );
  }
}
