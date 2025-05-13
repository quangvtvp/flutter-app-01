// Defines model classes
class Subject {
  final int id;
  final String name;
  final int totalExams;

  Subject({required this.id, required this.name, required this.totalExams});

  factory Subject.fromJson(Map<String, dynamic> json) => Subject(
        id: json['id'],
        name: json['name'],
        totalExams: json['total_exams'] ?? 0,
      );
}
