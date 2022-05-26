import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tic_tac_toe/features/core/providers/settings_provider.dart';

import '../../game/providers/tic_tac_toe_provider.dart';

final statisticsProvider =
    StateNotifierProvider<StatisticsNotifier, StatisticsState>((ref) {
  final pref = ref.watch(sharedPreferences).maybeWhen(
        data: (value) => value,
        orElse: () => null,
      );
  return StatisticsNotifier(pref);
});

class StatisticsNotifier extends StateNotifier<StatisticsState> {
  StatisticsNotifier(this.sharedPreferences)
      : super(
          StatisticsState(
              draw: sharedPreferences?.getInt(_drawKey) ?? 0,
              player1: sharedPreferences?.getInt(_player1Key) ?? 0,
              player2: sharedPreferences?.getInt(_player2Key) ?? 0),
        );

  final SharedPreferences? sharedPreferences;

  static const String _drawKey = 'draw_count';
  static const String _player1Key = 'player1_count';
  static const String _player2Key = 'player2_count';

  void increment(Player player) {
    switch (player) {
      case Player.none:
        state = state.copyWith(draw: state.draw + 1);
        sharedPreferences?.setInt(_drawKey, state.draw);
        break;
      case Player.player1:
        state = state.copyWith(player1: state.player1 + 1);
        sharedPreferences?.setInt(_player1Key, state.player1);
        break;
      case Player.player2:
        state = state.copyWith(player2: state.player2 + 1);
        sharedPreferences?.setInt(_player2Key, state.player2);
        break;
      default:
    }
  }

  void reset() {
    state = StatisticsState();
    sharedPreferences?.remove(_drawKey);
    sharedPreferences?.remove(_player1Key);
    sharedPreferences?.remove(_player2Key);
  }
}

class StatisticsState {
  int player1;
  int player2;
  int draw;
  StatisticsState({
    this.player1 = 0,
    this.player2 = 0,
    this.draw = 0,
  });

  StatisticsState copyWith({
    int? player1,
    int? player2,
    int? draw,
  }) {
    return StatisticsState(
      player1: player1 ?? this.player1,
      player2: player2 ?? this.player2,
      draw: draw ?? this.draw,
    );
  }

  @override
  String toString() =>
      'StatisticsState(player1: $player1, player2: $player2, draw: $draw)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is StatisticsState &&
        other.player1 == player1 &&
        other.player2 == player2 &&
        other.draw == draw;
  }

  @override
  int get hashCode => player1.hashCode ^ player2.hashCode ^ draw.hashCode;
}
