import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:tic_tac_toe/features/game/views/tic_tac_toe.dart';

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
              onPressed: () {},
              child: const Text("Statistics"),
            ),
            ElevatedButton(
              style: buttonStyle,
              onPressed: () {},
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
