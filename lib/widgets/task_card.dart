import 'package:flutter/material.dart';
import '../screens/task_detail_screen.dart';

class TaskCard extends StatelessWidget {
  final String title;
  final String description;
  final String? imageUrl;
  final DateTime dueDate;

  TaskCard({
    required this.title,
    required this.description,
    this.imageUrl,
    required this.dueDate,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        leading: imageUrl != null ? Image.network(imageUrl!, width: 50, height: 50) : null,
        title: Text(title),
        subtitle: Text(description),
        trailing: Text("${dueDate.toLocal()}"),
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => TaskDetailScreen(
                title: title,
                description: description,
                imageUrl: imageUrl,
                dueDate: dueDate,
              ),
            ),
          );
        },
      ),
    );
  }
}
