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
    final petStatus = PetStatus(hungry: 50, happiness: 50, health: 100);
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
      final newHealth = (state.petStatus!.health + 2).clamp(0, 100);
      
      emit(
        state.copyWith(
          petStatus: state.petStatus!.copyWith(
            hungry: state.petStatus!.hungry + 15,
            happiness: state.petStatus!.happiness - 5,
            health: newHealth,
          ),
        ),
      );
      
      degradeHealth();
    }
  }

  void play() {
    if (state.petStatus != null) {
      int healthChange = -5;
      
      if (state.petStatus!.hungry < 30) {
        healthChange = -15;
      }

      final newHealth = (state.petStatus!.health + healthChange).clamp(0, 100);

      emit(
        state.copyWith(
          petStatus: state.petStatus!.copyWith(
            happiness: state.petStatus!.happiness + 15,
            hungry: state.petStatus!.hungry - 10,
            health: newHealth,
          ),
        ),
      );

      degradeHealth();
    }
  }

  void heal(int amount) {
    if (state.petStatus != null) {
      emit(state.copyWith(
        petStatus: state.petStatus!.copyWith(
          health: state.petStatus!.health + amount,
        ),
      ));
    }
  }

  void degradeHealth() {
     if (state.petStatus != null) {
      int damage = 0;
      if (state.petStatus!.hungry < 20) damage += 5;
      if (state.petStatus!.happiness < 20) damage += 5;
      
      if (damage > 0) {
         final newHealth = (state.petStatus!.health - damage).clamp(0, 100);
         emit(state.copyWith(
          petStatus: state.petStatus!.copyWith(health: newHealth)
         ));
      }
    }
  }

  void reset() {
    emit(PetState());
  }
}
