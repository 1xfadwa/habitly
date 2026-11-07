
import 'package:flutter/material.dart';

class HabitCard extends StatelessWidget {
  final String title;
  final String description;
  final IconData icon;
  final bool isCompleted;
  final VoidCallback onToggle;
  final int streak;

  const HabitCard({
    super.key,
    required this.title,
    required this.description,
    required this.icon,
    required this.isCompleted,
    required this.onToggle,
    this.streak = 0,
  });

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;

    return AnimatedContainer(
      duration: const Duration(milliseconds: 200),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: colors.surface,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: isCompleted
              ? colors.primary.withValues(alpha: 0.35)
              : colors.outlineVariant,
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
              icon,
              color: colors.onPrimaryContainer,
            ),
          ),

          const SizedBox(width: 12),

          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 15,
                    color: colors.onSurface,
                  ),
                ),

                const SizedBox(height: 4),

                Text(
                  description,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontSize: 12,
                    color: colors.onSurfaceVariant,
                  ),
                ),

                const SizedBox(height: 8),

                Row(
                  children: [
                    Icon(
                      isCompleted
                          ? Icons.check_circle
                          : Icons.radio_button_unchecked,
                      size: 14,
                      color: isCompleted
                          ? colors.primary
                          : colors.onSurfaceVariant,
                    ),
                    const SizedBox(width: 5),
                    Text(
                      isCompleted ? 'Completed' : 'Not completed',
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                        color: isCompleted
                            ? colors.primary
                            : colors.onSurfaceVariant,
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 6),

                Row(
                  children: [
                    Icon(
                      Icons.local_fire_department,
                      size: 16,
                      color: colors.secondary,
                    ),
                    const SizedBox(width: 4),
                    Text(
                      '$streak day streak',
                      style: TextStyle(
                        fontSize: 12,
                        color: colors.onSurfaceVariant,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),

          const SizedBox(width: 4),

          IconButton(
            tooltip: isCompleted
                ? 'Mark as incomplete'
                : 'Mark as completed',
            onPressed: onToggle,
            icon: Icon(
              isCompleted
                  ? Icons.check_circle
                  : Icons.circle_outlined,
              color: isCompleted
                  ? colors.primary
                  : colors.onSurfaceVariant,
              size: 28,
            ),
          ),
        ],
      ),
    );
  }
}
