import 'package:flutter/material.dart';

import 'package:flutter_project/src/feature/game/game_screen.dart';

class PlayScreen extends StatefulWidget {
  final int initialHappiness;

  const PlayScreen({super.key, required this.initialHappiness});

  @override
  State<PlayScreen> createState() => _PlayScreenState();
}

class _PlayScreenState extends State<PlayScreen> {
  late int _currentHappiness;

  @override
  void initState() {
    super.initState();
    _currentHappiness = widget.initialHappiness;
  }

  void _increaseHappiness() {
    setState(() {
      _currentHappiness = (_currentHappiness + 10).clamp(0, 100);
    });
  }

  void _decreaseHappiness() {
    setState(() {
      _currentHappiness = (_currentHappiness - 10).clamp(0, 100);
    });
  }

  void _onSavePressed() {
    Navigator.pop(context, _currentHappiness);
  }

  void _onGameListPressed() {
    Navigator.push(context, MaterialPageRoute(builder: (context) => GameScreen()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Экран игры'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Текущее счастье: $_currentHappiness'),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _increaseHappiness,
              child: const Text('Поиграть (+10)'),
            ),
            const SizedBox(height: 10),
            ElevatedButton(
              onPressed: _decreaseHappiness,
              child: const Text('Загрустить (-10)'),
            ),
            const SizedBox(height: 10),
            ElevatedButton(
              onPressed: _onGameListPressed,
              child: const Text('Виды игр'),
            ),
            const SizedBox(height: 40),
            ElevatedButton(
              style: ElevatedButton.styleFrom(backgroundColor: Colors.blue),
              onPressed: _onSavePressed,
              child: const Text('Сохранить и вернуться'),
            ),
          ],
        ),
      ),
    );
  }
}
