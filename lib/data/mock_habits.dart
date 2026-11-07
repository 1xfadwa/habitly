import '../models/habit.dart';

final List<Habit> mockHabits = [
  Habit(
    id: '1',
    name: 'Morning Workout',
    category: 'Health',
    description: '30 minutes of exercise',
    repeatDays: ['Sat', 'Mon', 'Wed', 'Fri'],
  ),
  Habit(
    id: '2',
    name: 'Reading',
    category: 'Personal Growth',
    description: 'Read 10 pages',
    repeatDays: ['Sat', 'Sun', 'Mon', 'Tue', 'Wed', 'Thu', 'Fri'],
    dailyTarget: 10,
  ),
  Habit(
    id: '3',
    name: 'Drink Water',
    category: 'Health',
    description: 'Drink 8 glasses of water',
    repeatDays: ['Sat', 'Sun', 'Mon', 'Tue', 'Wed', 'Thu', 'Fri'],
    dailyTarget: 8,
  ),
  Habit(
    id: '4',
    name: 'Learn English',
    category: 'Learning',
    description: 'Practice English for 20 minutes',
    repeatDays: ['Sun', 'Tue', 'Thu'],
  ),
];