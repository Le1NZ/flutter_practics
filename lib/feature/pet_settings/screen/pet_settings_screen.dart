import 'package:flutter/material.dart';
import 'package:flutter_project/feature/pet_info/pet_info.dart';
import 'package:go_router/go_router.dart';

import '../../../shared/snackbar.dart';

class PetSettingsScreen extends StatefulWidget {
  final PetInfo info;
  final PetState state;
  final Function(String name) onSaveClick;

  const PetSettingsScreen({
    super.key,
    required this.info,
    required this.state,
    required this.onSaveClick,
  });

  @override
  State<StatefulWidget> createState() => _PetSettingsScreenState();
}

class _PetSettingsScreenState extends State<PetSettingsScreen> {
  final _nameTextController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _nameTextController.text = widget.info.name;
  }

  void _onSavePressed() {
    if (_nameTextController.text.isEmpty) {
      showSnackBarWithText(context, 'Введите корректное имя питомца');
      return;
    }

    widget.onSaveClick(_nameTextController.text);
    context.pop();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Настройки")),
      body: Padding(padding: EdgeInsets.all(16), child: _info()),
    );
  }

  Widget _info() {
    return Column(
      spacing: 16,
      children: [
        _textInfo("Тип: ${widget.info.type}"),
        _textField(_nameTextController, "Имя"),
        _textInfo("Сытость: ${widget.state.hungry}/100"),
        _textInfo("Счастье: ${widget.state.happiness}/100"),
        ElevatedButton(onPressed: _onSavePressed, child: Text("Сохранить")),
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
