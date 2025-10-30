import 'package:flutter/material.dart';
import 'package:flutter_project/feature/create_pet/create_pet.dart';
import 'package:flutter_project/feature/pet_info/pet_info.dart';
import 'package:flutter_project/feature/store/model/store_item.dart';

class EndGameScreen extends StatelessWidget {
  final bool wasWin;
  final PetInfo petInfo;

  const EndGameScreen({super.key, required this.wasWin, required this.petInfo});

  void _onStartNewGameClick(BuildContext context) {
    for (var item in allStoreItems) {
      final newItem = item.copyWith(wasBought: false);
      final index = allStoreItems.indexOf(item);
      allStoreItems[index] = newItem;
    }

    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => CreatePetScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Конец игры")),
      body: Padding(padding: EdgeInsets.all(16), child: _info(context)),
    );
  }

  Widget _info(BuildContext context) {
    return Center(child: _column(context));
  }

  Widget _column(BuildContext context) {
    return Column(
      spacing: 16,
      children: [
        Text("${petInfo.type} ${petInfo.name}", style: TextStyle(fontSize: 44)),
        Text(
          (wasWin ? "победа" : "проигрыш").toUpperCase(),
          style: TextStyle(fontSize: 36, fontWeight: FontWeight.bold),
        ),
        ElevatedButton(
          onPressed: () {
            _onStartNewGameClick(context);
          },
          child: Text("Заново"),
        ),
      ],
    );
  }
}
