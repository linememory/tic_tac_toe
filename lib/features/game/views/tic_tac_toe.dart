import 'package:flutter/material.dart';

enum FieldState {
  empty("Empty"),
  player1("Player 1"),
  player2("Player 2");

  final String name;
  const FieldState(this.name);
}

class TicTacToe extends StatefulWidget {
  const TicTacToe({Key? key}) : super(key: key);

  @override
  State<TicTacToe> createState() => _TicTacToeState();
}

class _TicTacToeState extends State<TicTacToe> {
  var fields = List.filled(9, FieldState.empty);
  bool player = false;
  @override
  Widget build(BuildContext context) {
    hasPlayerWon(player) {
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

    FieldState? winner;
    winner = hasPlayerWon(FieldState.player1)
        ? FieldState.player1
        : hasPlayerWon(FieldState.player2)
            ? FieldState.player2
            : null;
    List<Widget> children = [];
    bool hassEmptyField = false;
    for (int i = 0; i < 9; i++) {
      IconData? iconData;
      Color? color = Colors.transparent;
      void Function(int)? onTab;
      switch (fields[i]) {
        case FieldState.empty:
          iconData = Icons.question_mark;
          color = Colors.transparent;
          onTab = (int id) {
            setState(() {
              player = !player;
              fields[id] = player ? FieldState.player1 : FieldState.player2;
            });
          };
          break;
        case FieldState.player1:
          iconData = Icons.circle_outlined;
          color = Colors.green.shade400;
          break;
        case FieldState.player2:
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
      if (fields[i] == FieldState.empty) hassEmptyField = true;
    }

    if (!hassEmptyField) winner = FieldState.empty;
    return Scaffold(
      backgroundColor: winner == FieldState.player1
          ? Colors.green.shade300
          : winner == FieldState.player2
              ? Colors.red.shade300
              : Colors.amber.shade300,
      appBar: AppBar(actions: [
        IconButton(
            onPressed: () {
              setState(() {
                fields = List.filled(9, FieldState.empty);
              });
            },
            icon: const Icon(Icons.autorenew))
      ]),
      body: SafeArea(
        child: Center(
          child: Builder(
            builder: (context) {
              if (winner == null) {
                return GridView(
                  shrinkWrap: true,
                  padding: const EdgeInsets.all(20),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 3),
                  children: children,
                );
              } else {
                String winnerName = winner == FieldState.empty
                    ? "Draw!"
                    : "${winner.name} Has Won!";
                return Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Card(
                        margin: const EdgeInsets.symmetric(horizontal: 100),
                        color: winner == FieldState.player1
                            ? Colors.green
                            : winner == FieldState.player2
                                ? Colors.red
                                : Colors.amber,
                        child: ListTile(
                          title: Text(
                            winnerName,
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 25,
                      ),
                      ElevatedButton(
                        onPressed: () {
                          setState(() {
                            fields = List.filled(9, FieldState.empty);
                          });
                        },
                        child: const Text("Play Again!"),
                      )
                    ],
                  ),
                );
              }
            },
          ),
        ),
      ),
    );
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
    return GestureDetector(
      onTap: () {
        if (onTab != null) onTab!(id);
      },
      child: Container(
        decoration: BoxDecoration(
          color: color,
          border: Border.all(),
        ),
        child: Container(
          constraints: const BoxConstraints.expand(),
          color: color,
          child: Icon(icon ?? Icons.question_mark),
        ),
      ),
    );
  }
}
