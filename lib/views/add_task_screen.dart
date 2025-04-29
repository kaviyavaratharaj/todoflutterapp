import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/task_model.dart';
import '../viewmodels/task_viewmodel.dart';

class AddTaskScreen extends StatefulWidget {
  final TaskModel? editTask;

  const AddTaskScreen({super.key, this.editTask});

  @override
  State<AddTaskScreen> createState() => _AddTaskScreenState();
}

class _AddTaskScreenState extends State<AddTaskScreen> {
  var _titleController = TextEditingController();
  var _descriptionController = TextEditingController();


  @override
  void initState() {
    super.initState();
    _titleController = TextEditingController(text: widget.editTask?.title ?? '');
    _descriptionController = TextEditingController(text: widget.editTask?.description ?? '');
  }


  @override
  Widget build(BuildContext context) {
    var taskViewModel = Provider.of<TaskViewModel>(context, listen: false);
    final isEditing = widget.editTask != null;

    return Scaffold(
      appBar: AppBar(
        title: Text(isEditing ? 'Update Task' : 'Add New Task'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _titleController,
              decoration: const InputDecoration(labelText: 'Title'),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: _descriptionController,
              decoration: const InputDecoration(labelText: 'Description'),
            ),
            const SizedBox(height: 32),
            ElevatedButton(
              onPressed: () {
                if (isEditing) {
                  final updatedTask = widget.editTask!;
                  updatedTask.title = _titleController.text;
                  updatedTask.description = _descriptionController.text;

                  taskViewModel.updateTask(updatedTask);
                } else {
                  taskViewModel.addTask(
                    _titleController.text,
                    _descriptionController.text,
                  );
                }
                Navigator.pop(context);
              },
              child: Text(isEditing ? 'Update Task' : 'Add Task'),
            ),
          ],
        ),
      ),
    );
  }

}
