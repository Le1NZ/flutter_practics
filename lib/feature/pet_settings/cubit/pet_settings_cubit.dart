import 'package:flutter_bloc/flutter_bloc.dart';

import '../../pet_info/cubit/pet_cubit.dart';

class PetSettingsState {
  final String petName;

  PetSettingsState({required this.petName});

  PetSettingsState copyWith({String? petName}) {
    return PetSettingsState(petName: petName ?? this.petName);
  }
}

class PetSettingsCubit extends Cubit<PetSettingsState> {
  final PetCubit _petCubit;

  PetSettingsCubit(this._petCubit)
    : super(PetSettingsState(petName: _petCubit.state.petInfo?.name ?? ''));

  void setPetName(String name) {
    emit(state.copyWith(petName: name));
  }

  bool savePetName() {
    if (state.petName.isEmpty) {
      return false;
    }
    _petCubit.updateName(state.petName);
    return true;
  }
}
