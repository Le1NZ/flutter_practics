import 'package:flutter/material.dart';
import 'package:flutter_project/feature/pet_info/model/pet_info.dart';
import 'package:flutter_project/feature/pet_info/model/pet_state.dart';
import 'package:flutter_project/feature/pet_info/model/user_info.dart';
import 'package:flutter_project/feature/pet_settings/pet_settings.dart';
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
  late PetInfo _petInfo;

  final List<StoreItem> _storeItems = allStoreItems;

  @override
  void initState() {
    super.initState();
    _petInfo = widget._petInfo;
  }

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

  void _onNavigateToSettingsPressed() {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => PetSettingsScreen(
          info: _petInfo,
          state: _petState,
          onSaveClick: _onNameUpdate,
        ),
      ),
    );
  }

  void _onNameUpdate(String name) {
    setState(() {
      _petInfo = _petInfo.copyWith(name: name);
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
        _helpText("Имя питомца: ${_petInfo.name}"),
        _helpText(_petInfo.type),
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
        ElevatedButton(
          onPressed: () => _onNavigateToSettingsPressed(),
          child: const Text('К настройкам'),
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
