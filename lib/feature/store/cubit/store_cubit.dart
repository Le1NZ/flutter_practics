import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_project/feature/store/model/store_item.dart';
import 'package:flutter_project/feature/pet_info/cubit/user_info_cubit.dart';

class StoreState {
  final List<StoreItem> items;

  StoreState({
    required this.items,
  });

  StoreState copyWith({
    List<StoreItem>? items,
  }) {
    return StoreState(
      items: items ?? this.items,
    );
  }
}

class StoreCubit extends Cubit<StoreState> {
  final UserInfoCubit _userInfoCubit;

  StoreCubit(this._userInfoCubit)
      : super(StoreState(items: allStoreItems.map((e) => e.copyWith()).toList()));

  void buyItem(StoreItem item) {
    final currentUserInfo = _userInfoCubit.state;
    if (currentUserInfo.money >= item.price) {
      _userInfoCubit.spend(item.price);

      final newItems = state.items.map((storeItem) {
        if (storeItem.id == item.id) {
          return storeItem.copyWith(wasBought: true);
        }
        return storeItem;
      }).toList();

      emit(state.copyWith(
        items: newItems,
      ));
    }
  }
  
  void reset() {
    emit(StoreState(items: allStoreItems.map((e) => e.copyWith()).toList()));
  }
}
