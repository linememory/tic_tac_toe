import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:tic_tac_toe/features/game/views/tic_tac_toe.dart';
import 'package:tic_tac_toe/features/menu/credits.dart';
import 'package:tic_tac_toe/features/menu/settings.dart';
import 'package:tic_tac_toe/features/menu/statistics.dart';

class Menu extends StatelessWidget {
  const Menu({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var buttonStyle = ButtonStyle(
      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
        RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
      ),
      visualDensity: const VisualDensity(
          horizontal: VisualDensity.maximumDensity,
          vertical: VisualDensity.maximumDensity),
    );
    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      body: SafeArea(
          child: Center(
              child: Padding(
        padding: EdgeInsets.symmetric(
            horizontal: MediaQuery.of(context).size.width / 4),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            ElevatedButton(
              style: buttonStyle,
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const TicTacToe()),
                );
              },
              child: const Text("Play"),
            ),
            ElevatedButton(
              style: buttonStyle,
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (context) {
                    return const Statistics();
                  },
                );
              },
              child: const Text("Statistics"),
            ),
            ElevatedButton(
              style: buttonStyle,
              onPressed: () {
                showDialog(
                  barrierDismissible: false,
                  context: context,
                  builder: (context) {
                    return const Settings();
                  },
                );
              },
              child: const Text("Settings"),
            ),
            ElevatedButton(
              style: buttonStyle,
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (context) {
                    return const Credits();
                  },
                );
              },
              child: const Text("Credits"),
            ),
            ElevatedButton(
              style: buttonStyle,
              onPressed: () {
                SystemNavigator.pop();
              },
              child: const Text("Quit"),
            ),
          ],
        ),
      ))),
    );
  }
}
