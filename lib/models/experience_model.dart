
import 'package:cv_maker/models/non_technical_model.dart';
import 'training_model.dart';
import 'course_model.dart';

class ExperienceModel {
  final List<TrainingModel> trainings;
  final List<CourseModel> courses;
  final List<NonTechnicalActivityModel> nonTechnicalActivities;

  ExperienceModel({
    required this.trainings,
    required this.courses,
    required this.nonTechnicalActivities,
  });

}

