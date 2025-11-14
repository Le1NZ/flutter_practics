import 'package:flutter_project/shared/service/pet_service.dart';
import 'package:flutter_project/shared/service/user_service.dart';
import 'package:get_it/get_it.dart';

final locator = GetIt.instance;

void setupLocator() {
  locator.registerSingleton<UserService>(UserService());
  locator.registerSingleton<PetService>(PetService());
}
