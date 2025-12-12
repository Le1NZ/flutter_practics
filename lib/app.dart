import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_project/feature/create_pet/create_pet.dart';
import 'package:flutter_project/feature/end_game/end_game.dart';
import 'package:flutter_project/feature/pet_info/cubit/user_info_cubit.dart';
import 'package:flutter_project/feature/pet_info/pet_info.dart';
import 'package:flutter_project/feature/pet_settings/pet_settings.dart';
import 'package:flutter_project/feature/store/cubit/store_cubit.dart';
import 'package:flutter_project/feature/store/store.dart';
import 'package:flutter_project/feature/minigame/minigame.dart';
import 'package:flutter_project/feature/vet/vet.dart';
import 'package:flutter_project/feature/tasks/tasks.dart';
import 'package:flutter_project/shared/app_theme.dart';
import 'package:go_router/go_router.dart';

import 'feature/pet_info/cubit/pet_cubit.dart';

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
      GoRoute(path: '/store', builder: (context, state) => const StoreScreen()),
      GoRoute(path: '/vet', builder: (context, state) => const VetScreen()),
      GoRoute(path: '/tasks', builder: (context, state) => const TasksScreen()),
      GoRoute(
        path: '/minigame',
        builder: (context, state) => BlocProvider(
          create: (context) => MinigameCubit(context.read<UserInfoCubit>()),
          child: const MinigameScreen(),
        ),
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
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => UserInfoCubit()),
        BlocProvider(
          create: (context) => PetCubit(context.read<UserInfoCubit>()),
        ),
        BlocProvider(
          create: (context) => VetCubit(
            userInfoCubit: context.read<UserInfoCubit>(),
            petCubit: context.read<PetCubit>(),
          ),
        ),
        BlocProvider(
          create: (context) => TasksCubit(context.read<UserInfoCubit>()),
        ),
        BlocProvider(
          create: (context) => StoreCubit(context.read<UserInfoCubit>()),
        ),
      ],
      child: MaterialApp.router(
        title: _appTitle,
        theme: appTheme,
        routerConfig: appRouterProvider,
      ),
    );
  }
}
