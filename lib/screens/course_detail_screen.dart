// screens/course_detail_screen.dart
import 'package:flutter/material.dart';
import '../models/models.dart';

class CourseDetailScreen extends StatelessWidget {
  final Course course;
  final List<int> completedModules;
  final Function(int, int, bool) onModuleProgressChanged;

  const CourseDetailScreen({
    Key? key,
    required this.course,
    required this.completedModules,
    required this.onModuleProgressChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(course.title)),
      body: ListView.builder(
        itemCount: course.modules.length,
        itemBuilder: (context, index) {
          final module = course.modules[index];
          final isCompleted = completedModules.contains(module.id);

          return Card(
            margin: const EdgeInsets.all(8.0),
            child: ExpansionTile(
              title: Row(
                children: [
                  Text(module.title),
                  if (isCompleted)
                    const Icon(Icons.check_circle, color: Colors.green),
                ],
              ),
              children: [
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(module.content),
                      const SizedBox(height: 16),
                      ElevatedButton(
                        onPressed: () => onModuleProgressChanged(
                          course.id,
                          module.id,
                          !isCompleted,
                        ),
                        child: Text(
                          isCompleted ? 'Mark Incomplete' : 'Mark Complete',
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}