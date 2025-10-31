class PetInfo {
  final String name;
  final String type;

  PetInfo({required this.name, required this.type});

  PetInfo copyWith({String? name, String? type}) {
    return PetInfo(
      name: name ?? this.name,
      type: type ?? this.type,
    );
  }
}