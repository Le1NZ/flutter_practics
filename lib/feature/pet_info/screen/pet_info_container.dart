import 'package:flutter/material.dart';
import 'package:flutter_project/feature/pet_info/model/pet_info.dart';
import 'package:flutter_project/feature/pet_info/model/pet_state.dart';
import 'package:flutter_project/feature/pet_info/model/user_info.dart';
import 'package:flutter_project/feature/store/store.dart';

import '../../../shared/components/progress_bar.dart';

class PetInfoContainer extends StatefulWidget {
  final PetInfo _petInfo;

  const PetInfoContainer({super.key, required PetInfo petInfo})
    : _petInfo = petInfo;

  @override
  State<StatefulWidget> createState() => _PetInfoContainerState();
}

class _PetInfoContainerState extends State<PetInfoContainer> {
  UserInfo _userInfo = UserInfo(money: 50);
  PetState _petState = PetState(hungry: 50, happiness: 50);
  final List<StoreItem> _storeItems = [
    StoreItem(id: '1', name: 'Обычный корм', price: 10, wasBought: false),
    StoreItem(id: '2', name: 'Премиум-консервы', price: 25, wasBought: false),
    StoreItem(
      id: '3',
      name: 'Хрустящее лакомство',
      price: 15,
      wasBought: false,
    ),
    StoreItem(id: '4', name: 'Красный мячик', price: 20, wasBought: false),
    StoreItem(id: '5', name: 'Заводная мышка', price: 35, wasBought: false),
    StoreItem(id: '6', name: 'Удобная лежанка', price: 100, wasBought: false),
    StoreItem(
      id: '7',
      name: 'Энергетик для питомца',
      price: 50,
      wasBought: false,
    ),
    StoreItem(id: '8', name: 'Стильный ошейник', price: 75, wasBought: false),
    StoreItem(id: '9', name: 'Забавный бантик', price: 60, wasBought: false),
    StoreItem(id: '10', name: 'Пищалка', price: 150, wasBought: false),
  ];

  void _onFeedPressed() {
    setState(() {
      _petState = _petState.copyWith(
        hungry: _petState.hungry + 10,
        happiness: _petState.happiness - 5,
      );

      _userInfo = _userInfo.copyWith(money: _userInfo.money - 10);
    });
  }

  void _onPlayPressed() {
    setState(() {
      _petState = _petState.copyWith(
        hungry: _petState.hungry - 7,
        happiness: _petState.happiness + 5,
      );

      _userInfo = _userInfo.copyWith(money: _userInfo.money + 15);
    });
  }

  void _onNavigateToStorePressed() {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => StoreScreen(
          availableMoney: _userInfo.money,
          items: _storeItems,
          onBuyPressed: _onBuyItem,
        ),
      ),
    );
  }

  void _onBuyItem(String id) {
    setState(() {
      final item = _storeItems.firstWhere((item) => item.id == id);
      final itemIndex = _storeItems.indexOf(item);
      final newItem = item.copyWith(wasBought: true);
      _storeItems[itemIndex] = newItem;
      _userInfo = _userInfo.copyWith(money: _userInfo.money - item.price);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Информация о питомце")),
      body: _screenColumn(),
    );
  }

  Widget _screenColumn() {
    return Column(
      spacing: 32,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        _helpText("Монеты: ${_userInfo.money}"),
        Padding(
          padding: EdgeInsets.all(16),
          child: Center(child: _infoColumn()),
        ),
      ],
    );
  }

  Widget _infoColumn() {
    return Column(
      spacing: 16,
      children: [
        _helpText("Имя питомца: ${widget._petInfo.name}"),
        _helpText(widget._petInfo.type),
        _helpText("Сытость:"),
        ProgressBar(value: _petState.hungry),
        _helpText("Счастье:"),
        ProgressBar(value: _petState.happiness),
        ElevatedButton(
          onPressed: () => _onFeedPressed(),
          child: const Text('Покормить'),
        ),
        ElevatedButton(
          onPressed: () => _onPlayPressed(),
          child: const Text('Поиграть'),
        ),
        SizedBox(height: 40),
        ElevatedButton(
          onPressed: () => _onNavigateToStorePressed(),
          child: const Text('В магазин'),
        ),
      ],
    );
  }

  Widget _helpText(String text) {
    return Text(
      text,
      style: const TextStyle(fontSize: 16.0, color: Colors.black),
    );
  }
}
