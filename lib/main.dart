import 'package:flutter/material.dart';

import 'package:flutter_project/src/core/design/design.dart';
import 'package:flutter_project/src/feature/home/home.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {

  final String _appTitle = 'Practice 2';

  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: _appTitle,
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.green),
        ),
        home: AppScaffold(
          body: const HomeScreen(),
          title: _appTitle,
        ),
    );
  }
}
