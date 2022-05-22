import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tic_tac_toe/main.dart';

final ticTacToeProvider = StateProvider.autoDispose<List<Player>>((ref) {
  return List.filled(3 * 3, Player.none);
});

final playerProvider = StateProvider.autoDispose<bool>((ref) {
  return false;
});

enum Player {
  none("NONE"),
  player1("Player 1"),
  player2("Player 2");

  final String name;
  const Player(this.name);
}

class TicTacToe extends ConsumerWidget {
  const TicTacToe({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.listen<StateController<List<Player>>>(ticTacToeProvider.state,
        (previous, next) {
      Player winner;
      Color color = Theme.of(context).primaryColor;
      if (hasPlayerWon(Player.player1, next.state)) {
        winner = Player.player1;
        color = Colors.green;
      } else if (hasPlayerWon(Player.player2, next.state)) {
        winner = Player.player2;
        color = Colors.red;
      } else if (!next.state.contains(Player.none)) {
        winner = Player.none;
      } else {
        return;
      }
      showDialog<String>(
        barrierDismissible: false,
        context: context,
        builder: (BuildContext context) => SimpleDialog(
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
                      winner == Player.none
                          ? "Draw"
                          : "${winner.name} Has Won!",
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(
                      height: 25,
                    ),
                    ElevatedButton(
                      onPressed: () {
                        ref.refresh(ticTacToeProvider);
                        if (winner == null) {
                          Random rng = Random();
                          winner =
                              rng.nextBool() ? Player.player2 : Player.player1;
                        }
                        ref.read(playerProvider.state).state =
                            winner == Player.player1 ? true : false;
                        Navigator.pop(context, 'Again');
                      },
                      child: const Text("Play Again!"),
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      );
    });

    List<Widget> children = generateChildren(ref, context);

    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      appBar: AppBar(
        title: const Text("Tic Tac Toe"),
        actions: [
          IconButton(
            onPressed: () {
              ref.refresh(ticTacToeProvider);
            },
            icon: const Icon(Icons.autorenew),
          ),
          IconButton(
            onPressed: () {
              ref.read(themeColorProvider.state).state = Colors.red;
            },
            icon: Icon(
              Icons.format_color_fill_outlined,
              color: Colors.red.shade700,
            ),
          ),
          IconButton(
            onPressed: () {
              ref.read(themeColorProvider.state).state = Colors.amber;
            },
            icon: Icon(
              Icons.format_color_fill_outlined,
              color: Colors.amber.shade700,
            ),
          ),
          IconButton(
            onPressed: () {
              ref.read(themeColorProvider.state).state = Colors.green;
            },
            icon: Icon(
              Icons.format_color_fill_outlined,
              color: Colors.green.shade700,
            ),
          ),
        ],
      ),
      body: SafeArea(
        child: Center(
          child: Builder(
            builder: (context) {
              // if (winner == null) {
              return GridView(
                shrinkWrap: true,
                padding: const EdgeInsets.all(20),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3),
                children: children,
              );
            },
          ),
        ),
      ),
    );
  }

  List<Widget> generateChildren(WidgetRef ref, context) {
    List<Player> fields = ref.watch(ticTacToeProvider);
    bool player = ref.watch(playerProvider);
    List<Widget> children = [];
    for (int i = 0; i < 9; i++) {
      IconData? iconData;
      Color? color = Colors.transparent;
      void Function(int)? onTab;
      switch (fields[i]) {
        case Player.none:
          iconData = Icons.question_mark;
          color = Theme.of(context).primaryColorLight;
          onTab = (int id) {
            List<Player> state = List.from(fields);
            state[id] = player ? Player.player2 : Player.player1;
            ref.read(ticTacToeProvider.state).state = state;
            ref.read(playerProvider.state).state = !player;
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
        Field(
          id: i,
          icon: iconData,
          color: color,
          onTab: onTab,
        ),
      );
    }
    return children;
  }

  bool hasPlayerWon(Player player, List<Player> fields) {
    // horizontal
    if ((fields[0] == player && fields[1] == player && fields[2] == player) ||
        (fields[3] == player && fields[4] == player && fields[5] == player) ||
        (fields[6] == player && fields[7] == player && fields[8] == player)) {
      return true;
    }
    // vertical
    if ((fields[0] == player && fields[3] == player && fields[6] == player) ||
        (fields[1] == player && fields[4] == player && fields[7] == player) ||
        (fields[2] == player && fields[5] == player && fields[8] == player)) {
      return true;
    }
    // diagonal
    if ((fields[0] == player && fields[4] == player && fields[8] == player) ||
        (fields[6] == player && fields[4] == player && fields[2] == player)) {
      return true;
    }
    return false;
  }
}

class Field extends StatelessWidget {
  const Field({
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
