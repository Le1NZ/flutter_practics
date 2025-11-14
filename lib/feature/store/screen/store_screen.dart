import 'package:flutter/material.dart';
import 'package:flutter_project/shared/service/user_service.dart';
import 'package:flutter_project/shared/service_locator.dart';

import '../model/store_item.dart';
import '../model/store_item_state.dart';
import '../widget/store_item_view.dart';

class StoreScreen extends StatefulWidget {
  const StoreScreen({
    super.key,
  });

  @override
  State<StoreScreen> createState() => _StoreScreenState();
}

class _StoreScreenState extends State<StoreScreen> {
  final _userService = locator<UserService>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Магазин")),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: _info(context),
      ),
    );
  }

  Widget _info(BuildContext context) {
    final availableMoney = _userService.userInfo.money;

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
    return ListView.builder(
      itemBuilder: (context, index) {
        final item = _userService.storeItems[index];
        return StoreItemView(
          key: ValueKey(item),
          name: item.name,
          price: item.price,
          imageUrl: item.imageUrl,
          state: _resolveItemState(item, _userService.userInfo.money),
          onBuyPressed: () {
            setState(() {
              _userService.buyItem(item.id);
            });
          },
        );
      },
      itemCount: _userService.storeItems.length,
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
