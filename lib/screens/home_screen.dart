import 'package:flutter/material.dart';
import '../models/models.dart';
import '../data/mock_data.dart';
import '../widgets/course_card.dart';
import '../widgets/enrolled_course_card.dart';

class HomeScreen extends StatefulWidget {
  final User user;
  const HomeScreen({Key? key, required this.user}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late Set<int> enrolledCourses;
  Map<int, List<int>> moduleProgress = {};

  @override
  void initState() {
    super.initState();
    enrolledCourses = Set.from(widget.user.enrolledCourseIds);
    _initializeProgress();
  }

  void _initializeProgress() {
    for (var courseId in enrolledCourses) {
      moduleProgress[courseId] = [];
    }
  }

  void _toggleEnrollment(int courseId) {
    setState(() {
      if (enrolledCourses.contains(courseId)) {
        enrolledCourses.remove(courseId);
        moduleProgress.remove(courseId);
      } else {
        enrolledCourses.add(courseId);
        moduleProgress[courseId] = [];
      }
    });
  }

  void _updateModuleProgress(int courseId, int moduleId, bool completed) {
    setState(() {
      var modules = moduleProgress[courseId] ?? [];
      if (completed && !modules.contains(moduleId)) {
        modules.add(moduleId);
      } else if (!completed) {
        modules.remove(moduleId);
      }
      moduleProgress[courseId] = modules;
    });
  }

  @override
  Widget build(BuildContext context) {
    final enrolledCoursesList = mockCourses
        .where((c) => enrolledCourses.contains(c.id))
        .toList();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Available Courses'),
      ),
      body: Row(
        children: [
          // Enrolled courses drawer
          Container(
            width: 250,
            decoration: BoxDecoration(
              color: Colors.grey[100],
              border: Border(right: BorderSide(color: Colors.grey[300]!)),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.all(16),
                  child: Text(
                    'Enrolled Courses',
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                ),
                Expanded(
                  child: ListView.builder(
                    padding: const EdgeInsets.symmetric(horizontal: 8),
                    itemCount: enrolledCoursesList.length,
                    itemBuilder: (context, index) => EnrolledCourseCard(
                      course: enrolledCoursesList[index],
                      moduleProgress: moduleProgress,
                      onModuleProgressChanged: _updateModuleProgress,
                      onEnrollmentChanged: _toggleEnrollment,  // Add this line
                    ),
                  ),
                ),
              ],
            ),
          ),
          // Available courses grid
          Expanded(
            child: GridView.builder(
              padding: const EdgeInsets.all(16),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                childAspectRatio: 0.8,
                crossAxisSpacing: 16,
                mainAxisSpacing: 16,
              ),
              itemCount: mockCourses.length,
              itemBuilder: (context, index) => CourseCard(
                course: mockCourses[index],
                isEnrolled: enrolledCourses.contains(mockCourses[index].id),
                moduleProgress: moduleProgress,
                onEnrollmentChanged: _toggleEnrollment,
                onModuleProgressChanged: _updateModuleProgress,
              ),
            ),
          ),
        ],
      ),
    );
  }
}