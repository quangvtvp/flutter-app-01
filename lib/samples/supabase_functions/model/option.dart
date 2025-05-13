class Option {
  final int id;
  final String content;

  Option({required this.id, required this.content});

  factory Option.fromJson(Map<String, dynamic> json) => Option(
        id: json['id'],
        content: json['content'],
      );
}
