class PetState {

  final int hungry;
  final int happiness;

  PetState({required this.hungry, required this.happiness});

  PetState copyWith({int? hungry, int? happiness}) {
    return PetState(
      hungry: hungry?.clamp(0, 100) ?? this.hungry,
      happiness: happiness?.clamp(0, 100) ?? this.happiness,
    );
  }
}