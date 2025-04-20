import 'package:cv_maker/models/course_model.dart';

class EducationModel {
  final String university;
  final String faculty;
  final String degree;
  final String startYear;
  final String endYear;
  final double? gpa;

  EducationModel({
    required this.university,
    required this.faculty,
    required this.degree,
    required this.startYear,
    required this.endYear,
    this.gpa,
  });
}
