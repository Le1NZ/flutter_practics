import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: _DecrementAndShow(),
    );
  }
}

class _DecrementAndShow extends StatefulWidget {

  const _DecrementAndShow();

  @override
  State<StatefulWidget> createState() => _DecrementAndShowState();
}

class _DecrementAndShowState extends State<_DecrementAndShow> {
  int _counter = 100;

  void _decrementCounter() {
    setState(() {
      _counter--;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        spacing: 16,
        children: <Widget>[
          ElevatedButton(
            onPressed: _decrementCounter,
            child: Text("Decrement"),
          ),
          Text(
            '$_counter',
          ),
        ]
    );
  }
}

