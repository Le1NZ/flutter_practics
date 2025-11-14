import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_project/feature/pet_info/cubit/user_info_cubit.dart';
import 'package:flutter_project/feature/pet_info/model/pet_info.dart';
import 'package:flutter_project/feature/pet_info/model/pet_status.dart';

class PetState {
  final PetInfo? petInfo;
  final PetStatus? petStatus;

  PetState({this.petInfo, this.petStatus});

  PetState copyWith({PetInfo? petInfo, PetStatus? petStatus}) {
    return PetState(
      petInfo: petInfo ?? this.petInfo,
      petStatus: petStatus ?? this.petStatus,
    );
  }
}

class PetCubit extends Cubit<PetState> {
  final UserInfoCubit _userInfoCubit;

  PetCubit(this._userInfoCubit) : super(PetState());

  void createPet({required String name, required String type}) {
    final petInfo = PetInfo(name: name, type: type);
    final petStatus = PetStatus(hungry: 50, happiness: 50);
    emit(PetState(petInfo: petInfo, petStatus: petStatus));
  }

  void updateName(String name) {
    if (state.petInfo != null) {
      emit(state.copyWith(petInfo: state.petInfo!.copyWith(name: name)));
    }
  }

  void feed() {
    if (state.petStatus != null) {
      _userInfoCubit.spend(5);
      emit(
        state.copyWith(
          petStatus: state.petStatus!.copyWith(
            hungry: state.petStatus!.hungry + 15,
            happiness: state.petStatus!.happiness - 5,
          ),
        ),
      );
    }
  }

  void play() {
    if (state.petStatus != null) {
      _userInfoCubit.earn(10);
      emit(
        state.copyWith(
          petStatus: state.petStatus!.copyWith(
            happiness: state.petStatus!.happiness + 10,
            hungry: state.petStatus!.hungry - 7,
          ),
        ),
      );
    }
  }

  void reset() {
    emit(PetState());
  }
}
