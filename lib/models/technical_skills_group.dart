class TechnicalSkillGroup {
  final String title;
  final List<String> skills;

  TechnicalSkillGroup({
    required this.title,
    required this.skills,
  });
}

/// Represents a language and the user's proficiency level.
class LanguageModel {
  final String name;
  final String level;

  LanguageModel({
    required this.name,
    required this.level,
  });
}