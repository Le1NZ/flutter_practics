import 'package:flutter/material.dart';

class GameScreen extends StatefulWidget {
  const GameScreen({super.key});

  @override
  State<StatefulWidget> createState() => _GameScreenState();
}

class _GameScreenState extends State<GameScreen> {
  final _textController = TextEditingController();
  final _items = {"Прятки", "Догонялки", "Игра с клубком"};

  Widget _itemsList() {
    return Expanded(
      child: ListView.builder(
        itemCount: _items.length,
        itemBuilder: (context, index) {
          final item = _items.elementAt(index);
          return _GameItem(
            item: item,
            onTap: () {
              _items.remove(item);
            },
          );
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Экран выбора игры')),
      body: Padding(padding: const EdgeInsets.all(16), child: _body()),
    );
  }

  Widget _body() {
    return Column(
      children: [
        TextField(
          controller: _textController,
          autofocus: true,
          decoration: const InputDecoration(labelText: 'Новая игра'),
        ),
        const SizedBox(height: 16),
        _addButton(),
        const SizedBox(height: 16),
        _removeButton(),
        const SizedBox(height: 32),
        _itemsList(),
      ],
    );
  }

  Widget _addButton() {
    return ElevatedButton(
      onPressed: () {
        setState(() {
          _items.add(_textController.text);
        });
      },
      child: const Text('Добавить'),
    );
  }

  Widget _removeButton() {
    return ElevatedButton(
      onPressed: () {
        setState(() {
          _items.remove(_textController.text);
        });
      },
      child: const Text('Удалить'),
    );
  }
}

class _GameItem extends StatelessWidget {
  final String item;
  final GestureTapCallback onTap;

  const _GameItem({required this.item, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      key: ValueKey(item),
      onTap: onTap,
      child: Text(item),
    );
  }
}
