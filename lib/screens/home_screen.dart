
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/habit_provider.dart';
import '../widgets/weekly_calendar.dart';
import '../widgets/progress_card.dart';
import '../widgets/habit_card.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final List<String> _weekDays = [
    'Sat', 'Sun', 'Mon', 'Tue', 'Wed', 'Thu', 'Fri',
  ];

  late String _selectedDay;

  @override
  void initState() {
    super.initState();

    final today = DateTime.now();
    final todayIndex = (today.weekday + 1) % 7;

    _selectedDay = _weekDays[todayIndex];
  }

  String get _selectedDate {
    final today = DateTime.now();
    final daysSinceSaturday = (today.weekday + 1) % 7;

    final saturday = DateTime(
      today.year,
      today.month,
      today.day,
    ).subtract(Duration(days: daysSinceSaturday));

    final selectedIndex = _weekDays.indexOf(_selectedDay);

    final selectedDate = saturday.add(
      Duration(days: selectedIndex),
    );

    final year = selectedDate.year.toString();
    final month = selectedDate.month.toString().padLeft(2, '0');
    final day = selectedDate.day.toString().padLeft(2, '0');

    return '$year-$month-$day';
  }

  @override
  Widget build(BuildContext context) {
    final habitProvider = context.watch<HabitProvider>();
    final colors = Theme.of(context).colorScheme;

    final dailyHabits =
        habitProvider.getHabitsForDay(_selectedDay);

    final completedCount = dailyHabits.where((habit) {
      return habitProvider.isHabitCompleted(
        habit.id,
        _selectedDate,
      );
    }).length;

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Habitly',
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Welcome back!',
                style: TextStyle(
                  fontSize: 26,
                  fontWeight: FontWeight.bold,
                  color: colors.primary,
                ),
              ),

              const SizedBox(height: 8),

              Text(
                'Build better habits, one day at a time.',
                style: TextStyle(
                  color: colors.onSurfaceVariant,
                  fontSize: 15,
                ),
              ),

              const SizedBox(height: 24),

              WeeklyCalendar(
                selectedDay: _selectedDay,
                onDaySelected: (day) {
                  setState(() {
                    _selectedDay = day;
                  });
                },
              ),

              const SizedBox(height: 24),

              ProgressCard(
                completed: completedCount,
                total: dailyHabits.length,
              ),

              const SizedBox(height: 28),

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Habits for $_selectedDay',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: colors.primary,
                    ),
                  ),
                  Text(
                    '${dailyHabits.length} Habits',
                    style: TextStyle(
                      color: colors.onSurfaceVariant,
                      fontSize: 13,
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 16),

              if (dailyHabits.isEmpty)
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(24),
                  decoration: BoxDecoration(
                    color: colors.surface,
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(
                      color: colors.outlineVariant,
                    ),
                  ),
                  child: Column(
                    children: [
                      Icon(
                        Icons.event_available_outlined,
                        size: 40,
                        color: colors.secondary,
                      ),
                      const SizedBox(height: 12),
                      Text(
                        'No habits scheduled for this day.',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: colors.onSurfaceVariant,
                        ),
                      ),
                    ],
                  ),
                )
              else
                ...dailyHabits.map((habit) {
                  final isCompleted =
                      habitProvider.isHabitCompleted(
                    habit.id,
                    _selectedDate,
                  );

                  return Padding(
                    padding: const EdgeInsets.only(bottom: 12),
                    child: HabitCard(
                      title: habit.name,
                      description: habit.description,
                      icon: Icons.check_circle_outline,
                      isCompleted: isCompleted,
                      streak: habitProvider.getCurrentStreak(
                        habit.id,
                      ),
                      onToggle: () {
                        habitProvider.toggleHabitCompletion(
                          habit.id,
                          _selectedDate,
                        );
                      },
                    ),
                  );
                }),
            ],
          ),
        ),
      ),
    );
  }
}
