import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

final settingsProvider =
    StateNotifierProvider<SettingsNotifier, SettingsState>((ref) {
  final pref = ref.watch(sharedPreferences).maybeWhen(
        data: (value) => value,
        orElse: () => null,
      );
  return SettingsNotifier(pref);
});

final sharedPreferences = FutureProvider<SharedPreferences>(
    (_) async => await SharedPreferences.getInstance());

class SettingsNotifier extends StateNotifier<SettingsState> {
  final SharedPreferences? pref;
  SettingsNotifier(this.pref)
      : super(SettingsState.fromStringList(pref?.getStringList("settings")));

  void setColor(MaterialColor color) {
    state = state.copyWith(customColor: color);
    _save();
  }

  void setThemeMode(ThemeMode themeMode) {
    state = state.copyWith(themeMode: themeMode);
    _save();
  }

  void setColorMode(ColorMode colorMode) {
    state = state.copyWith(colorMode: colorMode);
    _save();
  }

  void setPlayerNames(String player1Name, String player2Name) {
    state = state.copyWith(player1Name: player1Name, player2Name: player2Name);
    _save();
  }

  void _save() {
    final settings = <String>[
      state.themeMode.index.toString(),
      state.colorMode.index.toString(),
      SettingsState.colors.indexOf(state.customColor).toString(),
      state.player1Name,
      state.player2Name
    ];
    pref?.setStringList('settings', settings);
  }
}

class SettingsState {
  final ThemeMode themeMode;
  final ColorMode colorMode;
  final MaterialColor customColor;
  final String player1Name;
  final String player2Name;

  static final List<MaterialColor> colors = [
    Colors.purple,
    Colors.pink,
    Colors.red,
    Colors.deepOrange,
    Colors.amber,
    Colors.yellow,
    Colors.lime,
    Colors.green,
    Colors.indigo,
    Colors.blue,
    Colors.lightBlue,
    Colors.teal,
  ];

  SettingsState({
    this.themeMode = ThemeMode.system,
    this.colorMode = ColorMode.system,
    this.customColor = Colors.amber,
    this.player1Name = "Player 1",
    this.player2Name = "Player 2",
  });

  static SettingsState fromStringList(
    List<String>? settings,
  ) {
    if (settings == null) return SettingsState();
    return SettingsState(
      themeMode: ThemeMode.values[int.tryParse(settings[0]) ?? 0],
      colorMode: ColorMode.values[int.tryParse(settings[1]) ?? 0],
      customColor: SettingsState.colors[int.tryParse(settings[2]) ?? 4],
      player1Name: settings[3],
      player2Name: settings[4],
    );
  }

  SettingsState copyWith({
    ThemeMode? themeMode,
    ColorMode? colorMode,
    MaterialColor? customColor,
    String? player1Name,
    String? player2Name,
  }) {
    return SettingsState(
      themeMode: themeMode ?? this.themeMode,
      colorMode: colorMode ?? this.colorMode,
      customColor: customColor ?? this.customColor,
      player1Name: player1Name ?? this.player1Name,
      player2Name: player2Name ?? this.player2Name,
    );
  }

  @override
  String toString() {
    return 'Settings(themeMode: $themeMode, colorMode: $colorMode, customColor: $customColor, player1Name: $player1Name, player2Name: $player2Name)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is SettingsState &&
        other.themeMode == themeMode &&
        other.colorMode == colorMode &&
        other.customColor == customColor &&
        other.player1Name == player1Name &&
        other.player2Name == player2Name;
  }

  @override
  int get hashCode {
    return themeMode.hashCode ^
        colorMode.hashCode ^
        customColor.hashCode ^
        player1Name.hashCode ^
        player2Name.hashCode;
  }
}

enum ColorMode {
  system,
  custom;
}
