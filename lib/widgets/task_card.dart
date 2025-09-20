import 'package:flutter/material.dart';
import 'icon_label.dart';

class TaskCard extends StatelessWidget {
  final String title;
  final String description;
  final String priority;
  final String? dueDate;
  final String? assignee;

  const TaskCard({
    super.key,
    required this.title,
    required this.description,
    required this.priority,
    this.dueDate,
    this.assignee,
  });

  @override
  Widget build(BuildContext context) {
    Color priorityColor;
    switch (priority.toLowerCase()) {
      case 'high':
        priorityColor = Colors.red;
        break;
      case 'medium':
        priorityColor = Colors.orange;
        break;
      default:
        priorityColor = Colors.green;
    }

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Align(
              alignment: Alignment.topLeft,
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: priorityColor,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text(
                  priority,
                  style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                ),
              ),
            ),
            const SizedBox(height: 8),
            Text(title, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
            const SizedBox(height: 4),
            Text(description, maxLines: 2, overflow: TextOverflow.ellipsis),
            const SizedBox(height: 8),
            Row(
              children: [
                if (dueDate != null)
                  IconLabel(icon: Icons.access_time, label: dueDate!, color: priorityColor),
                if (assignee != null) ...[
                  const SizedBox(width: 12),
                  IconLabel(icon: Icons.person, label: assignee!, color: priorityColor),
                ],
              ],
            ),
          ],
        ),
      ),
    );
  }
}
