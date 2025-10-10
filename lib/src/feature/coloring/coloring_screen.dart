import 'package:flutter/material.dart';

class ColoringScreen extends StatefulWidget {
  const ColoringScreen({super.key});

  @override
  State<StatefulWidget> createState() => _ColoringScreenState();
}

class _ColoringScreenState extends State<ColoringScreen> {
  final _textController = TextEditingController();

  final _items = {"Рыжий", "Серый", "Белый"};

  Widget _itemsList() {
    return Expanded(
      child: ListView.separated(
        itemCount: _items.length,
        itemBuilder: (context, index) {
          final item = _items.elementAt(index);
          return _ColoringItem(
            item: item,
            onTap: () {
              _items.remove(item);
            },
          );
        },
        separatorBuilder: (context, index) {
          return const Divider(
            color: Colors.teal,
            thickness: 2,
            indent: 0,
            endIndent: 0,
          );
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Экран вариантов цветов')),
      body: Padding(padding: const EdgeInsets.all(16), child: _body()),
    );
  }

  Widget _body() {
    return Column(
      children: [
        TextField(
          controller: _textController,
          autofocus: true,
          decoration: const InputDecoration(labelText: 'Новый цвет'),
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

class _ColoringItem extends StatelessWidget {
  final String item;
  final GestureTapCallback onTap;

  const _ColoringItem({required this.item, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      key: ValueKey(item),
      onTap: onTap,
      child: Text(item),
    );
  }
}
