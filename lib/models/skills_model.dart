import 'package:cv_maker/models/certification_model.dart';
import 'package:cv_maker/models/technical_skills_group.dart';

class SkillsModel {
  final List<TechnicalSkillGroup> technicalGroups;
  final List<LanguageModel> languages;
  final List<String> softSkills;
  final List<CertificationModel> certifications;

  SkillsModel({
    required this.technicalGroups,
    required this.languages,
    required this.softSkills,
    required this.certifications,
  });
}
