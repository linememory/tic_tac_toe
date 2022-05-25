import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final settingsProvider = StateProvider<Settings>((ref) {
  return Settings();
});

class Settings {
  final ThemeMode themeMode;
  final ColorMode colorMode;
  final MaterialColor customColor;
  final String player1Name;
  final String player2Name;
  Settings({
    this.themeMode = ThemeMode.system,
    this.colorMode = ColorMode.system,
    this.customColor = Colors.amber,
    this.player1Name = "Player 1",
    this.player2Name = "Player 2",
  });

  Settings copyWith({
    ThemeMode? themeMode,
    ColorMode? colorMode,
    MaterialColor? customColor,
    String? player1Name,
    String? player2Name,
  }) {
    return Settings(
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

    return other is Settings &&
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
