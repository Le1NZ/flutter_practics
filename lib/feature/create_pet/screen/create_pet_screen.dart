import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_project/feature/create_pet/model/pet_type.dart';
import 'package:flutter_project/feature/pet_info/pet_info.dart';
import 'package:flutter_project/shared/service/pet_service.dart';
import 'package:flutter_project/shared/service_locator.dart';
import 'package:go_router/go_router.dart';

import '../../../shared/snackbar.dart';

class CreatePetScreen extends StatefulWidget {
  const CreatePetScreen({super.key});

  @override
  State<CreatePetScreen> createState() => _CreatePetScreenState();
}

class _CreatePetScreenState extends State<CreatePetScreen> {
  final _nameTextController = TextEditingController();

  final petTypes = allPetTypes;
  late PetType _selectedType;

  @override
  void initState() {
    super.initState();
    _selectedType = petTypes.first;
  }

  void _onCreatePetPressed(BuildContext context) {
    if (_nameTextController.text.isEmpty) {
      showSnackBarWithText(context, 'Введите имя и тип питомца');
      return;
    }

    final petInfo = PetInfo(
      name: _nameTextController.text,
      type: _selectedType.name,
    );
    locator<PetService>().setInitialPetInfo(petInfo);
    context.pushReplacement('/pet-info');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Создание питомца')),
      body: Padding(
        padding: const EdgeInsets.all(16),
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
        _helpText('Выберите тип питомца:'),
        _dropdownMenu(),
        _petImage(_selectedType.imageUrl),
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

  Widget _dropdownMenu() {
    return DropdownButton<PetType>(
      value: _selectedType,
      items: petTypes.map<DropdownMenuItem<PetType>>((PetType value) {
        return DropdownMenuItem<PetType>(value: value, child: Text(value.name));
      }).toList(),
      onChanged: (PetType? newValue) {
        setState(() {
          if (newValue != null) {
            _selectedType = newValue;
          }
        });
      },
    );
  }

  Widget _petImage(String url) {
    return CachedNetworkImage(
      height: 100,
      fit: BoxFit.fitHeight,
      imageUrl: url,
      progressIndicatorBuilder: (context, url, progress) =>
          Center(child: CircularProgressIndicator()),
      errorWidget: (context, url, error) =>
          Icon(Icons.error, color: Colors.red),
    );
  }
}
