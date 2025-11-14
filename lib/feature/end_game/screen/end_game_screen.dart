import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_project/feature/end_game/cubit/end_game_cubit.dart';
import 'package:flutter_project/feature/store/cubit/store_cubit.dart';
import 'package:flutter_project/feature/pet_info/cubit/user_info_cubit.dart';
import 'package:go_router/go_router.dart';

import '../../pet_info/cubit/pet_cubit.dart';

class EndGameScreen extends StatelessWidget {
  final bool wasWin;

  const EndGameScreen({super.key, required this.wasWin});

  void _onStartNewGameClick(BuildContext context) {
    context.read<EndGameCubit>().restartGame();
    context.read<StoreCubit>().reset();
    context.pushReplacement('/create-pet');
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => EndGameCubit(
        context.read<PetCubit>(),
        context.read<UserInfoCubit>(),
        wasWin,
      ),
      child: Scaffold(
        appBar: AppBar(title: const Text("Конец игры")),
        body: Padding(
          padding: const EdgeInsets.all(16),
          child: BlocBuilder<EndGameCubit, EndGameState>(
            builder: (context, state) {
              return _info(context, state);
            },
          ),
        ),
      ),
    );
  }

  Widget _info(BuildContext context, EndGameState state) {
    return Center(child: _column(context, state));
  }

  Widget _column(BuildContext context, EndGameState state) {
    final petInfo = context.read<PetCubit>().state.petInfo;
    return Column(
      children: [
        if (petInfo != null)
          Text(
            "${petInfo.type} ${petInfo.name}",
            style: const TextStyle(fontSize: 44),
          ),
        Text(
          (state.wasWin ? "победа" : "проигрыш").toUpperCase(),
          style: const TextStyle(fontSize: 36, fontWeight: FontWeight.bold),
        ),
        ElevatedButton(
          onPressed: () => _onStartNewGameClick(context),
          child: const Text("Заново"),
        ),
      ],
    );
  }
}
