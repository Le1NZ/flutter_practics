import 'package:flutter/material.dart';

import '../model/store_item.dart';
import '../model/store_item_state.dart';
import '../widget/store_item_view.dart';

class StoreScreen extends StatelessWidget {
  final int availableMoney;
  final List<StoreItem> items;
  final Function(String id) onBuyPressed;

  const StoreScreen({
    super.key,
    required this.availableMoney,
    required this.items,
    required this.onBuyPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Магазин")),
      body: Padding(padding: EdgeInsets.all(16), child: _info()),
    );
  }

  Widget _info() {
    return Column(
      spacing: 24,
      children: [
        Text(
          "Монеты: $availableMoney",
          style: const TextStyle(fontSize: 16.0, color: Colors.black),
        ),
        Expanded(child: _itemsList()),
      ],
    );
  }

  Widget _itemsList() {
    return ListView.builder(
      itemBuilder: (context, index) {
        final item = items[index];
        return StoreItemView(
          key: ValueKey(item),
          name: item.name,
          price: item.price,
          imageUrl: item.imageUrl,
          state: _resolveItemState(items[index]),
          onBuyPressed: () {
            onBuyPressed(item.id);
          },
        );
      },
      itemCount: items.length,
    );
  }

  StoreItemState _resolveItemState(StoreItem item) {
    if (item.wasBought) {
      return StoreItemState.bought;
    } else if (availableMoney >= item.price) {
      return StoreItemState.canBuy;
    } else {
      return StoreItemState.cannotBuy;
    }
  }
}
