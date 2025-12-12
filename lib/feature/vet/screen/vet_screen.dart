import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../cubit/vet_cubit.dart';
import 'package:flutter_project/feature/pet_info/cubit/pet_cubit.dart';

class VetScreen extends StatelessWidget {
  const VetScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Ветклиника')),
      body: BlocBuilder<VetCubit, VetState>(
        builder: (context, vetState) {
          final petStatus = context.select((PetCubit c) => c.state.petStatus);
          
          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Card(
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      children: [
                        const Icon(Icons.medical_services, size: 60, color: Colors.red),
                        const SizedBox(height: 16),
                        Text(
                          "Текущее здоровье: ${petStatus?.health ?? 0}%",
                          style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          vetState.message,
                          textAlign: TextAlign.center,
                          style: const TextStyle(fontSize: 16),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 24),
                ElevatedButton.icon(
                  onPressed: () => context.read<VetCubit>().checkHealth(),
                  icon: const Icon(Icons.monitor_heart),
                  label: const Text('Осмотреть питомца (Бесплатно)'),
                ),
                const SizedBox(height: 12),
                ElevatedButton.icon(
                  onPressed: () => context.read<VetCubit>().buyVitamins(),
                  icon: const Icon(Icons.medication),
                  label: const Text('Купить витамины (20 монет)'),
                ),
                const SizedBox(height: 12),
                ElevatedButton.icon(
                  onPressed: () => context.read<VetCubit>().buyMedicine(),
                  icon: const Icon(Icons.local_hospital),
                  label: const Text('Серьезное лечение (50 монет)'),
                ),
                const SizedBox(height: 12),
                ElevatedButton.icon(
                  onPressed: () => context.read<VetCubit>().fullCheckup(),
                  icon: const Icon(Icons.healing),
                  label: const Text('Полный курс лечения (100 монет)'),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}

