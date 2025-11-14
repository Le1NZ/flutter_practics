import 'package:flutter_project/feature/pet_info/model/pet_info.dart';
import 'package:flutter_project/feature/pet_info/model/pet_status.dart';
import 'package:flutter_project/shared/service/user_service.dart';

import '../service_locator.dart';

class PetService {
  PetInfo petInfo = PetInfo(name: '', type: '');
  PetStatus petStatus = PetStatus(hungry: 50, happiness: 50);
  final UserService _userService = locator<UserService>();

  void setInitialPetInfo(PetInfo newPetInfo) {
    petInfo = newPetInfo;
  }

  void feed() {
    petStatus = petStatus.copyWith(
      hungry: petStatus.hungry + 10,
      happiness: petStatus.happiness - 5,
    );
    if (locator.isRegistered<UserService>()) {
      locator.get<UserService>().spendMoney(10);
    } else {
      print("Developer error. UserService is not registered in GetIt");
    }
  }

  void play() {
    petStatus = petStatus.copyWith(
      hungry: petStatus.hungry - 7,
      happiness: petStatus.happiness + 5,
    );
    _userService.earnMoney(15);
  }

  void updateName(String name) {
    petInfo = petInfo.copyWith(name: name);
  }

  void resetState() {
    petStatus = PetStatus(hungry: 50, happiness: 50);
  }
}
