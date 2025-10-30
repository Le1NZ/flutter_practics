import 'package:flutter/material.dart';
import 'package:flutter_project/feature/create_pet/create_pet.dart';
import 'package:flutter_project/feature/end_game/end_game.dart';
import 'package:flutter_project/feature/pet_info/pet_info.dart';
import 'package:flutter_project/feature/pet_settings/pet_settings.dart';
import 'package:flutter_project/feature/store/store.dart';
import 'package:flutter_project/shared/app_theme.dart';
import 'package:go_router/go_router.dart';

class PetApp extends StatelessWidget {
  final String _appTitle = 'Мой питомец';

  PetApp({super.key});

  final GoRouter appRouter = GoRouter(
    initialLocation: '/create-pet',
    routes: [
      GoRoute(
        path: '/create-pet',
        builder: (context, state) => const CreatePetScreen(),
      ),
      GoRoute(
        path: '/pet-info',
        name: 'pet-info',
        builder: (context, state) {
          final Map<String, dynamic> args = state.extra as Map<String, dynamic>;

          final PetInfo petInfo = args['petInfo'] as PetInfo;

          return PetInfoContainer(petInfo: petInfo);
        },
      ),
      GoRoute(
        path: '/pet-settings',
        builder: (context, state) {
          final Map<String, dynamic> args = state.extra as Map<String, dynamic>;

          final PetInfo info = args['info'] as PetInfo;
          final PetState petState = args['state'] as PetState;
          final Function(String) onSaveClick =
              args['onSaveClick'] as Function(String);

          return PetSettingsScreen(
            info: info,
            state: petState,
            onSaveClick: onSaveClick,
          );
        },
      ),
      GoRoute(
        path: '/store',
        builder: (context, state) {
          final Map<String, dynamic> args = state.extra as Map<String, dynamic>;

          final int availableMoney = args['availableMoney'] as int;
          final List<StoreItem> items = args['items'] as List<StoreItem>;
          final Function(String) onBuyPressed =
              args['onBuyPressed'] as Function(String);

          return StoreScreen(
            availableMoney: availableMoney,
            items: items,
            onBuyPressed: onBuyPressed,
          );
        },
      ),
      GoRoute(
        path: '/end-game',
        builder: (context, state) {
          final Map<String, dynamic> args = state.extra as Map<String, dynamic>;

          final PetInfo petInfo = args['petInfo'] as PetInfo;
          final bool wasWin = args['wasWin'] as bool;

          return EndGameScreen(petInfo: petInfo, wasWin: wasWin);
        },
      ),
    ],
  );

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: _appTitle,
      theme: appTheme,
      routerConfig: appRouter,
    );
  }
}
