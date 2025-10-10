import 'package:flutter/material.dart';

class FoodScreen extends StatefulWidget {
  const FoodScreen({super.key});

  @override
  State<StatefulWidget> createState() => _FoodScreenState();
}

class _FoodScreenState extends State<FoodScreen> {
  final _textController = TextEditingController();

  final _items = {"Яблоко", "Корм", "Колбаса"};

  Widget _itemsList() {
    return Expanded(
      child: SingleChildScrollView(
        child: Column(
          children: _items
              .map(
                (item) => _FoodItem(
                  item: item,
                  onTap: () {
                    _items.remove(item);
                  },
                ),
              )
              .toList(),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Экран выбора еды')),
      body: Padding(padding: const EdgeInsets.all(16), child: _body()),
    );
  }

  Widget _body() {
    return Column(
      children: [
        TextField(
          controller: _textController,
          autofocus: true,
          decoration: const InputDecoration(labelText: 'Новое блюдо'),
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

class _FoodItem extends StatelessWidget {
  final String item;
  final GestureTapCallback onTap;

  const _FoodItem({required this.item, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      key: ValueKey(item),
      onTap: onTap,
      child: Text(item),
    );
  }
}
