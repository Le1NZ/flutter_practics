import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_project/feature/pet_info/cubit/pet_cubit.dart';
import 'package:flutter_project/feature/pet_info/cubit/user_info_cubit.dart';

part 'vet_state.dart';

class VetCubit extends Cubit<VetState> {
  final UserInfoCubit userInfoCubit;
  final PetCubit petCubit;

  VetCubit({required this.userInfoCubit, required this.petCubit})
      : super(const VetState());

  void checkHealth() {
    final health = petCubit.state.petStatus?.health ?? 0;
    if (health >= 100) {
      emit(const VetState(message: 'Ваш питомец полностью здоров!'));
    } else if (health > 50) {
      emit(const VetState(message: 'Питомец чувствует себя неплохо, но витамины не помешают.'));
    } else {
      emit(const VetState(message: 'Питомец болен! Срочно нужно лечение!'));
    }
  }

  void buyVitamins() {
    if (userInfoCubit.state.money >= 20) {
      userInfoCubit.spend(20);
      petCubit.heal(10);
      emit(const VetState(message: 'Вы купили витамины. Здоровье +10'));
    } else {
      emit(const VetState(message: 'Недостаточно денег на витамины (20 монет)'));
    }
  }

  void buyMedicine() {
    if (userInfoCubit.state.money >= 50) {
      userInfoCubit.spend(50);
      petCubit.heal(30);
      emit(const VetState(message: 'Лекарство помогло! Здоровье +30'));
    } else {
      emit(const VetState(message: 'Недостаточно денег на лекарство (50 монет)'));
    }
  }

  void fullCheckup() {
     if (userInfoCubit.state.money >= 100) {
      userInfoCubit.spend(100);
      petCubit.heal(100);
      emit(const VetState(message: 'Полный осмотр и лечение проведены! Питомец здоров.'));
    } else {
      emit(const VetState(message: 'Недостаточно денег на полный осмотр (100 монет)'));
    }
  }
}
