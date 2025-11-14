import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_project/feature/create_pet/model/pet_type.dart';

class CreatePetState {
  final List<PetType> petTypes;
  final int selectedPetIndex;
  final String petName;

  CreatePetState({
    required this.petTypes,
    this.selectedPetIndex = 0,
    this.petName = '',
  });

  CreatePetState copyWith({
    List<PetType>? petTypes,
    int? selectedPetIndex,
    String? petName,
  }) {
    return CreatePetState(
      petTypes: petTypes ?? this.petTypes,
      selectedPetIndex: selectedPetIndex ?? this.selectedPetIndex,
      petName: petName ?? this.petName,
    );
  }
}

class CreatePetCubit extends Cubit<CreatePetState> {
  CreatePetCubit() : super(CreatePetState(petTypes: allPetTypes));

  void selectPetType(int index) {
    emit(state.copyWith(selectedPetIndex: index));
  }

  void setPetName(String name) {
    emit(state.copyWith(petName: name));
  }
}
