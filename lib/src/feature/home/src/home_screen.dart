import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          spacing: 8,
          children: [
            const _Name(),
            const _GroupNumber(),
            const _StudentIdCardNumber(),
          ],
        ),
      ),
    );
  }
}

class _Name extends StatelessWidget {
  const _Name();

  final String name = 'Покровский Павел Дмитривевич';

  @override
  Widget build(BuildContext context) {
    return Text(
      name,
      style: TextStyle(
        fontSize: 24,
        color: Colors.black,
        fontWeight: FontWeight.bold,
      ),
      textAlign: TextAlign.center,
    );
  }
}

class _GroupNumber extends StatelessWidget {
  const _GroupNumber();

  final String groupNumber = 'ИКБО-06-22';

  @override
  Widget build(BuildContext context) {
    return Text(
      groupNumber,
      style: TextStyle(fontSize: 20, color: Colors.black),
      textAlign: TextAlign.center,
    );
  }
}

class _StudentIdCardNumber extends StatelessWidget {
  const _StudentIdCardNumber();

  final String cardNumber = '22И1204';

  @override
  Widget build(BuildContext context) {
    return Text(
      cardNumber,
      style: TextStyle(
        fontSize: 20,
        color: Colors.green,
        fontWeight: FontWeight.bold,
      ),
      textAlign: TextAlign.center,
    );
  }
}
