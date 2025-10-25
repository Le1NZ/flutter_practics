class PetType {
  final String name;
  final String imageUrl;

  PetType({required this.name, required this.imageUrl});
}

final allPetTypes = [
  PetType(name: 'кошка', imageUrl: 'https://ir.ozone.ru/s3/multimedia-1-1/w1200/7029061453.jpg'),
  PetType(name: 'собака', imageUrl: 'https://i.ytimg.com/vi/b0m6fGu4Bl0/maxresdefault.jpg'),
  PetType(name: 'хомяк', imageUrl: 'https://png.pngtree.com/thumb_back/fh260/background/20230516/pngtree-hamster-sitting-on-wooden-surface-with-eyes-staring-at-the-camera-image_2568960.jpg'),
];