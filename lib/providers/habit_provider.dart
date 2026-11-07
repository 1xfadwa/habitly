import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../data/mock_habits.dart';
import '../models/habit.dart';

class HabitProvider extends ChangeNotifier {
  static const String _storageKey = 'habitly_habits';

  List<Habit> _habits = List.from(mockHabits);

  List<Habit> get habits => List.unmodifiable(_habits);

  // Load saved habits from local storage
  Future<void> loadHabits() async {
    try {
      debugPrint('Starting to load habits...');

      final preferences = await SharedPreferences.getInstance();

      final savedData = preferences.getString(_storageKey);

      if (savedData != null) {
        final List<dynamic> decodedData = jsonDecode(savedData);

        _habits = decodedData.map((item) {
          return Habit.fromJson(Map<String, dynamic>.from(item));
        }).toList();

        debugPrint('Loaded habits count: ${_habits.length}');
      } else {
        debugPrint('No saved habits found. Using mock data.');
      }

      notifyListeners();
    } catch (error, stackTrace) {
      debugPrint('Error loading habits: $error');
      debugPrint('$stackTrace');
    }
  }

  // Save all habits to local storage
  Future<void> _saveHabits() async {
    try {
      final preferences = await SharedPreferences.getInstance();

      final encodedData = jsonEncode(
        _habits.map((habit) => habit.toJson()).toList(),
      );

      final success = await preferences.setString(_storageKey, encodedData);

      if (success) {
        debugPrint('Habits saved successfully!');
      } else {
        debugPrint('Failed to save habits.');
      }
    } catch (error, stackTrace) {
      debugPrint('Error saving habits: $error');
      debugPrint('$stackTrace');
    }
  }

  // Add a new habit
  void addHabit(Habit habit) {
    _habits.add(habit);

    notifyListeners();

    _saveHabits();
  }

  // Update an existing habit
  void updateHabit(Habit updatedHabit) {
    final index = _habits.indexWhere((habit) => habit.id == updatedHabit.id);

    if (index == -1) return;

    _habits[index] = updatedHabit;

    notifyListeners();

    _saveHabits();
  }

  // Delete a habit
  void deleteHabit(String habitId) {
    _habits.removeWhere((habit) => habit.id == habitId);

    notifyListeners();

    _saveHabits();
  }

  // Get habits scheduled for a specific day
  List<Habit> getHabitsForDay(String day) {
    return _habits.where((habit) {
      return habit.repeatDays.contains(day);
    }).toList();
  }

  // Check whether a habit is completed on a specific date
  bool isHabitCompleted(String habitId, String date) {
    final index = _habits.indexWhere((habit) => habit.id == habitId);

    if (index == -1) return false;

    return _habits[index].isCompletedOn(date);
  }

  // Toggle habit completion
  void toggleHabitCompletion(String habitId, String date) {
    final index = _habits.indexWhere((habit) => habit.id == habitId);

    if (index == -1) return;

    final habit = _habits[index];

    final updatedDates = List<String>.from(habit.completedDates);

    if (updatedDates.contains(date)) {
      updatedDates.remove(date);
    } else {
      updatedDates.add(date);
    }

    _habits[index] = habit.copyWith(completedDates: updatedDates);

    notifyListeners();

    _saveHabits();
  }

  // Calculate current streak
  int getCurrentStreak(String habitId) {
    final index = _habits.indexWhere((habit) => habit.id == habitId);

    if (index == -1) return 0;

    final habit = _habits[index];

    final today = DateTime.now();

    DateTime currentDate = DateTime(today.year, today.month, today.day);

    final todayName = _getDayName(currentDate);

    if (habit.repeatDays.contains(todayName) &&
        !habit.isCompletedOn(_formatDate(currentDate))) {
      currentDate = currentDate.subtract(const Duration(days: 1));
    }

    int streak = 0;

    for (int i = 0; i < 365; i++) {
      final dayName = _getDayName(currentDate);

      if (habit.repeatDays.contains(dayName)) {
        final date = _formatDate(currentDate);

        if (habit.isCompletedOn(date)) {
          streak++;
        } else {
          break;
        }
      }

      currentDate = currentDate.subtract(const Duration(days: 1));
    }

    return streak;
  }

  // Convert DateTime to day name
  String _getDayName(DateTime date) {
    const days = ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'];

    return days[date.weekday - 1];
  }

  // Format date as YYYY-MM-DD
  String _formatDate(DateTime date) {
    final year = date.year.toString();
    final month = date.month.toString().padLeft(2, '0');
    final day = date.day.toString().padLeft(2, '0');

    return '$year-$month-$day';
  }
}
