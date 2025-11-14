import 'package:flutter_project/feature/pet_info/model/user_info.dart';
import 'package:flutter_project/feature/store/model/store_item.dart';
import 'package:flutter_project/feature/store/store.dart';

class UserService {
  UserInfo userInfo = UserInfo(money: 50);
  List<StoreItem> storeItems =
      allStoreItems.map((item) => item.copyWith()).toList();

  void buyItem(String id) {
    final item = storeItems.firstWhere((item) => item.id == id);
    final itemIndex = storeItems.indexOf(item);
    final newItem = item.copyWith(wasBought: true);
    storeItems[itemIndex] = newItem;
    userInfo = userInfo.copyWith(money: userInfo.money - item.price);
  }

  void spendMoney(int amount) {
    userInfo = userInfo.copyWith(money: userInfo.money - amount);
  }

  void earnMoney(int amount) {
    userInfo = userInfo.copyWith(money: userInfo.money + amount);
  }

  void resetState() {
    userInfo = UserInfo(money: 50);
    storeItems = allStoreItems.map((item) => item.copyWith()).toList();
  }
}
