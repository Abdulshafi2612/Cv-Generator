// lib/models/course_model.dart

/// Model representing a single course entry
class CourseModel {
  /// Location or institution where the course was taken
  final String place;

  /// Date or period of the course (e.g., "June 2024" or "2023-2024")
  final String date;

  /// Name or title of the course
  final String course;

  CourseModel({
    required this.place,
    required this.date,
    required this.course,
  });

}

