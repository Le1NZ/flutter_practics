class PetStatus {
  final int hungry;
  final int happiness;

  PetStatus({required this.hungry, required this.happiness});

  PetStatus copyWith({int? hungry, int? happiness}) {
    return PetStatus(
      hungry: hungry?.clamp(0, 100) ?? this.hungry,
      happiness: happiness?.clamp(0, 100) ?? this.happiness,
    );
  }
}
