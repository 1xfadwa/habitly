class Habit {
  final String id;
  final String name;
  final String category;
  final String description;
  final List<String> repeatDays;
  final int dailyTarget;
  final List<String> completedDates;

  const Habit({
    required this.id,
    required this.name,
    required this.category,
    required this.description,
    required this.repeatDays,
    this.dailyTarget = 1,
    this.completedDates = const [],
  });

  bool isCompletedOn(String date) {
    return completedDates.contains(date);
  }

  Habit copyWith({
    String? name,
    String? category,
    String? description,
    List<String>? repeatDays,
    int? dailyTarget,
    List<String>? completedDates,
  }) {
    return Habit(
      id: id,
      name: name ?? this.name,
      category: category ?? this.category,
      description: description ?? this.description,
      repeatDays: repeatDays ?? this.repeatDays,
      dailyTarget: dailyTarget ?? this.dailyTarget,
      completedDates: completedDates ?? this.completedDates,
    );
  }

  // Convert Habit object into JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'category': category,
      'description': description,
      'repeatDays': repeatDays,
      'dailyTarget': dailyTarget,
      'completedDates': completedDates,
    };
  }

  // Create Habit object from JSON
  factory Habit.fromJson(Map<String, dynamic> json) {
    return Habit(
      id: json['id'] as String,
      name: json['name'] as String,
      category: json['category'] as String,
      description: json['description'] as String,
      repeatDays: List<String>.from(json['repeatDays']),
      dailyTarget: json['dailyTarget'] as int? ?? 1,
      completedDates: List<String>.from(
        json['completedDates'] ?? [],
      ),
    );
  }
}