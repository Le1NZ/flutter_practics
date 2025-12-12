import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_project/feature/pet_info/cubit/user_info_cubit.dart';

part 'minigame_state.dart';

class MinigameCubit extends Cubit<MinigameState> {
  final UserInfoCubit userInfoCubit;
  Timer? _timer;

  MinigameCubit(this.userInfoCubit) : super(const MinigameState());

  void startGame() {
    emit(const MinigameState(isPlaying: true));
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (state.timeLeft > 0) {
        emit(state.copyWith(timeLeft: state.timeLeft - 1));
      } else {
        _endGame();
      }
    });
  }

  void click() {
    if (state.isPlaying) {
      emit(state.copyWith(score: state.score + 1));
    }
  }

  void _endGame() {
    _timer?.cancel();
    userInfoCubit.earn(state.score);
    emit(state.copyWith(isPlaying: false));
  }

  @override
  Future<void> close() {
    _timer?.cancel();
    return super.close();
  }
}
