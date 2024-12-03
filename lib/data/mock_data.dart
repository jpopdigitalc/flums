import '../models/models.dart';

final mockUsers = [
  User(
    id: 1, 
    username: 'student1', 
    role: 'student',
    enrolledCourseIds: [1]  // Currently only enrolled in course ID 1
  ),
  User(
    id: 2, 
    username: 'instructor1', 
    role: 'instructor',
    enrolledCourseIds: []
  ),
];

final mockCourses = [
  Course(
    id: 1,
    title: 'Flutter Development',
    description: 'Learn to build mobile apps with Flutter',
    modules: [
      Module(
        id: 1,
        title: 'Getting Started',
        content: 'Introduction to Flutter development environment'
      ),
      Module(
        id: 2,
        title: 'Basic Widgets',
        content: 'Understanding fundamental Flutter widgets'
      ),
    ],
  ),
  Course(
    id: 2,
    title: 'Mobile UI Design',
    description: 'Master the art of mobile interface design',
    modules: [
      Module(
        id: 1,
        title: 'Design Principles',
        content: 'Core principles of mobile UI design'
      ),
    ],
  ),
  Course(
    id: 3,
    title: 'Backend Development',
    description: 'Learn server-side programming with Node.js',
    modules: [
      Module(
        id: 1,
        title: 'Node.js Basics',
        content: 'Introduction to Node.js and its core concepts'
      ),
      Module(
        id: 2,
        title: 'Express Framework',
        content: 'Building web applications with Express.js'
      ),
    ],
  ),
  Course(
    id: 4,
    title: 'Data Structures',
    description: 'Master fundamental data structures and algorithms',
    modules: [
      Module(
        id: 1,
        title: 'Arrays and Lists',
        content: 'Understanding basic data structures'
      ),
      Module(
        id: 2,
        title: 'Trees and Graphs',
        content: 'Advanced data structures'
      ),
    ],
  ),
  Course(
    id: 5,
    title: 'Web Development',
    description: 'Learn modern web development',
    modules: [
      Module(
        id: 1,
        title: 'HTML & CSS',
        content: 'Building blocks of web pages'
      ),
      Module(
        id: 2,
        title: 'JavaScript',
        content: 'Making websites interactive'
      ),
    ],
  ),
];