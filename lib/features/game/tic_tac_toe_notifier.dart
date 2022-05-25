import 'package:flutter_riverpod/flutter_riverpod.dart';

class TicTacToeNotifier extends StateNotifier<TicTacToeState> {
  TicTacToeNotifier()
      : super(TicTacToeState(
            fields: List.filled(9, Player.none),
            currentPlayer: Player.player1));

  void setField(int index) {
    List<Player> fields = state.fields..[index] = state.currentPlayer;
    Player? winner = _isGameOver(fields);
    state = state.copyWith(
        fields: fields,
        currentPlayer: state.currentPlayer == Player.player1
            ? Player.player2
            : Player.player1,
        winner: winner);
  }

  void setCurrentPlayer(Player player) {
    state = state.copyWith(currentPlayer: player);
  }

  void resetGame() {
    state = TicTacToeState(
        fields: List.filled(9, Player.none),
        currentPlayer: state.currentPlayer);
  }

  Player? _isGameOver(List<Player> fields) {
    if (_hasPlayerWon(Player.player1, fields)) {
      return Player.player1;
    }
    if (_hasPlayerWon(Player.player2, fields)) {
      return Player.player2;
    }
    if (!state.fields.contains(Player.none)) {
      return Player.none;
    }
    return null;
  }

  bool _hasPlayerWon(Player player, List<Player> fields) {
    // horizontal
    if ((fields[0] == player && fields[1] == player && fields[2] == player) ||
        (fields[3] == player && fields[4] == player && fields[5] == player) ||
        (fields[6] == player && fields[7] == player && fields[8] == player)) {
      return true;
    }
    // vertical
    if ((fields[0] == player && fields[3] == player && fields[6] == player) ||
        (fields[1] == player && fields[4] == player && fields[7] == player) ||
        (fields[2] == player && fields[5] == player && fields[8] == player)) {
      return true;
    }
    // diagonal
    if ((fields[0] == player && fields[4] == player && fields[8] == player) ||
        (fields[6] == player && fields[4] == player && fields[2] == player)) {
      return true;
    }
    return false;
  }
}

class TicTacToeState {
  final List<Player> fields;
  final Player currentPlayer;
  final Player? winner;
  TicTacToeState(
      {required this.fields, required this.currentPlayer, this.winner})
      : assert(fields.length == 9),
        assert(currentPlayer != Player.none);

  TicTacToeState copyWith({
    List<Player>? fields,
    Player? currentPlayer,
    Player? winner,
  }) {
    if (currentPlayer != null && currentPlayer == Player.none) {
      currentPlayer == Player.player1;
    }
    return TicTacToeState(
      fields: fields ?? this.fields,
      currentPlayer: currentPlayer ?? this.currentPlayer,
      winner: winner ?? this.winner,
    );
  }
}

enum Player {
  none,
  player1,
  player2;
}
