import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_project/feature/pet_info/cubit/user_info_cubit.dart';

import '../../pet_info/cubit/pet_cubit.dart';

class EndGameState {
  final bool wasWin;

  EndGameState({required this.wasWin});
}

class EndGameCubit extends Cubit<EndGameState> {
  final PetCubit _petCubit;
  final UserInfoCubit _userInfoCubit;

  EndGameCubit(this._petCubit, this._userInfoCubit, bool wasWin)
    : super(EndGameState(wasWin: wasWin));

  void restartGame() {
    _petCubit.reset();
    _userInfoCubit.reset();
  }
}
