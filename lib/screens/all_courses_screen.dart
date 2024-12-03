// lib/screens/all_courses_screen.dart
import 'package:flutter/material.dart';
import '../data/mock_data.dart';

class AllCoursesScreen extends StatelessWidget {
  final Set<int> enrolledCourses;
  final Function(int) onEnrollmentChanged;

  const AllCoursesScreen({
    Key? key, 
    required this.enrolledCourses,
    required this.onEnrollmentChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Available Courses')),
      body: ListView.builder(
        itemCount: mockCourses.length,
        itemBuilder: (context, index) {
          final course = mockCourses[index];
          final isEnrolled = enrolledCourses.contains(course.id);
          
          return ListTile(
            title: Text(course.title),
            subtitle: Text(course.description),
            trailing: IconButton(
              icon: Icon(
                isEnrolled ? Icons.check_circle : Icons.add_circle_outline,
                color: isEnrolled ? Colors.green : null,
              ),
              onPressed: () => onEnrollmentChanged(course.id),
            ),
          );
        },
      ),
    );
  }
}