import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_project/feature/create_pet/cubit/create_pet_cubit.dart';
import 'package:flutter_project/feature/pet_info/cubit/user_info_cubit.dart';
import 'package:flutter_project/feature/store/cubit/store_cubit.dart';
import 'package:go_router/go_router.dart';

import '../../../shared/snackbar.dart';
import '../../pet_info/cubit/pet_cubit.dart';

class CreatePetScreen extends StatelessWidget {
  const CreatePetScreen({super.key});

  void _onCreatePetPressed(BuildContext context) {
    final createPetCubit = context.read<CreatePetCubit>();
    if (createPetCubit.state.petName.isEmpty) {
      showSnackBarWithText(context, 'Введите имя питомца');
      return;
    }

    final petCubit = context.read<PetCubit>();
    final userInfoCubit = context.read<UserInfoCubit>();
    final storeCubit = context.read<StoreCubit>();

    userInfoCubit.reset();
    petCubit.reset();
    storeCubit.reset();

    petCubit.createPet(
      name: createPetCubit.state.petName,
      type: createPetCubit
          .state
          .petTypes[createPetCubit.state.selectedPetIndex]
          .name,
    );

    context.pushReplacement('/pet-info');
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => CreatePetCubit(),
      child: Scaffold(
        appBar: AppBar(title: const Text('Создание питомца')),
        body: Padding(
          padding: const EdgeInsets.all(16),
          child: Center(
            child: BlocBuilder<CreatePetCubit, CreatePetState>(
              builder: (context, state) {
                return _creatingColumn(context, state);
              },
            ),
          ),
        ),
      ),
    );
  }

  Widget _creatingColumn(BuildContext context, CreatePetState state) {
    return Column(
      spacing: 16,
      children: [
        _helpText('Введите имя питомца:'),
        _textField(context, 'Имя'),
        _helpText('Выберите тип питомца:'),
        _dropdownMenu(context, state),
        _petImage(state.petTypes[state.selectedPetIndex].imageUrl),
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

  Widget _textField(BuildContext context, String hintText) {
    return TextField(
      onChanged: (value) => context.read<CreatePetCubit>().setPetName(value),
      decoration: InputDecoration(
        hintText: hintText,
        border: OutlineInputBorder(),
      ),
    );
  }

  Widget _dropdownMenu(BuildContext context, CreatePetState state) {
    return DropdownButton<int>(
      value: state.selectedPetIndex,
      items: state.petTypes.asMap().entries.map<DropdownMenuItem<int>>((entry) {
        return DropdownMenuItem<int>(
          value: entry.key,
          child: Text(entry.value.name),
        );
      }).toList(),
      onChanged: (int? newValue) {
        if (newValue != null) {
          context.read<CreatePetCubit>().selectPetType(newValue);
        }
      },
    );
  }

  Widget _petImage(String url) {
    return CachedNetworkImage(
      height: 100,
      fit: BoxFit.fitHeight,
      imageUrl: url,
      progressIndicatorBuilder: (context, url, progress) =>
          const Center(child: CircularProgressIndicator()),
      errorWidget: (context, url, error) =>
          const Icon(Icons.error, color: Colors.red),
    );
  }
}
