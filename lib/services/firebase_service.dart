import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/task_model.dart';

class FirebaseService {
  final _firestore = FirebaseFirestore.instance;

  Stream<List<TaskModel>> getTasks(String userEmail) {
    return _firestore.collection('tasks')
      .where('sharedWith', arrayContains: userEmail)
      .orderBy('updatedAt', descending: true)
      .snapshots()
      .map((snapshot) => snapshot.docs.map((doc) => TaskModel.fromJson(doc.data())).toList());
  }

  Future<void> addTask(TaskModel task) async {
    await _firestore.collection('tasks').doc(task.id).set(task.toJson());
  }

  Future<void> updateTask(TaskModel task) async {
    await _firestore.collection('tasks').doc(task.id).update(task.toJson());
  }

  Future<void> deleteTask(String taskId) async {
    await _firestore.collection('tasks').doc(taskId).delete();
  }
}
