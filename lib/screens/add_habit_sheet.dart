
import 'package:flutter/material.dart';

import '../models/habit.dart';

class AddHabitSheet extends StatefulWidget {
  final Habit? habit;

  const AddHabitSheet({
    super.key,
    this.habit,
  });

  @override
  State<AddHabitSheet> createState() => _AddHabitSheetState();
}

class _AddHabitSheetState extends State<AddHabitSheet> {
  final _formKey = GlobalKey<FormState>();

  final _nameController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _targetController = TextEditingController();

  String _selectedCategory = 'Health';

  final List<String> _categories = [
    'Health',
    'Learning',
    'Personal Growth',
    'Productivity',
    'Other',
  ];

  final List<String> _weekDays = [
    'Sat',
    'Sun',
    'Mon',
    'Tue',
    'Wed',
    'Thu',
    'Fri',
  ];

  final Set<String> _selectedDays = {};

  bool get _isEditing => widget.habit != null;

  @override
  void initState() {
    super.initState();

    if (_isEditing) {
      final habit = widget.habit!;

      _nameController.text = habit.name;
      _descriptionController.text = habit.description;
      _targetController.text = habit.dailyTarget.toString();

      _selectedCategory = habit.category;
      _selectedDays.addAll(habit.repeatDays);
    } else {
      _targetController.text = '1';
    }
  }

  @override
  void dispose() {
    _nameController.dispose();
    _descriptionController.dispose();
    _targetController.dispose();
    super.dispose();
  }

  void _saveHabit() {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    if (_selectedDays.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please select at least one day.'),
        ),
      );
      return;
    }

    final originalHabit = widget.habit;

    final habit = Habit(
      id: originalHabit?.id ??
          DateTime.now().millisecondsSinceEpoch.toString(),
      name: _nameController.text.trim(),
      category: _selectedCategory,
      description: _descriptionController.text.trim(),
      repeatDays: _weekDays
          .where((day) => _selectedDays.contains(day))
          .toList(),
      dailyTarget: int.parse(_targetController.text),
      completedDates: originalHabit?.completedDates ?? [],
    );

    Navigator.pop(context, habit);
  }

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;

    final inputDecoration = InputDecoration(
      filled: true,
      fillColor: colors.surfaceContainerHighest,
      hintStyle: TextStyle(color: colors.onSurfaceVariant),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide(color: colors.outlineVariant),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide(color: colors.outlineVariant),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide(
          color: colors.primary,
          width: 1.5,
        ),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide(color: colors.error),
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide(color: colors.error, width: 1.5),
      ),
    );

    final labelStyle = TextStyle(
      color: colors.onSurface,
      fontWeight: FontWeight.w500,
    );

    return SafeArea(
      child: Padding(
        padding: EdgeInsets.only(
          left: 20,
          right: 20,
          top: 20,
          bottom: MediaQuery.of(context).viewInsets.bottom + 20,
        ),
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Center(
                  child: Container(
                    width: 40,
                    height: 4,
                    decoration: BoxDecoration(
                      color: colors.outlineVariant,
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),

                const SizedBox(height: 20),

                Text(
                  _isEditing ? 'Edit Habit' : 'Create New Habit',
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: colors.primary,
                  ),
                ),

                const SizedBox(height: 20),

                Text('Habit Name', style: labelStyle),

                const SizedBox(height: 8),

                TextFormField(
                  controller: _nameController,
                  style: TextStyle(color: colors.onSurface),
                  decoration: inputDecoration.copyWith(
                    hintText: 'e.g. Morning Workout',
                  ),
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return 'Please enter a habit name.';
                    }
                    return null;
                  },
                ),

                const SizedBox(height: 16),

                Text('Category', style: labelStyle),

                const SizedBox(height: 8),

                DropdownButtonFormField<String>(
                  value: _selectedCategory,
                  dropdownColor: colors.surfaceContainer,
                  style: TextStyle(color: colors.onSurface),
                  decoration: inputDecoration,
                  items: _categories.map((category) {
                    return DropdownMenuItem(
                      value: category,
                      child: Text(category),
                    );
                  }).toList(),
                  onChanged: (value) {
                    if (value != null) {
                      setState(() {
                        _selectedCategory = value;
                      });
                    }
                  },
                ),

                const SizedBox(height: 16),

                Text('Description', style: labelStyle),

                const SizedBox(height: 8),

                TextFormField(
                  controller: _descriptionController,
                  style: TextStyle(color: colors.onSurface),
                  decoration: inputDecoration.copyWith(
                    hintText: 'Describe your habit',
                  ),
                ),

                const SizedBox(height: 16),

                Text('Repeat On', style: labelStyle),

                const SizedBox(height: 10),

                Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  children: _weekDays.map((day) {
                    final isSelected = _selectedDays.contains(day);

                    return FilterChip(
                      label: Text(day),
                      selected: isSelected,
                      selectedColor: colors.primaryContainer,
                      checkmarkColor: colors.onPrimaryContainer,
                      backgroundColor: colors.surfaceContainerHighest,
                      labelStyle: TextStyle(
                        color: isSelected
                            ? colors.onPrimaryContainer
                            : colors.onSurface,
                      ),
                      side: BorderSide(
                        color: colors.outlineVariant,
                      ),
                      onSelected: (selected) {
                        setState(() {
                          if (selected) {
                            _selectedDays.add(day);
                          } else {
                            _selectedDays.remove(day);
                          }
                        });
                      },
                    );
                  }).toList(),
                ),

                const SizedBox(height: 16),

                Text('Daily Target', style: labelStyle),

                const SizedBox(height: 8),

                TextFormField(
                  controller: _targetController,
                  keyboardType: TextInputType.number,
                  style: TextStyle(color: colors.onSurface),
                  decoration: inputDecoration.copyWith(
                    hintText: 'Enter your daily target',
                  ),
                  validator: (value) {
                    final target = int.tryParse(value ?? '');

                    if (target == null || target <= 0) {
                      return 'Enter a number greater than zero.';
                    }

                    return null;
                  },
                ),

                const SizedBox(height: 24),

                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: _saveHabit,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: colors.primary,
                      foregroundColor: colors.onPrimary,
                      padding: const EdgeInsets.all(16),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    child: Text(
                      _isEditing ? 'Save Changes' : 'Save Habit',
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
