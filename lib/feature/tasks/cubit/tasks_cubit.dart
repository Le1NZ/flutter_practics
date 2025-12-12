import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_project/feature/pet_info/cubit/user_info_cubit.dart';
import '../model/task.dart';

part 'tasks_state.dart';

class TasksCubit extends Cubit<TasksState> {
  final UserInfoCubit userInfoCubit;

  TasksCubit(this.userInfoCubit)
      : super(TasksState(tasks: [
          Task(
            id: '1',
            title: 'Покормить питомца 3 раза',
            currentProgress: 0,
            goal: 3,
            reward: 15,
          ),
          Task(
            id: '2',
            title: 'Поиграть 2 раза',
            currentProgress: 0,
            goal: 2,
            reward: 20,
          ),
          Task(
            id: '3',
            title: 'Посетить ветклинику',
            currentProgress: 0,
            goal: 1,
            reward: 50,
          ),
        ]));

  void incrementFeed() => _updateProgress('1');
  void incrementPlay() => _updateProgress('2');
  void visitVet() => _updateProgress('3');

  void _updateProgress(String taskId) {
    final updatedTasks = state.tasks.map((task) {
      if (task.id == taskId && !task.isCompleted) {
        return task.copyWith(currentProgress: task.currentProgress + 1);
      }
      return task;
    }).toList();
    emit(TasksState(tasks: updatedTasks));
  }

  void claimReward(String taskId) {
    final taskIndex = state.tasks.indexWhere((t) => t.id == taskId);
    if (taskIndex != -1) {
      final task = state.tasks[taskIndex];
      if (task.isCompleted && !task.isClaimed) {
        userInfoCubit.earn(task.reward);
        
        final updatedTasks = List<Task>.from(state.tasks);
        updatedTasks[taskIndex] = task.copyWith(isClaimed: true);
        emit(TasksState(tasks: updatedTasks));
      }
    }
  }
}

