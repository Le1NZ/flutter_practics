class Task {
  final String id;
  final String title;
  final int currentProgress;
  final int goal;
  final int reward;
  final bool isClaimed;

  Task({
    required this.id,
    required this.title,
    required this.currentProgress,
    required this.goal,
    required this.reward,
    this.isClaimed = false,
  });

  bool get isCompleted => currentProgress >= goal;

  Task copyWith({
    String? id,
    String? title,
    int? currentProgress,
    int? goal,
    int? reward,
    bool? isClaimed,
  }) {
    return Task(
      id: id ?? this.id,
      title: title ?? this.title,
      currentProgress: currentProgress ?? this.currentProgress,
      goal: goal ?? this.goal,
      reward: reward ?? this.reward,
      isClaimed: isClaimed ?? this.isClaimed,
    );
  }
}

