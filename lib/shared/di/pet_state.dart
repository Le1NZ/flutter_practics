import 'package:flutter/material.dart';
import 'package:flutter_project/feature/pet_info/pet_info.dart';

class PetState extends InheritedWidget {
  final PetInfo petInfo;
  final PetStatus petStatus;
  final VoidCallback onFeed;
  final VoidCallback onPlay;
  final Function(String) onNameUpdate;
  final Function() resetState;

  const PetState({
    super.key,
    required super.child,
    required this.petInfo,
    required this.petStatus,
    required this.onFeed,
    required this.onPlay,
    required this.onNameUpdate,
    required this.resetState,
  });

  @override
  bool updateShouldNotify(covariant PetState oldWidget) {
    return oldWidget.petInfo != petInfo || oldWidget.petStatus != petStatus;
  }

  static PetState of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<PetState>()!;
  }
}
