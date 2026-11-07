
import 'package:flutter/material.dart';

class WeeklyCalendar extends StatelessWidget {
  final String selectedDay;
  final ValueChanged<String> onDaySelected;

  const WeeklyCalendar({
    super.key,
    required this.selectedDay,
    required this.onDaySelected,
  });

  static const List<String> days = [
    'Sat', 'Sun', 'Mon', 'Tue', 'Wed', 'Thu', 'Fri',
  ];

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;

    final today = DateTime.now();

    final daysSinceSaturday = (today.weekday + 1) % 7;

    final saturday = DateTime(
      today.year,
      today.month,
      today.day,
    ).subtract(Duration(days: daysSinceSaturday));

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: List.generate(days.length, (index) {
        final day = days[index];

        final date = saturday.add(
          Duration(days: index),
        );

        final isSelected = selectedDay == day;

        final isToday =
            date.year == today.year &&
            date.month == today.month &&
            date.day == today.day;

        return Expanded(
          child: Center(
            child: InkWell(
              borderRadius: BorderRadius.circular(24),
              onTap: () => onDaySelected(day),
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  vertical: 6,
                  horizontal: 2,
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      day,
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: isSelected
                            ? FontWeight.bold
                            : FontWeight.normal,
                        color: isSelected
                            ? colors.primary
                            : colors.onSurfaceVariant,
                      ),
                    ),

                    const SizedBox(height: 8),

                    AnimatedContainer(
                      duration: const Duration(milliseconds: 200),
                      width: 36,
                      height: 36,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        color: isSelected
                            ? colors.primary
                            : colors.surfaceContainerHighest,
                        shape: BoxShape.circle,
                        border: isToday && !isSelected
                            ? Border.all(
                                color: colors.primary,
                                width: 1.5,
                              )
                            : null,
                      ),
                      child: Text(
                        date.day.toString(),
                        style: TextStyle(
                          color: isSelected
                              ? colors.onPrimary
                              : colors.onSurface,
                          fontWeight: FontWeight.bold,
                          fontSize: 13,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      }),
    );
  }
}
