import 'package:flutter/material.dart';
import '../models/models.dart';
import '../screens/course_detail_screen.dart';

class CourseCard extends StatelessWidget {
  final Course course;
  final bool isEnrolled;
  final Map<int, List<int>> moduleProgress;
  final Function(int) onEnrollmentChanged;
  final Function(int, int, bool) onModuleProgressChanged;

  const CourseCard({
    Key? key,
    required this.course,
    required this.isEnrolled,
    required this.moduleProgress,
    required this.onModuleProgressChanged,
    required this.onEnrollmentChanged,
  }) : super(key: key);

  IconData _getCourseIcon() {
    final title = course.title.toLowerCase();
    if (title.contains('flutter') || title.contains('mobile')) return Icons.smartphone;
    if (title.contains('web')) return Icons.web;
    if (title.contains('backend')) return Icons.storage;
    if (title.contains('data')) return Icons.data_array;
    if (title.contains('design')) return Icons.palette;
    return Icons.code;
  }

  @override
  Widget build(BuildContext context) {
    final progress = moduleProgress[course.id]?.length ?? 0;
    final totalModules = course.modules.length;
    final progressPercent = totalModules > 0 ? (progress / totalModules * 100).toInt() : 0;

    return Card(
      elevation: 4,
      child: InkWell(
        onTap: isEnrolled ? () => Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => CourseDetailScreen(
              course: course,
              completedModules: moduleProgress[course.id] ?? [],
              onModuleProgressChanged: onModuleProgressChanged,
            ),
          ),
        ) : null,
        child: Stack(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  height: 100,
                  decoration: BoxDecoration(
                    color: isEnrolled 
                      ? Colors.green[600]
                      : Theme.of(context).primaryColor,
                    borderRadius: const BorderRadius.vertical(
                      top: Radius.circular(4),
                    ),
                  ),
                  child: Stack(
                    children: [
                      Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              _getCourseIcon(),
                              size: 48,
                              color: Colors.white,
                            ),
                            if (isEnrolled) ...[
                              const SizedBox(height: 4),
                              Text(
                                '$progressPercent%',
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ],
                        ),
                      ),
                      if (isEnrolled)
                        Positioned(
                          bottom: 0,
                          left: 0,
                          right: 0,
                          child: LinearProgressIndicator(
                            value: progress / totalModules,
                            backgroundColor: Colors.white24,
                            valueColor: const AlwaysStoppedAnimation<Color>(Colors.white),
                          ),
                        ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        course.title,
                        style: Theme.of(context).textTheme.titleMedium,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(height: 8),
                      Text(
                        course.description,
                        style: Theme.of(context).textTheme.bodySmall,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                      if (isEnrolled) ...[
                        const SizedBox(height: 8),
                        Row(
                          children: [
                            Icon(
                              Icons.library_books,
                              size: 16,
                              color: Theme.of(context).textTheme.bodySmall?.color,
                            ),
                            const SizedBox(width: 4),
                            Text(
                              '${progress}/${totalModules} modules completed',
                              style: Theme.of(context).textTheme.bodySmall,
                            ),
                          ],
                        ),
                      ],
                    ],
                  ),
                ),
              ],
            ),
            if (!isEnrolled)
              Positioned(
                bottom: 16,
                right: 16,
                child: ElevatedButton.icon(
                  onPressed: () => onEnrollmentChanged(course.id),
                  icon: const Icon(Icons.add_circle_outline),
                  label: const Text('Enroll Now'),
                ),
              ),
          ],
        ),
      ),
    );
  }
}