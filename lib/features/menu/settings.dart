import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tic_tac_toe/main.dart';

class Settings extends ConsumerWidget {
  const Settings({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, ref) {
    return SimpleDialog(
      titlePadding: const EdgeInsets.all(10),
      contentPadding: const EdgeInsets.all(10),
      title: const Text(
        'Settings',
        textAlign: TextAlign.center,
      ),
      children: [
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
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 80.0),
          child: ElevatedButton(
              onPressed: () => Navigator.pop(context),
              child: const Text("Save")),
        )
      ],
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
