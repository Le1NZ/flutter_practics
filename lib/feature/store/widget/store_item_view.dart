import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../../../shared/snackbar.dart';
import '../model/store_item_state.dart';

class StoreItemView extends StatelessWidget {
  final String name;
  final int price;
  final StoreItemState state;
  final String imageUrl;
  final VoidCallback onBuyPressed;

  const StoreItemView({
    super.key,
    required this.name,
    required this.price,
    required this.state,
    required this.onBuyPressed,
    required this.imageUrl,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(padding: EdgeInsets.all(8.0), child: _item(context));
  }

  Widget _item(BuildContext context) {
    final onPressedCallback = _onBuyClick(context);
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          spacing: 16,
          children: [
            _info(),
            _itemImage(imageUrl),
          ],
        ),
        ElevatedButton(
          onPressed: onPressedCallback,
          child: Text(_resolveButtonText()),
        ),
      ],
    );
  }

  Widget _info() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          name,
          style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
        ),
        Text(
          "Стоимость: ${price.toString()}",
          style: TextStyle(fontSize: 14.0),
        ),
      ],
    );
  }

  Widget _itemImage(String url) {
    return CachedNetworkImage(
      height: 100,
      fit: BoxFit.fitHeight,
      imageUrl: url,
      progressIndicatorBuilder: (context, url, progress) =>
          Center(child: CircularProgressIndicator()),
      errorWidget: (context, url, error) =>
          Icon(Icons.error, color: Colors.red),
    );
  }

  VoidCallback? _onBuyClick(BuildContext context) {
    return switch (state) {
      StoreItemState.canBuy => () {
        onBuyPressed();
        showSnackBarWithText(context, "Куплено: $name");
        Navigator.pop(context);
      },
      StoreItemState.bought => null,
      StoreItemState.cannotBuy => null,
    };
  }

  String _resolveButtonText() {
    return switch (state) {
      StoreItemState.canBuy => 'Купить',
      StoreItemState.bought => 'Куплено',
      StoreItemState.cannotBuy => 'Недостаточно денег',
    };
  }
}
