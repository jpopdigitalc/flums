// models/models.dart


class User {
  final int id;
  final String username;
  final String role;
  final List<int> enrolledCourseIds;
  
  User({
    required this.id, 
    required this.username, 
    required this.role,
    List<int>? enrolledCourseIds,
  }) : enrolledCourseIds = enrolledCourseIds ?? [];
}

class Course {
  final int id;
  final String title;
  final String description;
  final List<Module> modules;
  
  Course({
    required this.id, 
    required this.title, 
    required this.description, 
    required this.modules
  });
}

class Module {
  final int id;
  final String title;
  final String content;
  bool completed;
  
  Module({
    required this.id, 
    required this.title, 
    required this.content, 
    this.completed = false
  });
}