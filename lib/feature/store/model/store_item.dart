class StoreItem {
  final String id;
  final String name;
  final int price;
  final bool wasBought;
  final String imageUrl;

  StoreItem({
    required this.id,
    required this.name,
    required this.price,
    required this.wasBought,
    required this.imageUrl,
  });

  StoreItem copyWith({
    String? name,
    int? price,
    bool? wasBought,
    String? imageUrl,
  }) {
    return StoreItem(
      id: id,
      name: name ?? this.name,
      price: price ?? this.price,
      wasBought: wasBought ?? this.wasBought,
      imageUrl: imageUrl ?? this.imageUrl,
    );
  }
}

final allStoreItems = [
  StoreItem(
    id: '1',
    name: 'Обычный корм',
    price: 10,
    wasBought: false,
    imageUrl:
        'https://avatars.mds.yandex.net/get-mpic/5236119/img_id293966569248481634.jpeg/orig',
  ),
  StoreItem(
    id: '2',
    name: 'Премиум-консервы',
    price: 25,
    wasBought: false,
    imageUrl: 'https://cdn1.ozone.ru/s3/multimedia-f/6013992459.jpg',
  ),
  StoreItem(
    id: '3',
    name: 'Хрустящее лакомство',
    price: 15,
    wasBought: false,
    imageUrl:
        'https://tsx.x5static.net/i/800x800-fit/xdelivery/files/be/d4/d4aecde7e9dfbcb6f0e04fc8855e.jpg',
  ),
  StoreItem(
    id: '4',
    name: 'Красный мячик',
    price: 20,
    wasBought: false,
    imageUrl:
        'https://avatars.mds.yandex.net/get-mpic/3612791/img_id2994291974558481278.jpeg/orig',
  ),
  StoreItem(
    id: '5',
    name: 'Заводная мышка',
    price: 35,
    wasBought: false,
    imageUrl:
        'https://avatars.mds.yandex.net/get-mpic/7981123/img_id2863319185079573207.jpeg/orig',
  ),
  StoreItem(
    id: '6',
    name: 'Удобная лежанка',
    price: 100,
    wasBought: false,
    imageUrl:
        'https://avatars.mds.yandex.net/get-mpic/7689172/img_id2952647576130407360.jpeg/orig',
  ),
  StoreItem(
    id: '7',
    name: 'Стильный ошейник',
    price: 75,
    wasBought: false,
    imageUrl:
        'https://avatars.mds.yandex.net/get-mpic/4219717/img_id7295358210029090513.jpeg/orig',
  ),
  StoreItem(
    id: '8',
    name: 'Забавный бантик',
    price: 60,
    wasBought: false,
    imageUrl:
        'https://cdn1.ozone.ru/s3/multimedia-1-r/7085987415.jpg',
  ),
];
