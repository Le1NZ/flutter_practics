class PetStatus {
  final int hungry;
  final int happiness;
  final int health;

  PetStatus({
    required this.hungry,
    required this.happiness,
    this.health = 100,
  });

  PetStatus copyWith({int? hungry, int? happiness, int? health}) {
    return PetStatus(
      hungry: hungry?.clamp(0, 100) ?? this.hungry,
      happiness: happiness?.clamp(0, 100) ?? this.happiness,
      health: health?.clamp(0, 100) ?? this.health,
    );
  }
}
