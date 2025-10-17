import 'package:flutter/material.dart';
import 'package:flutter_project/feature/pet_info/model/pet_info.dart';
import 'package:flutter_project/feature/pet_info/model/pet_state.dart';

import '../model/user_info.dart';

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
    // TODO add navigate to store
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Информация о питомце"),),
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
        _ProgressBar(value: _petState.hungry),
        _helpText("Счастье:"),
        _ProgressBar(value: _petState.happiness),
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

class _ProgressBar extends StatelessWidget {
  final int value;

  const _ProgressBar({required this.value});

  @override
  Widget build(BuildContext context) {
    final doubleValue = value / 100.0;
    final currValue = doubleValue.clamp(0.0, 1.0);
    return LinearProgressIndicator(value: currValue);
  }
}
