import 'package:cv_maker/models/contact_info_model.dart';
import 'package:cv_maker/models/education_model.dart';
import 'package:cv_maker/screens/experience_screen.dart';
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
  final facultycontroller = TextEditingController();
  final degreeController = TextEditingController();
  final startYearController = TextEditingController();
  final endYearController = TextEditingController();
  final gpaController = TextEditingController();

  final List<String> hedder = [
    'Contact Information',
    'Education',
    'Experience',
    'Skills',
    'Projects',
  ];

  @override
  void dispose() {
    universityController.dispose();
    degreeController.dispose();
    facultycontroller.dispose();
    startYearController.dispose();
    endYearController.dispose();
    gpaController.dispose();
    super.dispose();
  }

  InputDecoration _buildDecoration({
    required String label,
    required String hint,
    required IconData icon,
    bool alignTop = false,
  }) {
    return InputDecoration(
      labelText: label,
      hintText: hint,
      prefixIcon: Icon(icon),
      alignLabelWithHint: alignTop,
      border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
      contentPadding: EdgeInsets.symmetric(vertical: 14, horizontal: 16),
    );
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
                  hedder.length,
                  (i) => stepCircle(hedder[i], i == 1, index: i),
                ),
              ),
              SizedBox(height: 24),

              // University
              TextFormField(
                controller: universityController,
                autovalidateMode: AutovalidateMode.onUserInteraction,
                decoration: _buildDecoration(
                  label: 'University / Institute',
                  hint: 'Alexandria University',
                  icon: Icons.school,
                ),
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Required';
                  }
                  final arabicRegex = RegExp(r'[\u0600-\u06FF]');
                  if (arabicRegex.hasMatch(value)) {
                    return 'Please write your data in English only';
                  }
                  return null;
                },
              ),
              SizedBox(height: 16),
              TextFormField(
                controller: facultycontroller,
                autovalidateMode: AutovalidateMode.onUserInteraction,
                decoration: _buildDecoration(
                  label: 'Faculty',
                  hint: 'Faculty of Engineering',
                  icon: Icons.school,
                ),
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Required';
                  }
                  final arabicRegex = RegExp(r'[\u0600-\u06FF]');
                  if (arabicRegex.hasMatch(value)) {
                    return 'Please write your data in English only';
                  }
                  return null;
                },
              ),
              SizedBox(height: 16),

              // Degree
              TextFormField(
                controller: degreeController,
                autovalidateMode: AutovalidateMode.onUserInteraction,
                decoration: _buildDecoration(
                  label: 'Degree',
                  hint:
                      'Bachelor\'s of Engineering in Communication And Electronics',
                  icon: Icons.menu_book,
                ),
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Required';
                  }
                  final arabicRegex = RegExp(r'[\u0600-\u06FF]');
                  if (arabicRegex.hasMatch(value)) {
                    return 'Please write your data in English only';
                  }
                  return null;
                },
              ),
              SizedBox(height: 16),
              // Start & End Year
              Row(
                children: [
                  Expanded(
                    child: TextFormField(
                      controller: startYearController,
                      readOnly: true,
                      onTap: () async {
                        final currentYear = DateTime.now().year;
                        final startYear = currentYear - 50;
                        final endYear = currentYear + 50;

                        final years =
                            List.generate(
                              endYear - startYear + 1,
                              (i) => startYear + i,
                            ).reversed.toList(); // ترتيب تنازلي

                        final currentIndex = years.indexOf(currentYear);
                        final scrollController = ScrollController(
                          initialScrollOffset:
                              currentIndex *
                              60, // 50 تقريبًا ارتفاع كل ListTile
                        );
                        await showModalBottomSheet(
                          context: context,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.vertical(
                              top: Radius.circular(20),
                            ),
                          ),
                          backgroundColor: Colors.white,
                          builder: (context) {
                            return Container(
                              padding: EdgeInsets.symmetric(
                                vertical: 16,
                                horizontal: 12,
                              ),
                              height: 400,
                              child: Column(
                                children: [
                                  Text(
                                    "Select Start Year",
                                    style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.blueAccent,
                                    ),
                                  ),
                                  SizedBox(height: 10),
                                  Divider(thickness: 1),
                                  Expanded(
                                    child: ListView.separated(
                                      // ضفنا هنا الكنترولر
                                      controller: scrollController,
                                      itemCount: years.length,
                                      separatorBuilder:
                                          (context, index) =>
                                              Divider(height: 1),
                                      itemBuilder: (context, index) {
                                        final year = years[index];
                                        return ListTile(
                                          title: Center(
                                            child: Text(
                                              year.toString(),
                                              style: TextStyle(
                                                fontSize: 18,
                                                fontWeight: FontWeight.w500,
                                              ),
                                            ),
                                          ),
                                          onTap: () {
                                            startYearController.text =
                                                year.toString();
                                            Navigator.pop(context);
                                          },
                                          hoverColor: Colors.blue.withOpacity(
                                            0.1,
                                          ),
                                        );
                                      },
                                    ),
                                  ),
                                ],
                              ),
                            );
                          },
                        );
                      },

                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      decoration: _buildDecoration(
                        label: 'Start Year',
                        hint: '2020',
                        icon: Icons.calendar_today,
                      ),
                      validator:
                          (v) =>
                              v == null || v.trim().isEmpty ? 'Required' : null,
                    ),
                  ),
                  SizedBox(width: 16),
                  Expanded(
                    child: TextFormField(
                      controller: endYearController,
                      readOnly: true,
                      onTap: () async {
                        final currentYear = DateTime.now().year;
                        final startYear = currentYear - 50;
                        final endYear = currentYear + 50;

                        final years =
                            List.generate(
                              endYear - startYear + 1,
                              (i) => startYear + i,
                            ).reversed.toList(); // ترتيب تنازلي

                        final currentIndex = years.indexOf(currentYear);
                        final scrollController = ScrollController(
                          initialScrollOffset:
                              currentIndex *
                              55, // 50 تقريبًا ارتفاع كل ListTile
                        );

                        await showModalBottomSheet(
                          context: context,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.vertical(
                              top: Radius.circular(20),
                            ),
                          ),
                          backgroundColor: Colors.white,
                          builder: (context) {
                            return Container(
                              padding: EdgeInsets.symmetric(
                                vertical: 16,
                                horizontal: 12,
                              ),
                              height: 400,
                              child: Column(
                                children: [
                                  Text(
                                    "Select End Year",
                                    style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.blueAccent,
                                    ),
                                  ),
                                  SizedBox(height: 10),
                                  Divider(thickness: 1),
                                  Expanded(
                                    child: ListView.separated(
                                      controller: scrollController,
                                      itemCount: years.length,
                                      separatorBuilder:
                                          (context, index) =>
                                              Divider(height: 1),
                                      itemBuilder: (context, index) {
                                        final year = years[index];
                                        return ListTile(
                                          title: Center(
                                            child: Text(
                                              year.toString(),
                                              style: TextStyle(
                                                fontSize: 18,
                                                fontWeight: FontWeight.w500,
                                              ),
                                            ),
                                          ),
                                          onTap: () {
                                            endYearController.text =
                                                year.toString();
                                            Navigator.pop(context);
                                          },
                                          hoverColor: Colors.blue.withOpacity(
                                            0.1,
                                          ),
                                        );
                                      },
                                    ),
                                  ),
                                ],
                              ),
                            );
                          },
                        );
                      },

                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      decoration: _buildDecoration(
                        label: 'End Year',
                        hint: '2024',
                        icon: Icons.calendar_today,
                      ),
                      validator: (v) {
                        if (v == null || v.trim().isEmpty) {
                          return 'Required';
                        }

                        final endYear = int.tryParse(v.trim());
                        final startYear = int.tryParse(
                          startYearController.text.trim(),
                        );

                        if (startYear != null && endYear != null) {
                          if (endYear <= startYear) {
                            return 'lower than Start Year';
                          }
                        }

                        return null;
                      },
                    ),
                  ),
                ],
              ),
              SizedBox(height: 16),

              // GPA
              TextFormField(
                controller: gpaController,
                keyboardType: TextInputType.numberWithOptions(decimal: true),
                autovalidateMode: AutovalidateMode.onUserInteraction,
                decoration: _buildDecoration(
                  label: 'GPA',
                  hint: '3.72',
                  icon: Icons.grade,
                ),
                validator: (v) {
                  if (v == null || v.trim().isEmpty) return null;
                  final gpa = double.tryParse(v);
                  if (gpa == null) return 'Enter a valid number';
                  if (gpa < 0 || gpa > 4) return 'GPA must be 0–4';
                  return null;
                },
              ),
              SizedBox(height: 24),

              // Next Step Button
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    final educationModel = EducationModel(
                      faculty: facultycontroller.text.trim(),
                      university: universityController.text.trim(),
                      degree: degreeController.text.trim(),
                      startYear: startYearController.text.trim(),
                      endYear: endYearController.text.trim(),
                      gpa:
                          gpaController.text.trim().isEmpty
                              ? null
                              : double.parse(gpaController.text.trim()),
                      // No courses section now
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
                  }
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue,
                  padding: EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: Text(
                  'Next Step',
                  style: TextStyle(color: Colors.white, fontSize: 16),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
