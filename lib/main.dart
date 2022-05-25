import 'package:dynamic_color/dynamic_color.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'features/menu/menu.dart';

final themeColorProvider = StateProvider<MaterialColor>((ref) {
  return Colors.amber;
});

final themeModeProvider = StateProvider<ThemeMode>((ref) {
  return ThemeMode.system;
});

enum ColorMode {
  system,
  custom;
}

final colorModeProvider = StateProvider<ColorMode>((ref) {
  return ColorMode.system;
});

void main() {
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final color = ref.watch(themeColorProvider);
    final themeMode = ref.watch(themeModeProvider);
    final colorMode = ref.watch(colorModeProvider);

    return DynamicColorBuilder(
      builder: (ColorScheme? lightDynamic, ColorScheme? darkDynamic) {
        ColorScheme lightColorScheme;
        ColorScheme darkColorScheme;
        if (colorMode == ColorMode.system &&
            lightDynamic != null &&
            darkDynamic != null) {
          lightColorScheme = lightDynamic.harmonized();
          darkColorScheme = darkDynamic.harmonized();
        } else {
          lightColorScheme = ColorScheme.fromSeed(
            seedColor: color,
          );
          darkColorScheme = ColorScheme.fromSeed(
            seedColor: color,
            brightness: Brightness.dark,
          );
        }
        return MaterialApp(
          title: 'Tic Tac Toe',
          themeMode: themeMode,
          theme: ThemeData(colorScheme: lightColorScheme),
          darkTheme: ThemeData(colorScheme: darkColorScheme),
          home: const Menu(),
        );
      },
    );
  }
}
