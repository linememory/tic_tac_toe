import 'package:dynamic_color/dynamic_color.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'features/menu/menu.dart';

final themeColorProvider = StateProvider<MaterialColor>((ref) {
  return Colors.amber;
});

void main() {
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final color = ref.watch(themeColorProvider);

    return DynamicColorBuilder(
      builder: (ColorScheme? lightDynamic, ColorScheme? darkDynamic) {
        ColorScheme lightColorScheme;
        ColorScheme darkColorScheme;
        if (lightDynamic != null && darkDynamic != null) {
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
          theme: ThemeData(colorScheme: lightColorScheme),
          darkTheme: ThemeData(colorScheme: darkColorScheme),
          home: const Menu(),
        );
      },
    );
  }
}
