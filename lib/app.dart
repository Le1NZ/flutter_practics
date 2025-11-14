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

  final appRouterProvider = GoRouter(
    initialLocation: '/create-pet',
    routes: [
      GoRoute(
        path: '/create-pet',
        builder: (context, state) => const CreatePetScreen(),
      ),
      GoRoute(
        path: '/pet-info',
        name: 'pet-info',
        builder: (context, state) => const PetInfoContainer(),
      ),
      GoRoute(
        path: '/pet-settings',
        builder: (context, state) => const PetSettingsScreen(),
      ),
      GoRoute(
        path: '/store',
        builder: (context, state) => const StoreScreen(),
      ),
      GoRoute(
        path: '/end-game',
        builder: (context, state) {
          final wasWin = state.extra as bool;
          return EndGameScreen(wasWin: wasWin);
        },
      ),
    ],
  );

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: _appTitle,
      theme: appTheme,
      routerConfig: appRouterProvider,
    );
  }
}
