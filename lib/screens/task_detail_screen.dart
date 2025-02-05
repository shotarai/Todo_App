import 'package:flutter/material.dart';

class TaskDetailScreen extends StatelessWidget {
  final String title;
  final String description;
  final String? imageUrl;
  final DateTime dueDate;

  TaskDetailScreen({
    required this.title,
    required this.description,
    this.imageUrl,
    required this.dueDate,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("タスク詳細")),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(title, style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
            SizedBox(height: 10),
            imageUrl != null
                ? Image.network(imageUrl!, height: 200)
                : Container(),
            SizedBox(height: 10),
            Text(description, style: TextStyle(fontSize: 16)),
            SizedBox(height: 20),
            Text("期日: ${dueDate.toLocal()}",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
          ],
        ),
      ),
    );
  }
}
