// screens/progress_dashboard.dart
import 'package:flutter/material.dart';
import '../models/models.dart';

class ProgressDashboard extends StatelessWidget {
  final List<Course> enrolledCourses;
  final Map<int, List<int>> completedModules;

  const ProgressDashboard({
    Key? key,
    required this.enrolledCourses,
    required this.completedModules,
  }) : super(key: key);

  double _calculateProgress(Course course) {
    final completed = completedModules[course.id]?.length ?? 0;
    return completed / course.modules.length;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('My Progress')),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          const Text(
            'Course Progress',
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 16),
          ...enrolledCourses.map((course) {
            final progress = _calculateProgress(course);
            return Card(
              margin: const EdgeInsets.only(bottom: 16),
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      course.title,
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 8),
                    LinearProgressIndicator(
                      value: progress,
                      minHeight: 10,
                    ),
                    const SizedBox(height: 8),
                    Text(
                      '${(progress * 100).toInt()}% Complete',
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    Text(
                      '${completedModules[course.id]?.length ?? 0}/${course.modules.length} modules completed',
                    ),
                  ],
                ),
              ),
            );
          }),
        ],
      ),
    );
  }
}