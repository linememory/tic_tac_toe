import 'dart:convert';

import 'package:flutter_riverpod/flutter_riverpod.dart';

final statisticsProvider = StateProvider<StatisticsState>((ref) {
  return StatisticsState(player1: 0, player2: 0, draw: 0);
});

class StatisticsState {
  int player1;
  int player2;
  int draw;
  StatisticsState({
    required this.player1,
    required this.player2,
    required this.draw,
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

  Map<String, dynamic> toMap() {
    return {
      'player1': player1,
      'player2': player2,
      'draw': draw,
    };
  }

  factory StatisticsState.fromMap(Map<String, dynamic> map) {
    return StatisticsState(
      player1: map['player1']?.toInt() ?? 0,
      player2: map['player2']?.toInt() ?? 0,
      draw: map['draw']?.toInt() ?? 0,
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

  String toJson() => json.encode(toMap());

  factory StatisticsState.fromJson(String source) =>
      StatisticsState.fromMap(json.decode(source));
}
