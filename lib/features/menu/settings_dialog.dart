import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tic_tac_toe/features/core/settings.dart';

class SettingsDialog extends ConsumerWidget {
  const SettingsDialog({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, ref) {
    final settings = ref.watch(settingsProvider);
    void changeColor(MaterialColor color) =>
        ref.read(settingsProvider.state).state =
            settings.copyWith(customColor: color);
    return SimpleDialog(
      insetPadding: const EdgeInsets.all(30),
      titlePadding: const EdgeInsets.all(10),
      contentPadding: const EdgeInsets.all(10),
      title: const Text(
        'Settings',
        textAlign: TextAlign.center,
      ),
      children: [
        SizedBox(
          width: MediaQuery.of(context).size.width,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text("Theme: "),
                  DropdownButton<ThemeMode>(
                    value: settings.themeMode,
                    items: const [
                      DropdownMenuItem(
                          value: ThemeMode.system, child: Text("System")),
                      DropdownMenuItem(
                          value: ThemeMode.light, child: Text("Light")),
                      DropdownMenuItem(
                          value: ThemeMode.dark, child: Text("Dark"))
                    ],
                    onChanged: (themeMode) {
                      if (themeMode != null) {
                        ref.read(settingsProvider.state).state =
                            settings.copyWith(themeMode: themeMode);
                      }
                    },
                  )
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text("ColorMode"),
                  DropdownButton<ColorMode>(
                    value: settings.colorMode,
                    items: const [
                      DropdownMenuItem(
                          value: ColorMode.system, child: Text("System")),
                      DropdownMenuItem(
                          value: ColorMode.custom, child: Text("Custom"))
                    ],
                    onChanged: (colorMode) {
                      if (colorMode != null) {
                        ref.read(settingsProvider.state).state =
                            settings.copyWith(colorMode: colorMode);
                      }
                    },
                  )
                ],
              ),
              if (settings.colorMode == ColorMode.custom)
                Wrap(
                  children: [
                    _ColorButton(
                      color: Colors.purple,
                      onTab: changeColor,
                    ),
                    _ColorButton(
                      color: Colors.pink,
                      onTab: changeColor,
                    ),
                    _ColorButton(
                      color: Colors.red,
                      onTab: changeColor,
                    ),
                    _ColorButton(
                      color: Colors.deepOrange,
                      onTab: changeColor,
                    ),
                    _ColorButton(
                      color: Colors.amber,
                      onTab: changeColor,
                    ),
                    _ColorButton(
                      color: Colors.yellow,
                      onTab: changeColor,
                    ),
                    _ColorButton(
                      color: Colors.lime,
                      onTab: changeColor,
                    ),
                    _ColorButton(
                      color: Colors.green,
                      onTab: changeColor,
                    ),
                    _ColorButton(
                      color: Colors.indigo,
                      onTab: changeColor,
                    ),
                    _ColorButton(
                      color: Colors.blue,
                      onTab: changeColor,
                    ),
                    _ColorButton(
                      color: Colors.lightBlue,
                      onTab: changeColor,
                    ),
                    _ColorButton(
                      color: Colors.teal,
                      onTab: changeColor,
                    ),
                  ],
                ),
              const Divider(),
              NameForm(onSubmit: (String player1, String player2) {
                ref.read(settingsProvider.state).state = settings.copyWith(
                    player1Name: player1, player2Name: player2);
              }),
            ],
          ),
        ),
      ],
    );
  }
}

class NameForm extends StatefulWidget {
  const NameForm({
    Key? key,
    required this.onSubmit,
  }) : super(key: key);

  final void Function(String player1Name, String player2Name) onSubmit;

  @override
  State<NameForm> createState() => _NameFormState();
}

class _NameFormState extends State<NameForm> {
  String player1 = "Player 1";
  String player2 = "Player 2";
  @override
  Widget build(BuildContext context) {
    return Form(
      child: Column(
        children: [
          TextFormField(
            onChanged: (value) {
              player1 = value;
            },
            decoration: const InputDecoration(
              border: OutlineInputBorder(),
              isDense: true,
              label: Text("Player 1 Name"),
              contentPadding: EdgeInsets.all(10),
            ),
          ),
          const SizedBox(
            height: 14,
          ),
          TextFormField(
            onChanged: (value) {
              player2 = value;
            },
            decoration: const InputDecoration(
              border: OutlineInputBorder(),
              isDense: true,
              label: Text("Player 2 Name"),
              contentPadding: EdgeInsets.all(10),
            ),
          ),
          Builder(builder: (context) {
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 80.0),
              child: ElevatedButton(
                  onPressed: () {
                    if (Form.of(context)?.validate() ?? false) {
                      widget.onSubmit(player1, player2);
                      Navigator.pop(context);
                    }
                  },
                  child: const Text("Save")),
            );
          }),
        ],
      ),
    );
  }
}

class _ColorButton extends StatelessWidget {
  const _ColorButton({
    Key? key,
    required this.color,
    required this.onTab,
  }) : super(key: key);

  final MaterialColor color;
  final void Function(MaterialColor) onTab;

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () {
        onTab(color);
      },
      icon: Icon(Icons.format_color_fill_outlined, color: color),
    );
  }
}