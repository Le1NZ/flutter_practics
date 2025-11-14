import 'package:flutter/material.dart';
import 'package:flutter_project/shared/service/pet_service.dart';
import 'package:flutter_project/shared/service_locator.dart';
import 'package:go_router/go_router.dart';

import '../../../shared/snackbar.dart';

class PetSettingsScreen extends StatefulWidget {
  const PetSettingsScreen({
    super.key,
  });

  @override
  State<StatefulWidget> createState() => _PetSettingsScreenState();
}

class _PetSettingsScreenState extends State<PetSettingsScreen> {
  final _nameTextController = TextEditingController();
  final _petService = locator<PetService>();

  @override
  void initState() {
    super.initState();
    _nameTextController.text = _petService.petInfo.name;
  }

  void _onSavePressed() {
    if (_nameTextController.text.isEmpty) {
      showSnackBarWithText(context, 'Введите корректное имя питомца');
      return;
    }

    setState(() {
      _petService.updateName(_nameTextController.text);
    });
    context.pop();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Настройки")),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: _info(),
      ),
    );
  }

  Widget _info() {
    return Column(
      children: [
        _textInfo("Тип: ${_petService.petInfo.type}"),
        _textField(_nameTextController, "Имя"),
        _textInfo("Сытость: ${_petService.petStatus.hungry}/100"),
        _textInfo("Счастье: ${_petService.petStatus.happiness}/100"),
        ElevatedButton(
            onPressed: _onSavePressed, child: const Text("Сохранить")),
      ],
    );
  }

  Widget _textInfo(String text) {
    return Text(text);
  }

  Widget _textField(TextEditingController controller, String hintText) {
    return TextField(
      controller: controller,
      decoration: InputDecoration(
        hintText: hintText,
        border: OutlineInputBorder(),
      ),
    );
  }
}
