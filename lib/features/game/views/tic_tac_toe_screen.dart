import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tic_tac_toe/features/core/providers/settings_provider.dart';
import 'package:tic_tac_toe/features/game/providers/tic_tac_toe_provider.dart';
import 'package:tic_tac_toe/features/core/providers/statistics_provider.dart';
import 'package:tic_tac_toe/features/game/views/winner_dialog.dart';

class TicTacToe extends ConsumerWidget {
  const TicTacToe({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.listen<TicTacToeState>(ticTacToeProvider, (previous, next) {
      final settings = ref.watch(settingsProvider);
      Color color = Theme.of(context).primaryColor;
      if (next.winner != null) {
        String winnerName;
        if (next.winner == Player.player1) {
          winnerName = "${settings.player1Name} has won!";
          color = settings.player1Color;
        } else if (next.winner == Player.player2) {
          winnerName = "${settings.player2Name} has won!";
          color = settings.player2Color;
        } else {
          winnerName = "Draw!";
          color = settings.drawColor;
        }
        ref.read(statisticsProvider.notifier).increment(next.winner!);
        showDialog<String>(
          barrierDismissible: false,
          context: context,
          builder: (BuildContext context) => WinnerDialog(
            winner: winnerName,
            color: color,
            onAgain: () {
              ref.read(ticTacToeProvider.notifier).resetGame();
              Navigator.pop(context, 'Again');
            },
          ),
        );
      }
    });

    List<Widget> gridFields = _generateGridFields(ref, context);

    AppBar appBar = AppBar(
      title: Consumer(
        builder: (context, ref, child) {
          return Text(ref.watch(settingsProvider).appName);
        },
      ),
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
                  children: gridFields,
                ),
              );
            },
          ),
        ),
      ),
    );
  }

  List<Widget> _generateGridFields(WidgetRef ref, context) {
    final gameState = ref.watch(ticTacToeProvider);
    final settings = ref.watch(settingsProvider);
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
          color = settings.player1Color.shade400;
          break;
        case Player.player2:
          iconData = Icons.clear;
          color = settings.player2Color.shade400;
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
