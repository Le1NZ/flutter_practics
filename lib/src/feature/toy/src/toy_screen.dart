import 'package:flutter/material.dart';

import 'toys.dart';

class ToyScreen extends StatefulWidget {
  final String initialToy;

  const ToyScreen({super.key, required this.initialToy});

  @override
  State<ToyScreen> createState() => _ToyScreenState();
}

class _ToyScreenState extends State<ToyScreen> {
  late int _currentIndex;

  @override
  void initState() {
    super.initState();
    _currentIndex = toys.indexOf(widget.initialToy);
    if (_currentIndex == -1) {
      _currentIndex = 0;
    }
  }

  void _changeToy() {
    setState(() {
      _currentIndex = (_currentIndex + 1) % toys.length;
    });
  }

  void _onSavePressed() {
    Navigator.pop(context, toys[_currentIndex]);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Выбор игрушки')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Любимая игрушка: ${toys[_currentIndex]}',
              style: const TextStyle(fontSize: 20),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _changeToy,
              child: const Text('Сменить игрушку'),
            ),
            const SizedBox(height: 40),
            ElevatedButton(
              style: ElevatedButton.styleFrom(backgroundColor: Colors.blue),
              onPressed: _onSavePressed,
              child: const Text('Выбрать эту и вернуться'),
            ),
          ],
        ),
      ),
    );
  }
}
