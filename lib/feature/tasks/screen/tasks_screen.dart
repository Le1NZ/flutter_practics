import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../cubit/tasks_cubit.dart';
import '../model/task.dart';

class TasksScreen extends StatelessWidget {
  const TasksScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Ежедневные задания')),
      body: BlocBuilder<TasksCubit, TasksState>(
        builder: (context, state) {
          return ListView.builder(
            itemCount: state.tasks.length,
            itemBuilder: (context, index) {
              final task = state.tasks[index];
              return _TaskTile(task: task);
            },
          );
        },
      ),
    );
  }
}

class _TaskTile extends StatelessWidget {
  final Task task;

  const _TaskTile({required this.task});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: ListTile(
        title: Text(task.title),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 8),
            LinearProgressIndicator(
              value: task.currentProgress / task.goal,
            ),
            const SizedBox(height: 4),
            Text('${task.currentProgress} / ${task.goal}'),
          ],
        ),
        trailing: _buildActionButton(context),
      ),
    );
  }

  Widget _buildActionButton(BuildContext context) {
    if (task.isClaimed) {
      return const Icon(Icons.check_circle, color: Colors.green);
    }
    if (task.isCompleted) {
      return ElevatedButton(
        onPressed: () => context.read<TasksCubit>().claimReward(task.id),
        style: ElevatedButton.styleFrom(backgroundColor: Colors.amber),
        child: Text('+${task.reward}'),
      );
    }
    return Text('+${task.reward} монет');
  }
}

