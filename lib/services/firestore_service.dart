import 'package:cloud_firestore/cloud_firestore.dart';

class FirestoreService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  // タスクを Firestore に追加
  Future<void> addTask(String userId, String title, String description, String? imageUrl, DateTime dueDate) async {
    await _db.collection("tasks").add({
      "userId": userId,
      "title": title,
      "description": description,
      "imageUrl": imageUrl,
      "dueDate": dueDate.toIso8601String(),
      "createdAt": FieldValue.serverTimestamp(),
    });
  }

  // タスク一覧を取得**
  Stream<QuerySnapshot> getTasks() {
    return _db.collection("tasks").orderBy("dueDate").snapshots();
  }

  // タスクを削除**
  Future<void> deleteTask(String taskId) async {
    await _db.collection("tasks").doc(taskId).delete();
  }
}
