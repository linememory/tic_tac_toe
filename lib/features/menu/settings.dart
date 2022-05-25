import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tic_tac_toe/main.dart';

class Settings extends ConsumerWidget {
  const Settings({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, ref) {
    final themeMode = ref.watch(themeModeProvider);
    final colorMode = ref.watch(colorModeProvider);
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
                    value: themeMode,
                    items: const [
                      DropdownMenuItem(
                          value: ThemeMode.system, child: Text("System")),
                      DropdownMenuItem(
                          value: ThemeMode.light, child: Text("Light")),
                      DropdownMenuItem(
                          value: ThemeMode.dark, child: Text("Dark"))
                    ],
                    onChanged: (value) {
                      if (value != null) {
                        ref.read(themeModeProvider.state).state = value;
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
                    value: colorMode,
                    items: const [
                      DropdownMenuItem(
                          value: ColorMode.system, child: Text("System")),
                      DropdownMenuItem(
                          value: ColorMode.custom, child: Text("Custom"))
                    ],
                    onChanged: (value) {
                      if (value != null) {
                        ref.read(colorModeProvider.state).state = value;
                      }
                    },
                  )
                ],
              ),
              if (colorMode == ColorMode.custom)
                Wrap(
                  children: [
                    _ColorButton(
                      color: Colors.purple,
                      onTab: (color) =>
                          ref.read(themeColorProvider.state).state = color,
                    ),
                    _ColorButton(
                      color: Colors.pink,
                      onTab: (color) =>
                          ref.read(themeColorProvider.state).state = color,
                    ),
                    _ColorButton(
                      color: Colors.red,
                      onTab: (color) =>
                          ref.read(themeColorProvider.state).state = color,
                    ),
                    _ColorButton(
                      color: Colors.deepOrange,
                      onTab: (color) =>
                          ref.read(themeColorProvider.state).state = color,
                    ),
                    _ColorButton(
                      color: Colors.amber,
                      onTab: (color) =>
                          ref.read(themeColorProvider.state).state = color,
                    ),
                    _ColorButton(
                      color: Colors.yellow,
                      onTab: (color) =>
                          ref.read(themeColorProvider.state).state = color,
                    ),
                    _ColorButton(
                      color: Colors.lime,
                      onTab: (color) =>
                          ref.read(themeColorProvider.state).state = color,
                    ),
                    _ColorButton(
                      color: Colors.green,
                      onTab: (color) =>
                          ref.read(themeColorProvider.state).state = color,
                    ),
                    _ColorButton(
                      color: Colors.indigo,
                      onTab: (color) =>
                          ref.read(themeColorProvider.state).state = color,
                    ),
                    _ColorButton(
                      color: Colors.blue,
                      onTab: (color) =>
                          ref.read(themeColorProvider.state).state = color,
                    ),
                    _ColorButton(
                      color: Colors.lightBlue,
                      onTab: (color) =>
                          ref.read(themeColorProvider.state).state = color,
                    ),
                    _ColorButton(
                      color: Colors.teal,
                      onTab: (color) =>
                          ref.read(themeColorProvider.state).state = color,
                    ),
                  ],
                ),
              const Divider(),
              NameForm(onSubmit: (String player1, String player2) {}),
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
