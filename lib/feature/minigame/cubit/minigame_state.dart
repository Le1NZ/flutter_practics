part of 'minigame_cubit.dart';

class MinigameState {
  final int score;
  final int timeLeft;
  final bool isPlaying;

  const MinigameState({
    this.score = 0,
    this.timeLeft = 10,
    this.isPlaying = false,
  });

  MinigameState copyWith({
    int? score,
    int? timeLeft,
    bool? isPlaying,
  }) {
    return MinigameState(
      score: score ?? this.score,
      timeLeft: timeLeft ?? this.timeLeft,
      isPlaying: isPlaying ?? this.isPlaying,
    );
  }
}

