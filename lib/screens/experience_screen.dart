import 'package:cv_maker/models/contact_info_model.dart';
import 'package:cv_maker/models/education_model.dart';
import 'package:cv_maker/models/experience_model.dart';
import 'package:cv_maker/models/non_technical_model.dart';
import 'package:flutter/material.dart';
import 'package:cv_maker/models/course_model.dart';
import 'package:cv_maker/models/training_model.dart';
import 'package:cv_maker/screens/skills_screen.dart';
import 'package:cv_maker/widgets/step_circule.dart';

class ExperienceScreen extends StatefulWidget {
  final ContactInfoModel contactInfo;
  final EducationModel educationInfo;

  const ExperienceScreen({
    Key? key,
    required this.contactInfo,
    required this.educationInfo,
  }) : super(key: key);

  @override
  _ExperienceScreenState createState() => _ExperienceScreenState();
}

class _ExperienceScreenState extends State<ExperienceScreen> {
  final _formKey = GlobalKey<FormState>();
  List<Map<String, TextEditingController>> trainingCtrls = [];
  List<Map<String, TextEditingController>> courseCtrls = [];
  List<Map<String, TextEditingController>> nonTechCtrls = [];

  final List<String> hedder = [
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
    trainingCtrls.add({
      'place': TextEditingController(),
      'name': TextEditingController(),
      'desc': TextEditingController(),
      'date': TextEditingController(),
    });
  });

  void _addCourse() => setState(() {
    courseCtrls.add({
      'place': TextEditingController(),
      'date': TextEditingController(),
      'course': TextEditingController(),
    });
  });

  void _addNonTech() => setState(() {
    nonTechCtrls.add({
      'title': TextEditingController(),
      'date': TextEditingController(),
      'desc': TextEditingController(),
    });
  });

  @override
  void dispose() {
    for (var m in trainingCtrls) m.values.forEach((c) => c.dispose());
    for (var m in courseCtrls) m.values.forEach((c) => c.dispose());
    for (var m in nonTechCtrls) m.values.forEach((c) => c.dispose());
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
      builder: (_) {
        return Container(
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
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Experience')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              // Step indicators
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: List.generate(
                  hedder.length,
                  (i) => stepCircle(hedder[i], i == 2, index: i),
                ),
              ),
              SizedBox(height: 24),

              // Technical Trainings
              _buildSectionTitle('Technical Trainings/ Internships'),
              ...trainingCtrls.map(_buildTrainingItem).toList(),
              _buildAddButton(_addTraining, 'Add Training'),

              SizedBox(height: 24),

              // Technical Courses
              _buildSectionTitle('Technical Courses'),
              ...courseCtrls.map(_buildCourseItem).toList(),
              _buildAddButton(_addCourse, 'Add Course'),

              SizedBox(height: 24),

              // Non-Technical Activities
              _buildSectionTitle('Non-Technical Activities'),
              ...nonTechCtrls.map(_buildNonTechItem).toList(),
              _buildAddButton(_addNonTech, 'Add Activity'),

              SizedBox(height: 30),

              ElevatedButton(
                onPressed: _onNextPressed,
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

  Widget _buildSectionTitle(String text) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12.0),
      child: Text(
        text,
        style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
      ),
    );
  }

  Widget _buildAddButton(VoidCallback onTap, String label) {
    return TextButton.icon(
      onPressed: onTap,
      icon: Icon(Icons.add),
      label: Text(label),
    );
  }

  Widget _buildTrainingItem(Map<String, TextEditingController> m) {
    int idx = trainingCtrls.indexOf(m);
    return _buildItem(
      index: idx,
      title: 'Training #${idx + 1}',
      children: [
        _buildTextField(
          m['place']!,
          'Place',
          'Company / Institute',
          Icons.location_on,
        ),
        _buildTextField(
          m['name']!,
          'Training Name',
          'Workshop / Internship title',
          Icons.school,
        ),

        _buildDateField(m['date']!, 'Date', '2020', Icons.calendar_today),
      ],
      onDelete: () => setState(() => trainingCtrls.removeAt(idx)),
    );
  }

  Widget _buildCourseItem(Map<String, TextEditingController> m) {
    int idx = courseCtrls.indexOf(m);
    return _buildItem(
      index: idx,
      title: 'Course #${idx + 1}',
      children: [
        _buildTextField(
          m['place']!,
          'Place',
          'Online / Institute',
          Icons.location_on,
        ),
        _buildDateField(m['date']!, 'Date', '2023', Icons.date_range),
        _buildTextField(
          m['course']!,
          'Course Name',
          'Course title',
          Icons.book,
        ),
      ],
      onDelete: () => setState(() => courseCtrls.removeAt(idx)),
    );
  }

  Widget _buildNonTechItem(Map<String, TextEditingController> m) {
    int idx = nonTechCtrls.indexOf(m);
    return _buildItem(
      index: idx,
      title: 'Activity #${idx + 1}',
      children: [
        _buildTextField(m['title']!, 'Title', 'Event and role', Icons.event),
        _buildTextField(
          m['desc']!,
          'Description',
          'Brief summary',
          Icons.description,
          maxLines: 3,
          alignTop: true,
        ),
        _buildDateField(m['date']!, 'Date', '2023', Icons.date_range),
      ],
      onDelete: () => setState(() => nonTechCtrls.removeAt(idx)),
    );
  }

  Widget _buildItem({
    required int index,
    required String title,
    required List<Widget> children,
    required VoidCallback onDelete,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title, style: TextStyle(fontWeight: FontWeight.bold)),
        SizedBox(height: 8),
        ...children.map(
          (w) => Padding(padding: const EdgeInsets.only(bottom: 8.0), child: w),
        ),
        Align(
          alignment: Alignment.centerRight,
          child: IconButton(
            icon: Icon(Icons.delete, color: Colors.red),
            onPressed: onDelete,
          ),
        ),
        Divider(),
      ],
    );
  }

  Widget _buildTextField(
    TextEditingController controller,
    String label,
    String hint,
    IconData icon, {
    int maxLines = 1,
    bool alignTop = false,
  }) {
    return TextFormField(
      autovalidateMode: AutovalidateMode.onUserInteraction,
      controller: controller,
      maxLines: maxLines,
      decoration: _buildDecoration(
        label: label,
        hint: hint,
        icon: icon,
        alignLabelWithHint: alignTop,
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
    );
  }

  Widget _buildDateField(
    TextEditingController controller,
    String label,
    String hint,
    IconData icon,
  ) {
    return TextFormField(
      controller: controller,
      readOnly: true,
      onTap: () => _showYearPicker(controller),
      autovalidateMode: AutovalidateMode.onUserInteraction,
      decoration: _buildDecoration(label: label, hint: hint, icon: icon),
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
    );
  }

  InputDecoration _buildDecoration({
    required String label,
    required String hint,
    required IconData icon,
    bool alignLabelWithHint = false,
  }) {
    return InputDecoration(
      labelText: label,
      hintText: hint,
      prefixIcon: Icon(icon),
      alignLabelWithHint: alignLabelWithHint,
      border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
      contentPadding: EdgeInsets.symmetric(vertical: 14, horizontal: 16),
    );
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
}
