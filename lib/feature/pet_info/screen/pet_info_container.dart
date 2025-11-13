import 'package:flutter/material.dart';
import 'package:flutter_project/shared/di/pet_state.dart';
import 'package:flutter_project/shared/di/user_state.dart';
import 'package:go_router/go_router.dart';

import '../../../shared/components/progress_bar.dart';

class PetInfoContainer extends StatelessWidget {
  const PetInfoContainer({super.key});

  void checkCondition(BuildContext context) {
    final petState = PetState.of(context);
    final userState = UserState.of(context);

    final hungry = petState.petStatus.hungry;
    final happiness = petState.petStatus.happiness;
    final allBought = userState.storeItems
        .where((item) => !item.wasBought)
        .isEmpty;

    if (hungry <= 0 || happiness <= 0 || userState.userInfo.money <= 0) {
      _onNavigateToEndGame(context, false);
    } else if (allBought && (hungry >= 100 || happiness >= 100)) {
      _onNavigateToEndGame(context, true);
    }
  }

  void _onNavigateToEndGame(BuildContext context, bool wasWin) {
    context.pushReplacement('/end-game', extra: wasWin);
  }

  void _onNavigateToStorePressed(BuildContext context) {
    context.push('/store');
  }

  void _onNavigateToSettingsPressed(BuildContext context) {
    context.push('/pet-settings');
  }

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback(
      (_) => checkCondition(context),
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
        _helpText("Монеты: ${UserState.of(context).userInfo.money}"),
        Padding(
          padding: const EdgeInsets.all(16),
          child: Center(child: _infoColumn(context)),
        ),
      ],
    );
  }

  Widget _infoColumn(BuildContext context) {
    final petState = PetState.of(context);
    return Column(
      spacing: 16,
      children: [
        _helpText("Имя питомца: ${petState.petInfo.name}"),
        _helpText(petState.petInfo.type),
        _helpText("Сытость:"),
        ProgressBar(value: petState.petStatus.hungry),
        _helpText("Счастье:"),
        ProgressBar(value: petState.petStatus.happiness),
        ElevatedButton(
          onPressed: petState.onFeed,
          child: const Text('Покормить'),
        ),
        ElevatedButton(
          onPressed: petState.onPlay,
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
