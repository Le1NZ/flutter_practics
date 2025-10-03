import 'package:flutter/material.dart';

class FeedScreen extends StatefulWidget {
  final int initialHunger;

  const FeedScreen({super.key, required this.initialHunger});

  @override
  State<FeedScreen> createState() => _FeedScreenState();
}

class _FeedScreenState extends State<FeedScreen> {
  late int _currentHunger;

  @override
  void initState() {
    super.initState();
    _currentHunger = widget.initialHunger;
  }

  void _increaseHunger() {
    setState(() {
      if (_currentHunger <= 90) {
        _currentHunger += 10;
      } else {
        _currentHunger = 100;
      }
    });
  }

  void _decreaseHunger() {
    setState(() {
      if (_currentHunger >= 10) {
        _currentHunger -= 10;
      } else {
        _currentHunger = 0;
      }
    });
  }

  void _onSavePressed() {
    Navigator.pop(context, _currentHunger);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Экран кормления'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Текущая сытость: $_currentHunger'),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _increaseHunger,
              child: const Text('Покормить (+10)'),
            ),
            const SizedBox(height: 10),
            ElevatedButton(
              onPressed: _decreaseHunger,
              child: const Text('Пусть поголодает (-10)'),
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
