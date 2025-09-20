import 'package:flutter/material.dart';
import 'icon_label.dart';

class StatefulTaskCard extends StatefulWidget {
  final String title;
  final String description;
  final String priority;
  final String? dueDate;
  final String? assignee;

  const StatefulTaskCard({
    super.key,
    required this.title,
    required this.description,
    required this.priority,
    this.dueDate,
    this.assignee,
  });

  @override
  State<StatefulTaskCard> createState() => _StatefulTaskCardState();
}

class _StatefulTaskCardState extends State<StatefulTaskCard> {
  bool isDone = false;

  @override
  Widget build(BuildContext context) {
    Color priorityColor;
    switch (widget.priority.toLowerCase()) {
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
            // Priority badge
            Align(
              alignment: Alignment.topLeft,
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: priorityColor,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text(
                  widget.priority,
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 8),

            // Title + Checkbox
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Text(
                    widget.title,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                      decoration:
                          isDone ? TextDecoration.lineThrough : null,
                      color: isDone ? Colors.grey : null,
                    ),
                  ),
                ),
                Checkbox(
                  value: isDone,
                  onChanged: (val) {
                    setState(() {
                      isDone = val ?? false;
                    });
                  },
                ),
              ],
            ),

            const SizedBox(height: 4),

            // Description
            Text(
              widget.description,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                decoration: isDone ? TextDecoration.lineThrough : null,
                color: isDone ? Colors.grey : null,
              ),
            ),

            const SizedBox(height: 8),

            // Due date and assignee
            Row(
              children: [
                if (widget.dueDate != null)
                  IconLabel(
                      icon: Icons.access_time,
                      label: widget.dueDate!,
                      color: priorityColor),
                if (widget.assignee != null) ...[
                  const SizedBox(width: 12),
                  IconLabel(
                      icon: Icons.person,
                      label: widget.assignee!,
                      color: priorityColor),
                ],
              ],
            ),
          ],
        ),
      ),
    );
  }
}
