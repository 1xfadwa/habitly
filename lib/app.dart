
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'theme/app_theme.dart';
import 'screens/main_screen.dart';
import 'providers/settings_provider.dart';

class HabitlyApp extends StatelessWidget {
  const HabitlyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<SettingsProvider>(
      builder: (context, settings, child) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Habitly',
          theme: AppTheme.lightTheme,
          darkTheme: AppTheme.darkTheme,
          themeMode: settings.isDarkMode
              ? ThemeMode.dark
              : ThemeMode.light,
          home: const MainScreen(),
        );
      },
    );
  }
}
