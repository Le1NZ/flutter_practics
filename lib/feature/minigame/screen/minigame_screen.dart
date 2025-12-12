import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../cubit/minigame_cubit.dart';

class MinigameScreen extends StatelessWidget {
  const MinigameScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Заработать монеты')),
      body: BlocBuilder<MinigameCubit, MinigameState>(
        builder: (context, state) {
          if (!state.isPlaying && state.timeLeft == 0) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('Игра окончена! Вы заработали ${state.score} монет.',
                      style: const TextStyle(fontSize: 20)),
                  const SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () => Navigator.of(context).pop(),
                    child: const Text('Вернуться'),
                  ),
                ],
              ),
            );
          }

          if (!state.isPlaying) {
            return Center(
              child: ElevatedButton(
                onPressed: () => context.read<MinigameCubit>().startGame(),
                child: const Text('Начать игру'),
              ),
            );
          }

          return Stack(
            children: [
              Align(
                alignment: Alignment.topCenter,
                child: Padding(
                  padding: const EdgeInsets.all(32.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("Время: ${state.timeLeft}",
                          style: const TextStyle(fontSize: 24)),
                      Text("Счет: ${state.score}",
                          style: const TextStyle(fontSize: 24)),
                    ],
                  ),
                ),
              ),
              Center(
                child: GestureDetector(
                  onTap: () => context.read<MinigameCubit>().click(),
                  child: Container(
                    width: 200,
                    height: 200,
                    decoration: const BoxDecoration(
                      color: Colors.orange,
                      shape: BoxShape.circle,
                    ),
                    child: const Center(
                      child: Text(
                        "ЖМИ!",
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 32,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
