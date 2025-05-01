import 'package:cv_maker/functions/section_controls.dart';
import 'package:cv_maker/widgets/custom_section.dart';
import 'package:flutter/material.dart';
import 'package:cv_maker/models/contact_info_model.dart';
import 'package:cv_maker/models/education_model.dart';
import 'package:cv_maker/models/experience_model.dart';
import 'package:cv_maker/models/course_model.dart';
import 'package:cv_maker/models/training_model.dart';
import 'package:cv_maker/models/non_technical_model.dart';
import 'package:cv_maker/screens/skills_screen.dart';
import 'package:cv_maker/widgets/step_circule.dart';
import 'package:cv_maker/widgets/custom_text_field.dart';
import 'package:cv_maker/widgets/custom_year_field.dart';
import 'package:cv_maker/widgets/custom_button.dart';

class ExperienceScreen extends StatefulWidget {
  final ContactInfoModel contactInfo;
  final EducationModel educationInfo;

  const ExperienceScreen({
    super.key,
    required this.contactInfo,
    required this.educationInfo,
  });

  @override
  State<ExperienceScreen> createState() => _ExperienceScreenState();
}

class _ExperienceScreenState extends State<ExperienceScreen> {
  final _formKey = GlobalKey<FormState>();

  final List<Map<String, TextEditingController>> trainingCtrls = [];
  final List<Map<String, TextEditingController>> courseCtrls = [];
  final List<Map<String, TextEditingController>> nonTechCtrls = [];

  final List<String> header = [
    'Contact Information',
    'Education',
    'Experience',
    'Skills',
    'Projects',
  ];

  @override
  void initState() {
    super.initState();
    _addTraining();
    _addCourse();
    _addNonTech();
  }

  void _addTraining() => setState(() {
    trainingCtrls.add(SectionControllers.createTraining());
  });

  void _addCourse() => setState(() {
    courseCtrls.add(SectionControllers.createCourse());
  });

  void _addNonTech() => setState(() {
    nonTechCtrls.add(SectionControllers.createActivity());
  });

  @override
  void dispose() {
    SectionControllers.disposeControllers(trainingCtrls);
    SectionControllers.disposeControllers(courseCtrls);
    SectionControllers.disposeControllers(nonTechCtrls);
    super.dispose();
  }

  void _onNextPressed() {
    if (!_formKey.currentState!.validate()) return;

    final trainings =
        trainingCtrls
            .map(
              (m) => TrainingModel(
                place: m['place']!.text.trim(),
                name: m['name']!.text.trim(),
                date: m['date']!.text.trim(),
              ),
            )
            .toList();

    final courses =
        courseCtrls
            .map(
              (m) => CourseModel(
                place: m['place']!.text.trim(),
                date: m['date']!.text.trim(),
                course: m['course']!.text.trim(),
              ),
            )
            .toList();

    final activities =
        nonTechCtrls
            .map(
              (m) => NonTechnicalActivityModel(
                title: m['title']!.text.trim(),
                date: m['date']!.text.trim(),
                description: m['desc']!.text.trim(),
              ),
            )
            .toList();

    final experience = ExperienceModel(
      trainings: trainings,
      courses: courses,
      nonTechnicalActivities: activities,
    );

    Navigator.push(
      context,
      MaterialPageRoute(
        builder:
            (_) => SkillsScreen(
              contactInfo: widget.contactInfo,
              educationInfo: widget.educationInfo,
              experienceInfo: experience,
            ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Experience')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: List.generate(
                  header.length,
                  (i) => stepCircle(header[i], i == 2, index: i),
                ),
              ),
              const SizedBox(height: 24),

              // Training Section
              CustomSection(
                onRemove:
                    (index) => setState(() => trainingCtrls.removeAt(index)),
                title: 'Technical Trainings/ Internships',
                entries: trainingCtrls,
                fieldBuilders:
                    (m) => [
                      CustomTextField(
                        controller: m['place']!,
                        label: 'Place',
                        hint: 'Company / Institute',
                        icon: Icons.location_on,
                        validator: _validateText,
                      ),
                      CustomTextField(
                        controller: m['name']!,
                        label: 'Training Name',
                        hint: 'Workshop / Internship title',
                        icon: Icons.school,
                        validator: _validateText,
                      ),
                      CustomYearField(
                        controller: m['date']!,
                        label: 'Date',
                        hint: '2023',
                        icon: Icons.calendar_today,
                        bottomSheetTitle: 'Select Year',
                        validator: _validateText,
                      ),
                    ],
                onAdd: _addTraining,
                addButtonText: 'Add Training',
              ),

              const SizedBox(height: 24),

              // Courses Section
              CustomSection(
                onRemove:
                    (index) => setState(() => courseCtrls.removeAt(index)),
                title: 'Technical Courses',
                entries: courseCtrls,
                fieldBuilders:
                    (m) => [
                      CustomTextField(
                        controller: m['place']!,
                        label: 'Place',
                        hint: 'Online / Institute',
                        icon: Icons.location_on,
                        validator: _validateText,
                      ),
                      CustomYearField(
                        controller: m['date']!,
                        label: 'Date',
                        hint: '2023',
                        icon: Icons.date_range,
                        bottomSheetTitle: 'Select Year',
                        validator: _validateText,
                      ),
                      CustomTextField(
                        controller: m['course']!,
                        label: 'Course Name',
                        hint: 'Course title',
                        icon: Icons.book,
                        validator: _validateText,
                      ),
                    ],
                onAdd: _addCourse,
                addButtonText: 'Add Course',
              ),

              const SizedBox(height: 24),

              // Non-technical Section
              CustomSection(
                onRemove:
                    (index) => setState(() => nonTechCtrls.removeAt(index)),
                title: 'Non-Technical Activities',
                entries: nonTechCtrls,
                fieldBuilders:
                    (m) => [
                      CustomTextField(
                        controller: m['title']!,
                        label: 'Title',
                        hint: 'Event and role',
                        icon: Icons.event,
                        validator: _validateText,
                      ),
                      CustomTextField(
                        controller: m['desc']!,
                        label: 'Description',
                        hint: 'Brief summary',
                        icon: Icons.description,
                        isObjective: true,
                        validator: _validateText,
                      ),
                      CustomYearField(
                        controller: m['date']!,
                        label: 'Date',
                        hint: '2023',
                        icon: Icons.date_range,
                        bottomSheetTitle: 'Select Year',
                        validator: _validateText,
                      ),
                    ],
                onAdd: _addNonTech,
                addButtonText: 'Add Activity',
              ),

              const SizedBox(height: 30),
              CustomButton(onPressed: _onNextPressed, text: 'Next Step'),
            ],
          ),
        ),
      ),
    );
  }

  String? _validateText(String? value) {
    if (value == null || value.trim().isEmpty) return 'Required';
    final arabicRegex = RegExp(r'[\u0600-\u06FF]');
    if (arabicRegex.hasMatch(value))
      return 'Please write your data in English only';
    return null;
  }
}
