
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'app.dart';
import 'providers/habit_provider.dart';
import 'providers/settings_provider.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final habitProvider = HabitProvider();

  await habitProvider.loadHabits();

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider.value(
          value: habitProvider,
        ),
        ChangeNotifierProvider(
          create: (_) => SettingsProvider(),
        ),
      ],
      child: const HabitlyApp(),
    ),
  );
}


// import 'package:flutter/material.dart';

// void main() {
//   runApp(const MyApp());
// }

// class MyApp extends StatelessWidget {
//   const MyApp({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'Habitly',
//       theme: ThemeData(
//         colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFF344E41)),
//       ),
//       home: const MyHomePage(title: 'Habitly'),
//     );
//   }
// }

// class MyHomePage extends StatefulWidget {
//   const MyHomePage({super.key, required this.title});

//   final String title;

//   @override
//   State<MyHomePage> createState() => _MyHomePageState();
// }

// class _MyHomePageState extends State<MyHomePage> {
//   Map<String, bool> _completedDays = {};
//   String _selectedDay = 'Sat';
//   List<String> _workoutDays = ['Sat', 'Mon', 'Wed', 'Fri'];
//   int _selectedIndex = 0;

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: const Color(0xFFF7F6F2),
//       body: IndexedStack(
//         index: _selectedIndex,
//         children: [
//           SafeArea(
//             child: Padding(
//               padding: const EdgeInsets.all(20),
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   const Text(
//                     'Good Morning!',
//                     style: TextStyle(
//                       fontSize: 24,
//                       fontWeight: FontWeight.bold,
//                       color: Color(0xFF344E41),
//                     ),
//                   ),
//                   const SizedBox(height: 8),
//                   const Text(
//                     'Build better habits, one day at a time.',
//                     style: TextStyle(fontSize: 14, color: Color(0xFF7B7B7B)),
//                   ),

//                   // Weekly Progress
//                   const SizedBox(height: 24),
//                   Container(
//                     width: double.infinity,
//                     padding: const EdgeInsets.all(16),
//                     decoration: BoxDecoration(
//                       color: Colors.white,
//                       borderRadius: BorderRadius.circular(16),
//                     ),
//                     child: Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         Text(
//                           'Weekly Progress',
//                           style: TextStyle(
//                             fontSize: 18,
//                             fontWeight: FontWeight.bold,
//                             color: Color(0xFF344E41),
//                           ),
//                         ),
//                         SizedBox(height: 16),
//                         Text(
//                           '${_completedDays.values.where((completed) => completed).length} / ${_workoutDays.length} Habits completed',
//                           style: TextStyle(fontSize: 14),
//                         ),
//                         const SizedBox(height: 12),
//                         LinearProgressIndicator(
//                           value: _workoutDays.isEmpty
//                               ? 0
//                               : _completedDays.values
//                                         .where((completed) => completed)
//                                         .length /
//                                     _workoutDays.length,
//                           backgroundColor: const Color(0xFFE8EBDD),
//                           color: const Color(0xFF344E41),
//                           minHeight: 8,
//                           borderRadius: BorderRadius.circular(10),
//                         ),
//                       ],
//                     ),
//                   ),

//                   // Weekly Calendar
//                   const SizedBox(height: 16),
//                   Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                     children: [
//                       _buildDay('Sat', '7'),
//                       _buildDay('Sun', '8'),
//                       _buildDay('Mon', '9'),
//                       _buildDay('Tue', '10'),
//                       _buildDay('Wed', '11'),
//                       _buildDay('Thu', '12'),
//                       _buildDay('Fri', '13'),
//                     ],
//                   ),
//                   // Today's Habits
//                   const SizedBox(height: 24),
//                   Text(
//                     _selectedDay == 'Sat'
//                         ? "Saturday's Habits"
//                         : "$_selectedDay's Habits",
//                     style: TextStyle(
//                       fontSize: 18,
//                       fontWeight: FontWeight.bold,
//                       color: Color(0xFF344E41),
//                     ),
//                   ),
//                   const SizedBox(height: 16),
//                   // Habit Card
//                   if (_workoutDays.contains(_selectedDay))
//                     Container(
//                       padding: const EdgeInsets.all(16),
//                       decoration: BoxDecoration(
//                         color: Colors.white,
//                         borderRadius: BorderRadius.circular(16),
//                       ),
//                       child: Row(
//                         children: [
//                           Container(
//                             width: 48,
//                             height: 48,
//                             decoration: BoxDecoration(
//                               color: const Color(0xFFE8EBDD),
//                               borderRadius: BorderRadius.circular(12),
//                             ),
//                             child: const Icon(
//                               Icons.fitness_center,
//                               color: Color(0xFF344E41),
//                             ),
//                           ),
//                           const SizedBox(width: 12),
//                           Expanded(
//                             child: Column(
//                               crossAxisAlignment: CrossAxisAlignment.start,
//                               children: [
//                                 const Text(
//                                   'Morning Workout',
//                                   style: TextStyle(
//                                     fontWeight: FontWeight.bold,
//                                     fontSize: 15,
//                                   ),
//                                 ),
//                                 const SizedBox(height: 4),
//                                 const Text(
//                                   '30 minutes · Health',
//                                   style: TextStyle(
//                                     fontSize: 12,
//                                     color: Colors.grey,
//                                   ),
//                                 ),
//                                 const SizedBox(height: 6),
//                                 Text(
//                                   (_completedDays[_selectedDay] ?? false)
//                                       ? 'Completed'
//                                       : 'Not completed',
//                                   style: TextStyle(
//                                     fontSize: 12,
//                                     color:
//                                         (_completedDays[_selectedDay] ?? false)
//                                         ? const Color(0xFF71865B)
//                                         : Colors.grey,
//                                   ),
//                                 ),
//                               ],
//                             ),
//                           ),

//                           IconButton(
//                             tooltip: _completedDays[_selectedDay] ?? false
//                                 ? 'Mark as incomplete'
//                                 : 'Mark as completed',
//                             onPressed: () {
//                               final isNowCompleted =
//                                   !(_completedDays[_selectedDay] ?? false);

//                               setState(() {
//                                 _completedDays[_selectedDay] = isNowCompleted;
//                               });

//                               ScaffoldMessenger.of(context).showSnackBar(
//                                 SnackBar(
//                                   content: Text(
//                                     isNowCompleted
//                                         ? 'Habit completed!'
//                                         : 'Habit marked as incomplete.',
//                                   ),
//                                   duration: const Duration(seconds: 1),
//                                 ),
//                               );
//                             },
//                             icon: Icon(
//                               (_completedDays[_selectedDay] ?? false)
//                                   ? Icons.check_circle
//                                   : Icons.circle_outlined,
//                               color: (_completedDays[_selectedDay] ?? false)
//                                   ? const Color(0xFFA3B18A)
//                                   : Colors.grey,
//                               size: 28,
//                             ),
//                           ),
//                         ],
//                       ),
//                     )
//                   else
//                     const Text(
//                       'No habits scheduled for this day.',
//                       style: TextStyle(fontSize: 14, color: Colors.grey),
//                     ),
//                 ],
//               ),
//             ),
//           ),
//           const Center(child: Text('Statistics')),
//           const Center(child: Text('My Habits')),
//           const Center(child: Text('Settings')),
//         ],
//       ),
//       bottomNavigationBar: BottomNavigationBar(
//         currentIndex: _selectedIndex,
//         onTap: (index) {
//           setState(() {
//             _selectedIndex = index;
//           });
//         },
//         type: BottomNavigationBarType.fixed,
//         selectedItemColor: const Color(0xFF344E41),
//         unselectedItemColor: Colors.grey,
//         items: const [
//           BottomNavigationBarItem(
//             icon: Icon(Icons.home_outlined),
//             activeIcon: Icon(Icons.home),
//             label: 'Home',
//           ),
//           BottomNavigationBarItem(
//             icon: Icon(Icons.bar_chart_outlined),
//             activeIcon: Icon(Icons.bar_chart),
//             label: 'Statistics',
//           ),
//           BottomNavigationBarItem(
//             icon: Icon(Icons.checklist_outlined),
//             activeIcon: Icon(Icons.checklist),
//             label: 'My Habits',
//           ),
//           BottomNavigationBarItem(
//             icon: Icon(Icons.settings_outlined),
//             activeIcon: Icon(Icons.settings),
//             label: 'Settings',
//           ),
//         ],
//       ),
//     );
//   }

//   Widget _buildDay(String day, String date) {
//     bool isSelected = _selectedDay == day;
//     return GestureDetector(
//       onTap: () {
//         setState(() {
//           _selectedDay = day;
//         });
//       },
//       child: Column(
//         children: [
//           Text(day, style: const TextStyle(fontSize: 12)),
//           const SizedBox(height: 8),
//           AnimatedContainer(
//             duration: const Duration(milliseconds: 200),
//             width: 36,
//             height: 36,
//             alignment: Alignment.center,
//             decoration: BoxDecoration(
//               color: isSelected
//                   ? const Color(0xFF344E41)
//                   : const Color(0xFFF1F0EB),
//               shape: BoxShape.circle,
//             ),
//             child: Text(
//               date,
//               style: TextStyle(
//                 color: isSelected ? Colors.white : const Color(0xFF344E41),
//                 fontWeight: FontWeight.bold,
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
