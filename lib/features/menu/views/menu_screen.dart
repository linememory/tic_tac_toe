import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tic_tac_toe/features/core/providers/settings_provider.dart';
import 'package:tic_tac_toe/features/game/views/tic_tac_toe_screen.dart';
import 'package:tic_tac_toe/features/menu/views/credits_dialog.dart';
import 'package:tic_tac_toe/features/menu/views/settings_dialog.dart';
import 'package:tic_tac_toe/features/menu/views/statistics_dialog.dart';

class MenuScreen extends StatelessWidget {
  const MenuScreen({Key? key}) : super(key: key);

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
      backgroundColor: Theme.of(context).colorScheme.background,
      appBar: AppBar(
        title: Consumer(
          builder: (context, ref, child) {
            return Text(ref.watch(settingsProvider).appName);
          },
        ),
      ),
      body: SafeArea(
          child: Center(
              child: Padding(
        padding: EdgeInsets.symmetric(
            horizontal: MediaQuery.of(context).size.width / 4),
        child: ConstrainedBox(
          constraints: BoxConstraints.loose(const Size.fromWidth(200)),
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
                      return const StatisticsDialog();
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
                      return const SettingsDialog();
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
                      return const CreditsDialog();
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
        ),
      ))),
    );
  }
}
