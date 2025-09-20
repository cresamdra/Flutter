import 'package:flutter/material.dart';
import 'widgets/stateful_task_card.dart';
import 'widgets/add_task_modal.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool isDarkMode = false;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Task App',
      themeMode: isDarkMode ? ThemeMode.dark : ThemeMode.light,
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blueAccent),
        brightness: Brightness.light,
      ),
      darkTheme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.blueAccent,
          brightness: Brightness.dark,
        ),
        brightness: Brightness.dark,
      ),
      home: TaskHomePage(
        isDarkMode: isDarkMode,
        onThemeToggle: () {
          setState(() {
            isDarkMode = !isDarkMode;
          });
        },
      ),
    );
  }
}

class TaskHomePage extends StatefulWidget {
  final bool isDarkMode;
  final VoidCallback onThemeToggle;

  const TaskHomePage({
    super.key,
    required this.isDarkMode,
    required this.onThemeToggle,
  });

  @override
  State<TaskHomePage> createState() => _TaskHomePageState();
}

class _TaskHomePageState extends State<TaskHomePage> {
  // Task list
  final List<Map<String, String>> tasks = [
    {
      'title': 'Finish Flutter exercise',
      'description': 'Complete the widget personalization and state management tasks.',
      'priority': 'High',
      'dueDate': 'Today',
      'assignee': 'You',
    },
    {
      'title': 'Read Flutter docs',
      'description': 'Review widget fundamentals and state management.',
      'priority': 'Medium',
      'dueDate': 'Tomorrow',
      'assignee': 'You',
    },
    {
      'title': 'Group report professional communication',
      'description': 'Participate and review the report',
      'priority': 'High',
      'dueDate': 'Sept. 19, 2025',
      'assignee': 'Group',
    },
    {
      'title': 'Assignment 1 Soft Eng.',
      'description': 'Answer the ff. and submit on step s',
      'priority': 'Medium',
      'dueDate': 'Sept. 19, 2025',
      'assignee': 'You',
    },
    {
      'title': 'Group project Information Management',
      'description': 'Interview someone with business and create a database',
      'priority': 'Medium',
      'dueDate': 'Sept. 29, 2025',
      'assignee': 'Group',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Tasks'),
        actions: [
          IconButton(
            icon: Icon(widget.isDarkMode ? Icons.dark_mode : Icons.light_mode),
            onPressed: widget.onThemeToggle,
          ),
        ],
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: tasks.length,
        itemBuilder: (context, index) {
          final task = tasks[index];
          return StatefulTaskCard(
            title: task['title']!,
            description: task['description']!,
            priority: task['priority']!,
            dueDate: task['dueDate'],
            assignee: task['assignee'],
          );
        },
      ),
      floatingActionButton: Builder(
        builder: (context) => FloatingActionButton(
          onPressed: () async {
            final newTask = await showModalBottomSheet<Map<String, String>>(
              context: context,
              isScrollControlled: true,
              builder: (context) => const AddTaskModal(),
            );
            if (newTask != null) {
              setState(() {
                tasks.add(newTask);
              });
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text("Task '${newTask['title']}' added!")),
              );
            }
          },
          child: const Icon(Icons.add),
        ),
      ),
    );
  }
}
