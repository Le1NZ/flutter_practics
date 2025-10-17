import 'package:flutter/material.dart';
import 'package:flutter_project/shared/app_theme.dart';

class PetApp extends StatelessWidget {

  final String _appTitle = 'Мой питомец';

  const PetApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: _appTitle,
      theme: appTheme,
      home: Center(),
    );
  }
}
