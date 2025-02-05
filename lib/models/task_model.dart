class Task {
  final String id;
  final String userId;
  final String title;
  final String description;
  final String? imageUrl;
  final DateTime dueDate;

  Task({
    required this.id,
    required this.userId,
    required this.title,
    required this.description,
    this.imageUrl,
    required this.dueDate,
  });

  factory Task.fromMap(String id, Map<String, dynamic> data) {
    return Task(
      id: id,
      userId: data['userId'],
      title: data['title'],
      description: data['description'],
      imageUrl: data['imageUrl'],
      dueDate: DateTime.parse(data['dueDate']),
    );
  }
}
