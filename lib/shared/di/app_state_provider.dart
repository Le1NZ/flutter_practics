import 'package:flutter/material.dart';
import 'package:flutter_project/feature/pet_info/model/pet_info.dart';
import 'package:flutter_project/feature/pet_info/model/pet_status.dart';
import 'package:flutter_project/feature/pet_info/model/user_info.dart';
import 'package:flutter_project/feature/store/model/store_item.dart';
import 'package:flutter_project/feature/store/store.dart';
import 'package:flutter_project/shared/di/pet_state.dart';
import 'package:flutter_project/shared/di/user_state.dart';

class AppStateProvider extends StatefulWidget {
  final Widget child;

  const AppStateProvider({super.key, required this.child});

  static AppStateProviderState of(BuildContext context) {
    return context.findAncestorStateOfType<AppStateProviderState>()!;
  }

  @override
  State<AppStateProvider> createState() => AppStateProviderState();
}

class AppStateProviderState extends State<AppStateProvider> {
  PetInfo _petInfo = PetInfo(name: '', type: '');
  PetStatus _petStatus = PetStatus(hungry: 50, happiness: 50);
  UserInfo _userInfo = UserInfo(money: 50);
  final List<StoreItem> _storeItems = allStoreItems;

  void setInitialPetInfo(PetInfo petInfo) {
    setState(() {
      _petInfo = petInfo;
    });
  }

  void _onFeed() {
    setState(() {
      _petStatus = _petStatus.copyWith(
        hungry: _petStatus.hungry + 10,
        happiness: _petStatus.happiness - 5,
      );
      _userInfo = _userInfo.copyWith(money: _userInfo.money - 10);
    });
  }

  void _onPlay() {
    setState(() {
      _petStatus = _petStatus.copyWith(
        hungry: _petStatus.hungry - 7,
        happiness: _petStatus.happiness + 5,
      );
      _userInfo = _userInfo.copyWith(money: _userInfo.money + 15);
    });
  }

  void _onNameUpdate(String name) {
    setState(() {
      _petInfo = _petInfo.copyWith(name: name);
    });
  }

  void _onBuyItem(String id) {
    setState(() {
      final item = _storeItems.firstWhere((item) => item.id == id);
      final itemIndex = _storeItems.indexOf(item);
      final newItem = item.copyWith(wasBought: true);
      _storeItems[itemIndex] = newItem;
      _userInfo = _userInfo.copyWith(money: _userInfo.money - item.price);
    });
  }

  void _resetPetState() {
    setState(() {
      _petStatus = PetStatus(hungry: 50, happiness: 50);
    });
  }

  void _resetUserState() {
    setState(() {
      _userInfo = UserInfo(money: 50);
    });
  }

  @override
  Widget build(BuildContext context) {
    return PetState(
      petInfo: _petInfo,
      petStatus: _petStatus,
      onFeed: _onFeed,
      onPlay: _onPlay,
      onNameUpdate: _onNameUpdate,
      resetState: _resetPetState,
      child: UserState(
        userInfo: _userInfo,
        storeItems: _storeItems,
        onBuyItem: _onBuyItem,
        resetState: _resetUserState,
        child: widget.child,
      ),
    );
  }
}
