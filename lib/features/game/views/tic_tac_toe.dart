import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

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
        color = Colors.yellow;
      } else {
        return;
      }
      showDialog<String>(
        barrierDismissible: false,
        context: context,
        builder: (BuildContext context) => _WinnerDialog(
          winner: winner,
          color: color,
          onAgain: () {
            ref.refresh(ticTacToeProvider);
            if (winner == Player.none) {
              Random rng = Random();
              winner = rng.nextBool() ? Player.player2 : Player.player1;
            }
            ref.read(playerProvider.state).state =
                winner == Player.player1 ? true : false;
            Navigator.pop(context, 'Again');
          },
        ),
      );
    });

    List<Widget> children = generateChildren(ref, context);

    AppBar appBar = AppBar(
      title: const Text("Tic Tac Toe"),
      actions: [
        IconButton(
          onPressed: () {
            ref.refresh(ticTacToeProvider);
          },
          icon: const Icon(Icons.autorenew),
        ),
      ],
    );

    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
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

  final Player winner;
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
                  winner == Player.none ? "Draw" : "${winner.name} Has Won!",
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
