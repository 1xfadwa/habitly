
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/habit_provider.dart';

class StatisticsScreen extends StatelessWidget {
  const StatisticsScreen({super.key});

  static const List<String> days = [
    'Sat', 'Sun', 'Mon', 'Tue', 'Wed', 'Thu', 'Fri',
  ];

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<HabitProvider>();
    final habits = provider.habits;
    final colors = Theme.of(context).colorScheme;

    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);

    // بداية الأسبوع: السبت
    final daysSinceSaturday = (today.weekday + 1) % 7;
    final weekStart = today.subtract(
      Duration(days: daysSinceSaturday),
    );

    int scheduledCount = 0;
    int completedThisWeek = 0;
    final weeklyActivity = <int>[];

    for (int i = 0; i < 7; i++) {
      final date = weekStart.add(Duration(days: i));
      final dayName = days[i];

      int completedToday = 0;

      if (!date.isAfter(today)) {
        for (final habit in habits) {
          if (habit.repeatDays.contains(dayName)) {
            scheduledCount++;

            if (habit.isCompletedOn(_formatDate(date))) {
              completedToday++;
              completedThisWeek++;
            }
          }
        }
      }

      weeklyActivity.add(completedToday);
    }

    final completionRate = scheduledCount == 0
        ? 0
        : (completedThisWeek / scheduledCount * 100).round();

    final totalCompleted = habits.fold<int>(
      0,
      (total, habit) => total + habit.completedDates.length,
    );

    final bestStreak = habits.isEmpty
        ? 0
        : habits
            .map((habit) => provider.getCurrentStreak(habit.id))
            .reduce((a, b) => a > b ? a : b);

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Statistics',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: false,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildHeader(colors),

            const SizedBox(height: 24),

            Row(
              children: [
                Expanded(
                  child: _buildStatCard(
                    context,
                    title: 'Completion Rate',
                    value: '$completionRate%',
                    icon: Icons.track_changes,
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: _buildStatCard(
                    context,
                    title: 'Total Completed',
                    value: '$totalCompleted',
                    icon: Icons.check_circle_outline,
                  ),
                ),
              ],
            ),

            const SizedBox(height: 12),

            _buildStatCard(
              context,
              title: 'Best Current Streak',
              value: '$bestStreak days',
              icon: Icons.local_fire_department_outlined,
              fullWidth: true,
            ),

            const SizedBox(height: 28),

            Text(
              'Weekly Activity',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: colors.primary,
              ),
            ),

            const SizedBox(height: 6),

            Text(
              'Your completed habits this week',
              style: TextStyle(
                fontSize: 13,
                color: colors.onSurfaceVariant,
              ),
            ),

            const SizedBox(height: 20),

            _buildWeeklyChart(
              context,
              weeklyActivity,
              today,
              weekStart,
            ),

            const SizedBox(height: 24),

            _buildSummary(
              context,
              habits.length,
              completedThisWeek,
              scheduledCount,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader(ColorScheme colors) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Your Progress',
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: colors.primary,
          ),
        ),
        const SizedBox(height: 6),
        Text(
          'Keep building better habits every day.',
          style: TextStyle(
            fontSize: 14,
            color: colors.onSurfaceVariant,
          ),
        ),
      ],
    );
  }

  Widget _buildStatCard(
    BuildContext context, {
    required String title,
    required String value,
    required IconData icon,
    bool fullWidth = false,
  }) {
    final colors = Theme.of(context).colorScheme;

    return Container(
      width: fullWidth ? double.infinity : null,
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: colors.surfaceContainer,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(
          color: colors.outlineVariant.withValues(alpha: 0.4),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(
            icon,
            color: colors.secondary,
            size: 25,
          ),
          const SizedBox(height: 16),
          Text(
            value,
            style: TextStyle(
              fontSize: 23,
              fontWeight: FontWeight.bold,
              color: colors.onSurface,
            ),
          ),
          const SizedBox(height: 5),
          Text(
            title,
            style: TextStyle(
              fontSize: 12,
              color: colors.onSurfaceVariant,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildWeeklyChart(
    BuildContext context,
    List<int> activity,
    DateTime today,
    DateTime weekStart,
  ) {
    final colors = Theme.of(context).colorScheme;

    final maxValue = activity.fold<int>(
      1,
      (a, b) => a > b ? a : b,
    );

    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: colors.surfaceContainer,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(
          color: colors.outlineVariant.withValues(alpha: 0.4),
        ),
      ),
      child: SizedBox(
        height: 180,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: List.generate(7, (index) {
            final date = weekStart.add(Duration(days: index));
            final isFuture = date.isAfter(today);
            final value = activity[index];

            final height = isFuture
                ? 0.0
                : (value / maxValue * 100).clamp(8.0, 100.0);

            return Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 4),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text(
                      '$value',
                      style: TextStyle(
                        fontSize: 11,
                        color: colors.onSurfaceVariant,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Container(
                      height: height,
                      decoration: BoxDecoration(
                        color: isFuture
                            ? colors.surfaceContainerHighest
                            : colors.secondary,
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      days[index],
                      style: TextStyle(
                        fontSize: 10,
                        color: isFuture
                            ? colors.onSurfaceVariant.withValues(alpha: 0.5)
                            : colors.onSurface,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),
            );
          }),
        ),
      ),
    );
  }

  Widget _buildSummary(
    BuildContext context,
    int totalHabits,
    int completed,
    int scheduled,
  ) {
    final colors = Theme.of(context).colorScheme;

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: colors.primaryContainer,
        borderRadius: BorderRadius.circular(18),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'This Week',
            style: TextStyle(
              color: colors.onPrimaryContainer,
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 14),
          _summaryRow(
            context,
            'Total habits',
            '$totalHabits',
          ),
          _summaryRow(
            context,
            'Completed tasks',
            '$completed',
          ),
          _summaryRow(
            context,
            'Scheduled tasks',
            '$scheduled',
          ),
        ],
      ),
    );
  }

  Widget _summaryRow(
    BuildContext context,
    String label,
    String value,
  ) {
    final colors = Theme.of(context).colorScheme;

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: TextStyle(
              color: colors.onPrimaryContainer.withValues(alpha: 0.8),
            ),
          ),
          Text(
            value,
            style: TextStyle(
              color: colors.onPrimaryContainer,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }

  String _formatDate(DateTime date) {
    final year = date.year.toString();
    final month = date.month.toString().padLeft(2, '0');
    final day = date.day.toString().padLeft(2, '0');

    return '$year-$month-$day';
  }
}
