import 'package:flutter/material.dart';
import 'package:flutter_project/src/feature/feed/feed.dart';
import 'package:flutter_project/src/feature/play/play.dart';
import 'package:flutter_project/src/feature/stats/stats.dart';
import 'package:flutter_project/src/feature/toy/toy.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _hunger = 50;
  int _happiness = 50;
  String _currentToy = toys[0];

  final List<String> _activities = ['Спит', 'Играет', 'Ест', 'Наблюдает'];
  int _activityIndex = 0;

  void _navigateToFeedScreen() async {
    final int? newHunger = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => FeedScreen(initialHunger: _hunger),
      ),
    );
    if (newHunger != null) {
      setState(() {
        _hunger = newHunger;
      });
    }
  }

  void _navigateToPlayScreen() async {
    final int? newHappiness = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => PlayScreen(initialHappiness: _happiness),
      ),
    );
    if (newHappiness != null) {
      setState(() {
        _happiness = newHappiness;
      });
    }
  }

  void _navigateToToyScreen() async {
    final String? newToy = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ToyScreen(initialToy: _currentToy),
      ),
    );
    if (newToy != null) {
      setState(() {
        _currentToy = newToy;
      });
    }
  }

  void _navigateToStatsScreen() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => StatsScreen(
          hunger: _hunger,
          happiness: _happiness,
          toy: _currentToy,
        ),
      ),
    );
  }

  void _changeActivity() {
    setState(() {
      _activityIndex = (_activityIndex + 1) % _activities.length;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Мой питомец')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'Состояние: ${_activities[_activityIndex]}',
              style: TextStyle(fontSize: 36, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 40),
            ElevatedButton(
              onPressed: _changeActivity,
              child: const Text('Сменить активность'),
            ),
            const SizedBox(height: 10),
            ElevatedButton(
              onPressed: _navigateToFeedScreen,
              child: const Text('Покормить питомца'),
            ),
            const SizedBox(height: 10),
            ElevatedButton(
              onPressed: _navigateToPlayScreen,
              child: const Text('Поиграть с питомцем'),
            ),
            const SizedBox(height: 10),
            ElevatedButton(
              onPressed: _navigateToToyScreen,
              child: const Text('Выбрать игрушку'),
            ),
            const SizedBox(height: 10),
            ElevatedButton(
              onPressed: _navigateToStatsScreen,
              child: const Text('Посмотреть статистику'),
            ),
          ],
        ),
      ),
    );
  }
}
