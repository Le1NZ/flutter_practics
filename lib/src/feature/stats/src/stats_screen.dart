import 'package:flutter/material.dart';

class StatsScreen extends StatelessWidget {
  final int hunger;
  final int happiness;
  final String toy;

  const StatsScreen({
    super.key,
    required this.hunger,
    required this.happiness,
    required this.toy,
  });

  void _onBackPressed(BuildContext context) {
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Полная статистика')),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Сводка по питомцу:',
                style: TextStyle(fontSize: 36, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 30),
              Text(
                'Уровень сытости: $hunger / 100',
                style: const TextStyle(fontSize: 20),
              ),
              const SizedBox(height: 15),
              Text(
                'Уровень счастья: $happiness / 100',
                style: const TextStyle(fontSize: 20),
              ),
              const SizedBox(height: 15),
              Text(
                'Любимая игрушка: $toy',
                style: const TextStyle(fontSize: 20),
              ),
              const SizedBox(height: 40),
              Center(
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(backgroundColor: Colors.blue),
                  onPressed: () => {_onBackPressed(context)},
                  child: const Text('Вернуться на главный экран'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
