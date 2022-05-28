import 'package:flutter/material.dart';

class WinnerDialog extends StatelessWidget {
  const WinnerDialog(
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
