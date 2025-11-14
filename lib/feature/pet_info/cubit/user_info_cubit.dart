import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_project/feature/pet_info/model/user_info.dart';

class UserInfoCubit extends Cubit<UserInfo> {
  UserInfoCubit() : super(UserInfo(money: 100));

  void spend(int amount) {
    if (state.money >= amount) {
      emit(state.copyWith(money: state.money - amount));
    }
  }

  void earn(int amount) {
    emit(state.copyWith(money: state.money + amount));
  }

  void reset() {
    emit(UserInfo(money: 100));
  }
}
