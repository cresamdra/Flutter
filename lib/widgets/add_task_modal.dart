import 'package:flutter/material.dart';

class AddTaskModal extends StatefulWidget {
  const AddTaskModal({super.key});

  @override
  State<AddTaskModal> createState() => _AddTaskModalState();
}

class _AddTaskModalState extends State<AddTaskModal> {
  final _titleController = TextEditingController();
  final _descController = TextEditingController();
  final _dueDateController = TextEditingController();
  String? selectedPriority = "Medium";

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        left: 16,
        right: 16,
        bottom: MediaQuery.of(context).viewInsets.bottom + 16,
        top: 16,
      ),
      child: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text(
              "Add Task",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 12),

            // Title
            TextField(
              controller: _titleController,
              decoration: const InputDecoration(labelText: "Task Title"),
            ),
            const SizedBox(height: 12),

            // Description
            TextField(
              controller: _descController,
              decoration: const InputDecoration(labelText: "Description"),
              maxLines: 2,
            ),
            const SizedBox(height: 12),

            // Due Date
            TextField(
              controller: _dueDateController,
              decoration: const InputDecoration(labelText: "Due Date (e.g. Sept. 20, 2025)"),
            ),
            const SizedBox(height: 12),

            // Priority
            DropdownButtonFormField<String>(
              value: selectedPriority,
              items: const [
                DropdownMenuItem(value: "High", child: Text("High")),
                DropdownMenuItem(value: "Medium", child: Text("Medium")),
                DropdownMenuItem(value: "Low", child: Text("Low")),
              ],
              onChanged: (value) {
                setState(() {
                  selectedPriority = value;
                });
              },
              decoration: const InputDecoration(labelText: "Priority"),
            ),
            const SizedBox(height: 16),

            // Submit Button
            ElevatedButton(
              onPressed: () {
                if (_titleController.text.isEmpty) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text("Please enter a task title")),
                  );
                  return;
                }

                // ✅ Gawa ng bagong task map
                final newTask = {
                  'title': _titleController.text,
                  'description': _descController.text,
                  'priority': selectedPriority ?? "Medium",
                  'dueDate': _dueDateController.text,
                  'assignee': 'You', // default for now
                };

                // ✅ Ibalik sa main.dart
                Navigator.pop(context, newTask);
              },
              child: const Text("Submit"),
            ),
          ],
        ),
      ),
    );
  }
}
