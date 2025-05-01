import 'package:cv_maker/functions/section_controls.dart';
import 'package:flutter/material.dart';
import '../widgets/custom_section.dart';
import '../widgets/custom_text_field.dart';

class SoftSkillsSection extends StatelessWidget {
  final List<Map<String, TextEditingController>> softSkills;
  final VoidCallback onAddSkill;
  final void Function(int) onRemoveSkill;

  const SoftSkillsSection({
    super.key,
    required this.softSkills,
    required this.onAddSkill,
    required this.onRemoveSkill,
  });

  @override
  Widget build(BuildContext context) {
    return CustomSection(
      title: 'Soft Skills',
      entries: softSkills,
      fieldBuilders: (controllers) => [
        CustomTextField(
          controller: controllers['skill']!,
          label: 'Skill',
          hint: 'e.g. Communication',
          icon: Icons.lightbulb_outline,
          validator: SectionControllers.validateText,
        ),
      ],
      onAdd: onAddSkill,
      onRemove: onRemoveSkill,
      addButtonText: 'Add Soft Skill',
    );
  }
}
