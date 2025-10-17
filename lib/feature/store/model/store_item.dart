class StoreItem {
  final String id;
  final String name;
  final int price;
  final bool wasBought;

  StoreItem({
    required this.id,
    required this.name,
    required this.price,
    required this.wasBought,
  });

  StoreItem copyWith({String? name, int? price, bool? wasBought}) {
    return StoreItem(
      id : id,
      name: name ?? this.name,
      price: price ?? this.price,
      wasBought: wasBought ?? this.wasBought,
    );
  }
}
