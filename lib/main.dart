import 'package:dynamic_color/dynamic_color.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tic_tac_toe/features/core/settings.dart';
import 'features/menu/menu.dart';

void main() {
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final settings = ref.watch(settingsProvider);

    return DynamicColorBuilder(
      builder: (ColorScheme? lightDynamic, ColorScheme? darkDynamic) {
        ColorScheme lightColorScheme;
        ColorScheme darkColorScheme;
        if (settings.colorMode == ColorMode.system &&
            lightDynamic != null &&
            darkDynamic != null) {
          lightColorScheme = lightDynamic.harmonized();
          darkColorScheme = darkDynamic.harmonized();
        } else {
          lightColorScheme = ColorScheme.fromSeed(
            seedColor: settings.customColor,
          );
          darkColorScheme = ColorScheme.fromSeed(
            seedColor: settings.customColor,
            brightness: Brightness.dark,
          );
        }
        return MaterialApp(
          title: 'Tic Tac Toe',
          themeMode: settings.themeMode,
          theme: ThemeData(colorScheme: lightColorScheme),
          darkTheme: ThemeData(colorScheme: darkColorScheme),
          home: const Menu(),
        );
      },
    );
  }
}
