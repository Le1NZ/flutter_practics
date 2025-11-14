import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_project/feature/store/cubit/store_cubit.dart';
import 'package:flutter_project/feature/pet_info/cubit/user_info_cubit.dart';
import 'package:go_router/go_router.dart';

import '../../../shared/components/progress_bar.dart';
import '../cubit/pet_cubit.dart';
import '../model/user_info.dart';

class PetInfoContainer extends StatelessWidget {
  const PetInfoContainer({super.key});

  void _onNavigateToEndGame(BuildContext context, bool wasWin) {
    context.pushReplacement('/end-game', extra: wasWin);
  }

  void _onNavigateToStorePressed(BuildContext context) {
    context.push('/store');
  }

  void _onNavigateToSettingsPressed(BuildContext context) {
    context.push('/pet-settings');
  }

  void _checkGameState(BuildContext context) {
    final petState = context.read<PetCubit>().state;
    final userInfoState = context.read<UserInfoCubit>().state;
    final storeState = context.read<StoreCubit>().state;

    if (petState.petStatus == null) return;

    // Lose condition
    if (petState.petStatus!.hungry <= 0 ||
        petState.petStatus!.happiness <= 0 ||
        userInfoState.money <= 0) {
      _onNavigateToEndGame(context, false);
      return;
    }

    // Win condition
    final allItemsBought = storeState.items.every((item) => item.wasBought);
    if (allItemsBought &&
        petState.petStatus!.hungry >= 90 &&
        petState.petStatus!.happiness >= 90) {
      _onNavigateToEndGame(context, true);
    }
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocListener(
      listeners: [
        BlocListener<PetCubit, PetState>(
          listener: (context, state) => _checkGameState(context),
        ),
        BlocListener<UserInfoCubit, UserInfo>(
          listener: (context, state) => _checkGameState(context),
        ),
        BlocListener<StoreCubit, StoreState>(
          listener: (context, state) => _checkGameState(context),
        ),
      ],
      child: Scaffold(
        appBar: AppBar(title: const Text("Информация о питомце")),
        body: BlocBuilder<PetCubit, PetState>(
          builder: (context, petState) {
            return BlocBuilder<UserInfoCubit, UserInfo>(
              builder: (context, userInfoState) {
                if (petState.petInfo == null || petState.petStatus == null) {
                  return const Center(child: CircularProgressIndicator());
                }
                return _screenColumn(context, petState, userInfoState);
              },
            );
          },
        ),
      ),
    );
  }

  Widget _screenColumn(
    BuildContext context,
    PetState petState,
    UserInfo userInfoState,
  ) {
    return Column(
      spacing: 32,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        _helpText("Монеты: ${userInfoState.money}"),
        Padding(
          padding: const EdgeInsets.all(16),
          child: Center(child: _infoColumn(context, petState)),
        ),
      ],
    );
  }

  Widget _infoColumn(BuildContext context, PetState petState) {
    return Column(
      spacing: 16,
      children: [
        _helpText("Имя питомца: ${petState.petInfo!.name}"),
        _helpText(petState.petInfo!.type),
        _helpText("Сытость:"),
        ProgressBar(value: petState.petStatus!.hungry),
        _helpText("Счастье:"),
        ProgressBar(value: petState.petStatus!.happiness),
        ElevatedButton(
          onPressed: () => context.read<PetCubit>().feed(),
          child: const Text('Покормить'),
        ),
        ElevatedButton(
          onPressed: () => context.read<PetCubit>().play(),
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
