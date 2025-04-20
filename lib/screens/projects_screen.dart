import 'package:cv_maker/models/projects_model.dart';
import 'package:cv_maker/screens/finish_screen.dart';
import 'package:cv_maker/widgets/step_circule.dart';
import 'package:flutter/material.dart';
import 'package:cv_maker/models/contact_info_model.dart';
import 'package:cv_maker/models/education_model.dart';
import 'package:cv_maker/models/experience_model.dart';
import 'package:cv_maker/models/skills_model.dart';

class ProjectsScreen extends StatefulWidget {
  final ContactInfoModel contactInfo;
  final EducationModel educationInfo;
  final ExperienceModel experienceInfo;
  final SkillsModel skillsInfo;

  const ProjectsScreen({
    Key? key,
    required this.contactInfo,
    required this.educationInfo,
    required this.experienceInfo,
    required this.skillsInfo,
  }) : super(key: key);

  @override
  State<ProjectsScreen> createState() => _ProjectsScreenState();
}

class _ProjectsScreenState extends State<ProjectsScreen> {
  final _formKey = GlobalKey<FormState>();
  final List<String> hedder = [
    'Contact Information',
    'Education',
    'Experience',
    'Skills',
    'Projects',
  ];

  List<Map<String, TextEditingController>> projectCtrls = [];

  @override
  void initState() {
    super.initState();
    _addProject();
  }

  void _addProject() {
    projectCtrls.add({
      'title': TextEditingController(),
      'date': TextEditingController(),
      'details': TextEditingController(),
    });
    setState(() {});
  }

  void _removeProject(int idx) {
    setState(() {
      projectCtrls[idx].values.forEach((c) => c.dispose());
      projectCtrls.removeAt(idx);
    });
  }

  @override
  void dispose() {
    for (var map in projectCtrls) {
      map.values.forEach((c) => c.dispose());
    }
    super.dispose();
  }

  Future<void> _showYearPicker(TextEditingController controller) async {
    final currentYear = DateTime.now().year;
    final years = List.generate(150, (i) => currentYear - i);

    await showModalBottomSheet(
      context: context,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      backgroundColor: Colors.white,
      builder:
          (_) => Container(
            padding: EdgeInsets.symmetric(vertical: 16, horizontal: 12),
            height: 400,
            child: Column(
              children: [
                Text(
                  'Select Year',
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
                    itemCount: years.length,
                    separatorBuilder: (_, __) => Divider(height: 1),
                    itemBuilder: (_, index) {
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
                          controller.text = year.toString();
                          Navigator.pop(context);
                        },
                        hoverColor: Colors.blue.withOpacity(0.1),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
    );
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
      appBar: AppBar(title: Text('Projects')),
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
                  (i) => stepCircle(hedder[i], i == 4, index: i),
                ),
              ),
              SizedBox(height: 24),

              Text(
                'Projects',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 12),

              ...projectCtrls.asMap().entries.map((entry) {
                int idx = entry.key;
                var ctrls = entry.value;
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Project #${idx + 1}',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 8),

                    // Title
                    TextFormField(
                      controller: ctrls['title'],
                      autovalidateMode: AutovalidateMode.onUserInteraction,

                      decoration: _buildDecoration(
                        label: 'Title',
                        hint: 'e.g. Mobile App',
                        icon: Icons.title,
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
                    SizedBox(height: 8),

                    // Date picker
                    TextFormField(
                      controller: ctrls['date'],
                      readOnly: true,
                      onTap: () => _showYearPicker(ctrls['date']!),
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      decoration: _buildDecoration(
                        label: 'Date',
                        hint: '2024',
                        icon: Icons.date_range,
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
                    SizedBox(height: 8),

                    // Details
                    TextFormField(
                      controller: ctrls['details'],
                      autovalidateMode: AutovalidateMode.onUserInteraction,

                      decoration: _buildDecoration(
                        label: 'Details',
                        hint: 'Describe your project',
                        icon: Icons.description,
                        alignTop: true,
                      ),
                      maxLines: 3,
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

                    Align(
                      alignment: Alignment.centerRight,
                      child: IconButton(
                        icon: Icon(Icons.delete, color: Colors.red),
                        onPressed: () => _removeProject(idx),
                      ),
                    ),
                    Divider(),
                  ],
                );
              }).toList(),

              TextButton.icon(
                onPressed: _addProject,
                icon: Icon(Icons.add),
                label: Text('Add Project'),
              ),
              SizedBox(height: 30),

              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    final projects =
                        projectCtrls
                            .map(
                              (map) => ProjectModel(
                                title: map['title']!.text.trim(),
                                date: map['date']!.text.trim(),
                                details: map['details']!.text.trim(),
                              ),
                            )
                            .toList();
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder:
                            (_) => FinishScreen(
                              contactInfo: widget.contactInfo,
                              educationInfo: widget.educationInfo,
                              experienceInfo: widget.experienceInfo,
                              skillsInfo: widget.skillsInfo,
                              projects: projects,
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
                  'Finish',
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
