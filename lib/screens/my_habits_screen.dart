
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/habit.dart';
import '../providers/habit_provider.dart';
import 'add_habit_sheet.dart';

class MyHabitsScreen extends StatelessWidget {
  const MyHabitsScreen({super.key});

  Future<void> _openAddHabitSheet(BuildContext context) async {
    final colors = Theme.of(context).colorScheme;

    final newHabit = await showModalBottomSheet<Habit>(
      context: context,
      isScrollControlled: true,
      backgroundColor: colors.surface,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(24),
        ),
      ),
      builder: (context) => const AddHabitSheet(),
    );

    if (newHabit != null && context.mounted) {
      context.read<HabitProvider>().addHabit(newHabit);

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Habit added successfully!'),
        ),
      );
    }
  }

  Future<void> _openEditHabitSheet(
    BuildContext context,
    Habit habit,
  ) async {
    final colors = Theme.of(context).colorScheme;

    final updatedHabit = await showModalBottomSheet<Habit>(
      context: context,
      isScrollControlled: true,
      backgroundColor: colors.surface,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(24),
        ),
      ),
      builder: (context) => AddHabitSheet(
        habit: habit,
      ),
    );

    if (updatedHabit != null && context.mounted) {
      context.read<HabitProvider>().updateHabit(updatedHabit);

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Habit updated successfully!'),
        ),
      );
    }
  }

  Future<void> _confirmDelete(
    BuildContext context,
    Habit habit,
  ) async {
    final colors = Theme.of(context).colorScheme;

    final shouldDelete = await showDialog<bool>(
      context: context,
      builder: (dialogContext) => AlertDialog(
        backgroundColor: colors.surface,
        title: Text(
          'Delete Habit',
          style: TextStyle(color: colors.onSurface),
        ),
        content: Text(
          'Are you sure you want to delete "${habit.name}"?',
          style: TextStyle(color: colors.onSurfaceVariant),
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(dialogContext, false);
            },
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(dialogContext, true);
            },
            child: Text(
              'Delete',
              style: TextStyle(color: colors.error),
            ),
          ),
        ],
      ),
    );

    if (shouldDelete == true && context.mounted) {
      context.read<HabitProvider>().deleteHabit(habit.id);

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Habit deleted successfully!'),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final habits = context.watch<HabitProvider>().habits;
    final colors = Theme.of(context).colorScheme;

    return SafeArea(
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'My Habits',
                  style: TextStyle(
                    fontSize: 26,
                    fontWeight: FontWeight.bold,
                    color: colors.primary,
                  ),
                ),
                IconButton(
                  onPressed: () => _openAddHabitSheet(context),
                  icon: Icon(
                    Icons.add_circle,
                    size: 32,
                    color: colors.primary,
                  ),
                  tooltip: 'Add Habit',
                ),
              ],
            ),

            const SizedBox(height: 8),

            Text(
              'Build your daily routine, one habit at a time.',
              style: TextStyle(
                fontSize: 14,
                color: colors.onSurfaceVariant,
              ),
            ),

            const SizedBox(height: 24),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'All Habits',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: colors.primary,
                  ),
                ),
                Text(
                  '${habits.length} habits',
                  style: TextStyle(
                    color: colors.onSurfaceVariant,
                    fontSize: 14,
                  ),
                ),
              ],
            ),

            const SizedBox(height: 16),

            if (habits.isEmpty)
              Center(
                child: Padding(
                  padding: const EdgeInsets.all(32),
                  child: Text(
                    'No habits yet. Start by adding your first habit!',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: colors.onSurfaceVariant,
                    ),
                  ),
                ),
              )
            else
              ...habits.map((habit) {
                return Padding(
                  padding: const EdgeInsets.only(bottom: 12),
                  child: _HabitListCard(
                    habit: habit,
                    onEdit: () {
                      _openEditHabitSheet(context, habit);
                    },
                    onDelete: () {
                      _confirmDelete(context, habit);
                    },
                  ),
                );
              }),
          ],
        ),
      ),
    );
  }
}

class _HabitListCard extends StatelessWidget {
  final Habit habit;
  final VoidCallback onEdit;
  final VoidCallback onDelete;

  const _HabitListCard({
    required this.habit,
    required this.onEdit,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: colors.surfaceContainer,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: colors.outlineVariant.withValues(alpha: 0.4),
        ),
      ),
      child: Row(
        children: [
          Container(
            width: 48,
            height: 48,
            decoration: BoxDecoration(
              color: colors.primaryContainer,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(
              Icons.track_changes,
              color: colors.onPrimaryContainer,
            ),
          ),

          const SizedBox(width: 12),

          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  habit.name,
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                    color: colors.onSurface,
                  ),
                ),

                const SizedBox(height: 4),

                Text(
                  habit.description,
                  style: TextStyle(
                    fontSize: 12,
                    color: colors.onSurfaceVariant,
                  ),
                ),

                const SizedBox(height: 8),

                Text(
                  '${habit.category} · ${habit.repeatDays.length} days/week',
                  style: TextStyle(
                    fontSize: 12,
                    color: colors.primary,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),

          PopupMenuButton<String>(
            iconColor: colors.onSurfaceVariant,
            color: colors.surfaceContainer,
            onSelected: (value) {
              if (value == 'edit') {
                onEdit();
              } else if (value == 'delete') {
                onDelete();
              }
            },
            itemBuilder: (context) => [
              PopupMenuItem(
                value: 'edit',
                child: Row(
                  children: [
                    Icon(
                      Icons.edit_outlined,
                      color: colors.primary,
                    ),
                    const SizedBox(width: 8),
                    Text(
                      'Edit',
                      style: TextStyle(color: colors.onSurface),
                    ),
                  ],
                ),
              ),
              PopupMenuItem(
                value: 'delete',
                child: Row(
                  children: [
                    Icon(
                      Icons.delete_outline,
                      color: colors.error,
                    ),
                    const SizedBox(width: 8),
                    Text(
                      'Delete',
                      style: TextStyle(color: colors.error),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
