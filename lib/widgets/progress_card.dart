
import 'package:flutter/material.dart';

class ProgressCard extends StatelessWidget {
  final int completed;
  final int total;

  const ProgressCard({
    super.key,
    required this.completed,
    required this.total,
  });

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;

    final progress = total == 0
        ? 0.0
        : completed / total;

    final percentage = (progress * 100).round();

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: colors.surface,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: colors.outlineVariant,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Daily Progress',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: colors.primary,
                ),
              ),
              Text(
                '$percentage%',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: colors.primary,
                ),
              ),
            ],
          ),

          const SizedBox(height: 16),

          Text(
            '$completed / $total Habits completed',
            style: TextStyle(
              fontSize: 14,
              color: colors.onSurface,
            ),
          ),

          const SizedBox(height: 12),

          ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: LinearProgressIndicator(
              value: progress,
              backgroundColor: colors.surfaceContainerHighest,
              color: colors.primary,
              minHeight: 9,
            ),
          ),

          if (total == 0) ...[
            const SizedBox(height: 10),
            Text(
              'No habits scheduled for this day.',
              style: TextStyle(
                fontSize: 12,
                color: colors.onSurfaceVariant,
              ),
            ),
          ],
        ],
      ),
    );
  }
}
