import 'package:flutter/material.dart';
import 'package:flutter_project/shared/service/pet_service.dart';
import 'package:flutter_project/shared/service/user_service.dart';
import 'package:flutter_project/shared/service_locator.dart';
import 'package:go_router/go_router.dart';

import '../../../shared/components/progress_bar.dart';

class PetInfoContainer extends StatefulWidget {
  const PetInfoContainer({super.key});

  @override
  State<PetInfoContainer> createState() => _PetInfoContainerState();
}

class _PetInfoContainerState extends State<PetInfoContainer> {
  final _petService = locator<PetService>();
  final _userService = locator<UserService>();

  void _checkCondition(BuildContext context) {
    final hungry = _petService.petStatus.hungry;
    final happiness = _petService.petStatus.happiness;
    final allBought = _userService.storeItems
        .where((item) => !item.wasBought)
        .isEmpty;

    if (hungry <= 0 || happiness <= 0 || _userService.userInfo.money <= 0) {
      _onNavigateToEndGame(context, false);
    } else if (allBought && (hungry >= 100 || happiness >= 100)) {
      _onNavigateToEndGame(context, true);
    }
  }

  void _onNavigateToEndGame(BuildContext context, bool wasWin) {
    context.pushReplacement('/end-game', extra: wasWin);
  }

  void _onNavigateToStorePressed(BuildContext context) {
    context.push('/store').then((_) => setState(() {}));
  }

  void _onNavigateToSettingsPressed(BuildContext context) {
    context.push('/pet-settings').then((_) => setState(() {}));
  }

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback(
      (_) => _checkCondition(context),
    );

    return Scaffold(
      appBar: AppBar(title: const Text("Информация о питомце")),
      body: _screenColumn(context),
    );
  }

  Widget _screenColumn(BuildContext context) {
    return Column(
      spacing: 32,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        _helpText("Монеты: ${_userService.userInfo.money}"),
        Padding(
          padding: const EdgeInsets.all(16),
          child: Center(child: _infoColumn(context)),
        ),
      ],
    );
  }

  Widget _infoColumn(BuildContext context) {
    return Column(
      spacing: 16,
      children: [
        _helpText("Имя питомца: ${_petService.petInfo.name}"),
        _helpText(_petService.petInfo.type),
        _helpText("Сытость:"),
        ProgressBar(value: _petService.petStatus.hungry),
        _helpText("Счастье:"),
        ProgressBar(value: _petService.petStatus.happiness),
        ElevatedButton(
          onPressed: () {
            setState(() {
              _petService.feed();
            });
          },
          child: const Text('Покормить'),
        ),
        ElevatedButton(
          onPressed: () {
            setState(() {
              _petService.play();
            });
          },
          child: const Text('Поиграть'),
        ),
        const SizedBox(height: 40),
        ElevatedButton(
          onPressed: () => _onNavigateToStorePressed(context),
          child: const Text('В магазин'),
        ),
        ElevatedButton(
          onPressed: () => _onNavigateToSettingsPressed(context),
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
