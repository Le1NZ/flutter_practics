import 'package:flutter/material.dart';

class CreatePetScreen extends StatelessWidget {
  final _nameTextController = TextEditingController();
  final _typeTextController = TextEditingController();

  CreatePetScreen({super.key});

  void _onCreatePetPressed(BuildContext context) {
    if (_nameTextController.text.isEmpty || _typeTextController.text.isEmpty) {
      _showErrorSnackBar(context);
      return;
    }
    // TODO navigate to main screen
  }

  void _showErrorSnackBar(BuildContext context) {
    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Введите имя и тип питомца')),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Создание питомца')),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Center(child: _creatingColumn(context)),
      ),
    );
  }

  Widget _creatingColumn(BuildContext context) {
    return Column(
      spacing: 16,
      children: [
        _helpText('Введите имя питомца:'),
        _textField(_nameTextController, 'Имя'),
        _helpText('Введите тип питомца:'),
        _textField(_typeTextController, 'Тип'),
        ElevatedButton(
          onPressed: () => _onCreatePetPressed(context),
          child: const Text('Создать питомца'),
        ),
      ],
    );
  }

  Widget _helpText(String text) {
    return Text(text, style: TextStyle(color: Colors.black, fontSize: 20));
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
