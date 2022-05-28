import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tic_tac_toe/features/core/providers/settings_provider.dart';
import 'package:tic_tac_toe/features/core/widgets/dialog_title.dart';

class SettingsDialog extends ConsumerWidget {
  const SettingsDialog({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, ref) {
    final settings = ref.watch(settingsProvider);
    void changeColor(MaterialColor color) =>
        ref.read(settingsProvider.notifier).setColor(color);
    return SimpleDialog(
      insetPadding: const EdgeInsets.all(30),
      titlePadding: const EdgeInsets.all(10),
      contentPadding: const EdgeInsets.all(10),
      title: const DialogTitle(title: "Settings"),
      children: [
        ConstrainedBox(
          constraints: BoxConstraints.loose(const Size.fromWidth(265)),
          child: Column(
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
                        ref
                            .read(settingsProvider.notifier)
                            .setThemeMode(themeMode);
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
                        ref
                            .read(settingsProvider.notifier)
                            .setColorMode(colorMode);
                      }
                    },
                  )
                ],
              ),
              if (settings.colorMode == ColorMode.custom)
                Wrap(
                    children: SettingsState.colors
                        .map(
                          (e) => _ColorButton(
                            color: e,
                            onTab: changeColor,
                          ),
                        )
                        .toList()),
              const Divider(),
              _NameForm(onSubmit: (String player1, String player2) {
                ref
                    .read(settingsProvider.notifier)
                    .setPlayerNames(player1, player2);
              }),
            ],
          ),
        ),
      ],
    );
  }
}

class _NameForm extends ConsumerStatefulWidget {
  const _NameForm({
    Key? key,
    required this.onSubmit,
  }) : super(key: key);

  final void Function(String player1Name, String player2Name) onSubmit;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _NameFormState();
}

class _NameFormState extends ConsumerState<_NameForm> {
  String player1 = "Player 1";
  String player2 = "Player 2";
  @override
  Widget build(BuildContext context) {
    final settings = ref.watch(settingsProvider);
    player1 = settings.player1Name;
    player2 = settings.player2Name;
    return Form(
      child: Column(
        children: [
          TextFormField(
            initialValue: settings.player1Name,
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
            initialValue: settings.player2Name,
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
          const SizedBox(
            height: 10,
          ),
          Builder(builder: (context) {
            return ElevatedButton(
                onPressed: () {
                  if (Form.of(context)?.validate() ?? false) {
                    widget.onSubmit(player1, player2);
                    Navigator.pop(context);
                  }
                },
                child: Container(
                  padding: const EdgeInsets.symmetric(vertical: 10.0),
                  child: const Text("Save Names"),
                ));
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
