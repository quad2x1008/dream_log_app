class Dream {
  final String id;
  final String title;
  final String description;
  final String mood;
  final DateTime date;

  Dream({
    required this.id,
    required this.title,
    required this.description,
    required this.mood,
    required this.date,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'mood': mood,
      'date': date.toIso8601String(),
    };
  }

  factory Dream.fromMap(Map<String, dynamic> map) {
    return Dream(
      id: map['id'] ?? '',
      title: map['title'] ?? '',
      description: map['description'] ?? '',
      mood: map['mood'] ?? '',
      date: DateTime.parse(map['date']),
    );
  }
}
