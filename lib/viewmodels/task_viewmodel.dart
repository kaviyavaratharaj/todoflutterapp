import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';
import '../models/task_model.dart';
import '../services/firebase_service.dart';

class TaskViewModel with ChangeNotifier {
  final FirebaseService _service = FirebaseService();
  String userEmail = 'test@example.com';

  Stream<List<TaskModel>> get tasks => _service.getTasks(userEmail);

  Future<void> addTask(String title, String description) async {
    var task = TaskModel(
      id: const Uuid().v4(),
      title: title,
      description: description,
      ownerEmail: userEmail,
      sharedWith: [userEmail],
      isDone: false,
      updatedAt: DateTime.now(),
    );
    await _service.addTask(task);
  }

  Future<void> updateTask(TaskModel task) async {
    await _service.updateTask(task);
  }

  void toggleTaskStatus(TaskModel task) {
    task.isDone = !task.isDone;
    updateTask(task);
  }

  Future<void> deleteTask(TaskModel task) async {
    await _service.deleteTask(task.id);
    notifyListeners();
  }

}
