import 'package:flutter/material.dart';
import 'package:flutter_project/feature/pet_info/pet_info.dart';
import 'package:flutter_project/feature/store/store.dart';

class UserState extends InheritedWidget {
  final UserInfo userInfo;
  final List<StoreItem> storeItems;
  final Function(String) onBuyItem;
  final Function() resetState;

  const UserState({
    super.key,
    required super.child,
    required this.userInfo,
    required this.storeItems,
    required this.onBuyItem,
    required this.resetState,
  });

  @override
  bool updateShouldNotify(covariant UserState oldWidget) {
    return oldWidget.userInfo != userInfo || oldWidget.storeItems != storeItems;
  }

  static UserState of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<UserState>()!;
  }
}
