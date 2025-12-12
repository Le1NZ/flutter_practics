import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_project/feature/pet_settings/cubit/pet_settings_cubit.dart';
import 'package:go_router/go_router.dart';

import '../../../shared/snackbar.dart';
import '../../pet_info/cubit/pet_cubit.dart';

class PetSettingsScreen extends StatelessWidget {
  const PetSettingsScreen({super.key});

  void _onSavePressed(BuildContext context) {
    if (context.read<PetSettingsCubit>().savePetName()) {
      context.pop();
    } else {
      showSnackBarWithText(context, 'Введите корректное имя питомца');
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => PetSettingsCubit(context.read<PetCubit>()),
      child: Scaffold(
        appBar: AppBar(title: const Text("Настройки")),
        body: Padding(
          padding: const EdgeInsets.all(16),
          child: BlocBuilder<PetSettingsCubit, PetSettingsState>(
            builder: (context, state) {
              return _info(context, state);
            },
          ),
        ),
      ),
    );
  }

  Widget _info(BuildContext context, PetSettingsState state) {
    final petState = context.read<PetCubit>().state;
    return Column(
      children: [
        if (petState.petInfo != null)
          _textInfo("Тип: ${petState.petInfo!.type}"),
        _textField(context, "Имя", state.petName),
        if (petState.petStatus != null)
          _textInfo("Сытость: ${petState.petStatus!.hungry}/100"),
        if (petState.petStatus != null)
          _textInfo("Счастье: ${petState.petStatus!.happiness}/100"),
        if (petState.petStatus != null)
          _textInfo("Здоровье: ${petState.petStatus!.health}/100"),
        ElevatedButton(
          onPressed: () => _onSavePressed(context),
          child: const Text("Сохранить"),
        ),
      ],
    );
  }

  Widget _textInfo(String text) {
    return Text(text);
  }

  Widget _textField(
    BuildContext context,
    String hintText,
    String initialValue,
  ) {
    return TextFormField(
      initialValue: initialValue,
      onChanged: (value) => context.read<PetSettingsCubit>().setPetName(value),
      decoration: InputDecoration(
        hintText: hintText,
        border: OutlineInputBorder(),
      ),
    );
  }
}
