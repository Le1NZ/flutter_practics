import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_project/feature/store/cubit/store_cubit.dart';
import 'package:flutter_project/feature/pet_info/cubit/user_info_cubit.dart';

import '../../pet_info/model/user_info.dart';
import '../model/store_item.dart';
import '../model/store_item_state.dart';
import '../widget/store_item_view.dart';

class StoreScreen extends StatelessWidget {
  const StoreScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Магазин")),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: BlocBuilder<StoreCubit, StoreState>(
          builder: (context, storeState) {
            return BlocBuilder<UserInfoCubit, UserInfo>(
              builder: (context, userInfoState) {
                return _info(context, storeState, userInfoState);
              },
            );
          },
        ),
      ),
    );
  }

  Widget _info(
    BuildContext context,
    StoreState storeState,
    UserInfo userInfoState,
  ) {
    return Column(
      children: [
        Text(
          "Монеты: ${userInfoState.money}",
          style: const TextStyle(fontSize: 16.0, color: Colors.black),
        ),
        Expanded(child: _itemsList(context, storeState, userInfoState)),
      ],
    );
  }

  Widget _itemsList(
    BuildContext context,
    StoreState storeState,
    UserInfo userInfoState,
  ) {
    return ListView.builder(
      itemBuilder: (context, index) {
        final item = storeState.items[index];
        return StoreItemView(
          key: ValueKey(item),
          name: item.name,
          price: item.price,
          imageUrl: item.imageUrl,
          state: _resolveItemState(item, userInfoState.money),
          onBuyPressed: () => context.read<StoreCubit>().buyItem(item),
        );
      },
      itemCount: storeState.items.length,
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
