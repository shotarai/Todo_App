import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import '../services/storage_service.dart';
import '../services/firestore_service.dart';
import '../services/ocr_service.dart';

class AddTaskScreen extends StatefulWidget {
  @override
  _AddTaskScreenState createState() => _AddTaskScreenState();
}

class _AddTaskScreenState extends State<AddTaskScreen> {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  DateTime? _dueDate;
  String? _imageUrl;
  File? _selectedImage;
  final StorageService _storageService = StorageService();
  final FirestoreService _firestoreService = FirestoreService();
  final OCRService _ocrService = OCRService();

  Future<void> _pickImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      File file = File(pickedFile.path);
      setState(() {
        _selectedImage = file;
      });

      // OCRでテキスト抽出
      String? extractedText = await _ocrService.extractTextFromImage();
      if (extractedText != null) {
        _descriptionController.text = extractedText;
      }
    }
  }

  Future<void> _saveTask() async {
    if (_titleController.text.isEmpty || _dueDate == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("タイトルと期日を入力してください")),
      );
      return;
    }

    if (_selectedImage != null) {
      _imageUrl = await _storageService.uploadImage();
    }

    await _firestoreService.addTask(
      "userId",
      _titleController.text,
      _descriptionController.text,
      _imageUrl,
      _dueDate!,
    );

    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("タスク追加")),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _titleController,
              decoration: InputDecoration(labelText: "タイトル"),
            ),
            TextField(
              controller: _descriptionController,
              decoration: InputDecoration(labelText: "説明"),
              maxLines: 3,
            ),
            SizedBox(height: 10),
            ElevatedButton(
              onPressed: _pickImage,
              child: Text("画像を選択"),
            ),
            _selectedImage != null
                ? Image.file(_selectedImage!, height: 150)
                : Container(),
            SizedBox(height: 10),
            ElevatedButton(
              onPressed: () async {
                DateTime? pickedDate = await showDatePicker(
                  context: context,
                  initialDate: DateTime.now(),
                  firstDate: DateTime.now(),
                  lastDate: DateTime(2101),
                );
                if (pickedDate != null) {
                  TimeOfDay? pickedTime = await showTimePicker(
                    context: context,
                    initialTime: TimeOfDay.now(),
                  );
                  if (pickedTime != null) {
                    setState(() {
                      _dueDate = DateTime(
                        pickedDate.year,
                        pickedDate.month,
                        pickedDate.day,
                        pickedTime.hour,
                        pickedTime.minute,
                      );
                    });
                  }
                }
              },
              child: Text(_dueDate == null
                  ? "期日を設定"
                  : "期日: ${_dueDate!.toLocal()}"),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _saveTask,
              child: Text("保存"),
            ),
          ],
        ),
      ),
    );
  }
}
