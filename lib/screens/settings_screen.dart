
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/settings_provider.dart';
import '../theme/app_theme.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final settings = context.watch<SettingsProvider>();
    final isDark = settings.isDarkMode;

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Settings',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          const Text(
            'Preferences',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),

          const SizedBox(height: 14),

          _buildSettingCard(
            context,
            icon: Icons.dark_mode_outlined,
            title: 'Dark Mode',
            subtitle: 'Change the appearance of the app',
            trailing: Switch(
              value: isDark,
              activeColor: AppTheme.accent,
              onChanged: (value) {
                settings.toggleTheme(value);
              },
            ),
          ),

          const SizedBox(height: 28),

          const Text(
            'About',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),

          const SizedBox(height: 14),

          _buildSettingCard(
            context,
            icon: Icons.info_outline,
            title: 'About Habitly',
            subtitle: 'Learn more about Habitly',
            trailing: const Icon(Icons.chevron_right),
            onTap: () {
              showAboutDialog(
                context: context,
                applicationName: 'Habitly',
                applicationVersion: '1.0.0',
                applicationLegalese:
                    'Build better habits, one day at a time.',
              );
            },
          ),

          const SizedBox(height: 28),

          const Text(
            'Application',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),

          const SizedBox(height: 14),

          _buildSettingCard(
            context,
            icon: Icons.restart_alt,
            title: 'Reset Data',
            subtitle: 'Reset your application data',
            iconColor: Colors.redAccent,
            trailing: const Icon(Icons.chevron_right),
            onTap: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text(
                    'Reset feature will be available soon.',
                  ),
                ),
              );
            },
          ),

          const SizedBox(height: 32),

          Center(
            child: Text(
              'Habitly • Version 1.0.0',
              style: TextStyle(
                color: Theme.of(context).colorScheme.onSurface
                    .withValues(alpha: 0.5),
                fontSize: 12,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSettingCard(
    BuildContext context, {
    required IconData icon,
    required String title,
    required String subtitle,
    required Widget trailing,
    Color? iconColor,
    VoidCallback? onTap,
  }) {
    return Card(
      elevation: 0,
      color: Theme.of(context).colorScheme.surface,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 8,
        ),
        leading: Icon(
          icon,
          color: iconColor ??
              Theme.of(context).colorScheme.primary,
          size: 25,
        ),
        title: Text(
          title,
          style: const TextStyle(
            fontWeight: FontWeight.w600,
          ),
        ),
        subtitle: Text(subtitle),
        trailing: trailing,
        onTap: onTap,
      ),
    );
  }
}
