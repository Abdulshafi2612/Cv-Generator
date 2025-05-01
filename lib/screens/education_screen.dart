import 'package:cv_maker/models/contact_info_model.dart';
import 'package:cv_maker/models/education_model.dart';
import 'package:cv_maker/screens/experience_screen.dart';
import 'package:cv_maker/widgets/custom_button.dart';
import 'package:cv_maker/widgets/custom_text_field.dart';
import 'package:cv_maker/widgets/custom_year_field.dart';
import 'package:cv_maker/widgets/step_circule.dart';
import 'package:flutter/material.dart';

class EducationScreen extends StatefulWidget {
  final ContactInfoModel contactInfo;

  const EducationScreen({Key? key, required this.contactInfo})
    : super(key: key);

  @override
  State<EducationScreen> createState() => _EducationScreenState();
}

class _EducationScreenState extends State<EducationScreen> {
  final _formKey = GlobalKey<FormState>();

  final universityController = TextEditingController();
  final facultyController = TextEditingController();
  final degreeController = TextEditingController();
  final startYearController = TextEditingController();
  final endYearController = TextEditingController();
  final gpaController = TextEditingController();

  final List<String> header = [
    'Contact Information',
    'Education',
    'Experience',
    'Skills',
    'Projects',
  ];

  @override
  void dispose() {
    universityController.dispose();
    facultyController.dispose();
    degreeController.dispose();
    startYearController.dispose();
    endYearController.dispose();
    gpaController.dispose();
    super.dispose();
  }

  String? validateEnglishOnly(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Required';
    }
    final arabicRegex = RegExp(r'[\u0600-\u06FF]');
    if (arabicRegex.hasMatch(value)) {
      return 'Please write your data in English only';
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Education')),
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
                  (i) => stepCircle(header[i], i == 1, index: i),
                ),
              ),
              SizedBox(height: 24),

              CustomTextField(
                controller: universityController,
                label: 'University / Institute',
                hint: 'Alexandria University',
                icon: Icons.school,
                validator: validateEnglishOnly,
              ),
              SizedBox(height: 16),

              CustomTextField(
                controller: facultyController,
                label: 'Faculty',
                hint: 'Faculty of Engineering',
                icon: Icons.school,
                validator: validateEnglishOnly,
              ),
              SizedBox(height: 16),

              CustomTextField(
                controller: degreeController,
                label: 'Degree',
                hint:
                    'Bachelor\'s of Engineering in Communication And Electronics',
                icon: Icons.menu_book,
                validator: validateEnglishOnly,
              ),
              SizedBox(height: 16),

              Row(
                children: [
                  Expanded(
                    child: CustomYearField(
                      controller: startYearController,
                      label: 'Start Year',
                      hint: '2020',
                      icon: Icons.calendar_today,
                      bottomSheetTitle: 'Select Start Year',
                      validator:
                          (v) =>
                              v == null || v.trim().isEmpty ? 'Required' : null,
                    ),
                  ),
                  SizedBox(width: 16),
                  Expanded(
                    child: CustomYearField(
                      controller: endYearController,
                      label: 'End Year',
                      hint: '2024',
                      icon: Icons.calendar_today,
                      bottomSheetTitle: 'Select End Year',
                      validator: (v) {
                        if (v == null || v.trim().isEmpty) return 'Required';
                        final endYear = int.tryParse(v.trim());
                        final startYear = int.tryParse(
                          startYearController.text.trim(),
                        );
                        if (startYear != null &&
                            endYear != null &&
                            endYear <= startYear) {
                          return 'lower than Start Year';
                        }
                        return null;
                      },
                    ),
                  ),
                ],
              ),
              SizedBox(height: 16),

              CustomTextField(
                controller: gpaController,
                label: 'GPA',
                hint: '3.72',
                icon: Icons.grade,
                keyboardType: TextInputType.numberWithOptions(decimal: true),
                validator: (v) {
                  if (v == null || v.trim().isEmpty) return null;
                  final gpa = double.tryParse(v);
                  if (gpa == null) return 'Enter a valid number';
                  if (gpa < 0 || gpa > 4) return 'GPA must be 0–4';
                  return null;
                },
              ),
              SizedBox(height: 24),

              CustomButton(
                text: 'Next Step',
                onPressed: () {
                  // if (_formKey.currentState!.validate()) {
                  final educationModel = EducationModel(
                    faculty: facultyController.text.trim(),
                    university: universityController.text.trim(),
                    degree: degreeController.text.trim(),
                    startYear: startYearController.text.trim(),
                    endYear: endYearController.text.trim(),
                    gpa:
                        gpaController.text.trim().isEmpty
                            ? null
                            : double.parse(gpaController.text.trim()),
                  );

                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder:
                          (_) => ExperienceScreen(
                            contactInfo: widget.contactInfo,
                            educationInfo: educationModel,
                          ),
                    ),
                  );
                  // }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
