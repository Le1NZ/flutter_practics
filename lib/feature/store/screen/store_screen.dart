import 'package:flutter/material.dart';
import 'package:flutter_project/shared/di/user_state.dart';

import '../model/store_item.dart';
import '../model/store_item_state.dart';
import '../widget/store_item_view.dart';

class StoreScreen extends StatelessWidget {
  const StoreScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Магазин")),
      body: Padding(padding: const EdgeInsets.all(16), child: _info(context)),
    );
  }

  Widget _info(BuildContext context) {
    final userState = UserState.of(context);
    final availableMoney = userState.userInfo.money;

    return Column(
      children: [
        Text(
          "Монеты: $availableMoney",
          style: const TextStyle(fontSize: 16.0, color: Colors.black),
        ),
        Expanded(child: _itemsList(context)),
      ],
    );
  }

  Widget _itemsList(BuildContext context) {
    final userState = UserState.of(context);
    return ListView.builder(
      itemBuilder: (context, index) {
        final item = userState.storeItems[index];
        return StoreItemView(
          key: ValueKey(item),
          name: item.name,
          price: item.price,
          imageUrl: item.imageUrl,
          state: _resolveItemState(item, userState.userInfo.money),
          onBuyPressed: () {
            userState.onBuyItem(item.id);
          },
        );
      },
      itemCount: userState.storeItems.length,
    );
  }

  StoreItemState _resolveItemState(StoreItem item, int availableMoney) {
    if (item.wasBought) {
      return StoreItemState.bought;
    } else if (availableMoney >= item.price) {
      return StoreItemState.canBuy;
    } else {
      return StoreItemState.cannotBuy;
    }
  }
}
