import 'package:flutter/material.dart';
import 'package:flutter_project/shared/service/pet_service.dart';
import 'package:flutter_project/shared/service/user_service.dart';
import 'package:flutter_project/shared/service_locator.dart';
import 'package:go_router/go_router.dart';

class EndGameScreen extends StatelessWidget {
  final bool wasWin;

  const EndGameScreen({super.key, required this.wasWin});

  void _onStartNewGameClick(BuildContext context) {
    locator<PetService>().resetState();
    locator<UserService>().resetState();
    context.pushReplacement('/create-pet');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Конец игры")),
      body: Padding(padding: const EdgeInsets.all(16), child: _info(context)),
    );
  }

  Widget _info(BuildContext context) {
    return Center(child: _column(context));
  }

  Widget _column(BuildContext context) {
    final petInfo = locator<PetService>().petInfo;

    return Column(
      children: [
        Text(
          "${petInfo.type} ${petInfo.name}",
          style: const TextStyle(fontSize: 44),
        ),
        Text(
          (wasWin ? "победа" : "проигрыш").toUpperCase(),
          style: const TextStyle(fontSize: 36, fontWeight: FontWeight.bold),
        ),
        ElevatedButton(
          onPressed: () {
            _onStartNewGameClick(context);
          },
          child: const Text("Заново"),
        ),
      ],
    );
  }
}
