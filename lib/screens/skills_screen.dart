import 'package:cv_maker/models/certification_model.dart';
import 'package:cv_maker/models/contact_info_model.dart';
import 'package:cv_maker/models/education_model.dart';
import 'package:cv_maker/models/experience_model.dart';
import 'package:cv_maker/models/skills_model.dart';
import 'package:cv_maker/models/technical_skills_group.dart';
import 'package:cv_maker/screens/projects_screen.dart';
import 'package:flutter/material.dart';
import 'package:cv_maker/models/course_model.dart';
import 'package:cv_maker/models/training_model.dart';
import 'package:cv_maker/widgets/step_circule.dart';

class SkillsScreen extends StatefulWidget {
  final ContactInfoModel contactInfo;
  final EducationModel educationInfo;
  final ExperienceModel experienceInfo;

  const SkillsScreen({
    Key? key,
    required this.contactInfo,
    required this.educationInfo,
    required this.experienceInfo,
  }) : super(key: key);

  @override
  _SkillsScreenState createState() => _SkillsScreenState();
}

class _SkillsScreenState extends State<SkillsScreen> {
  final _formKey = GlobalKey<FormState>();

  final List<String> hedder = [
    'Contact Information',
    'Education',
    'Experience',
    'Skills',
    'Projects',
  ];

  List<Map<String, TextEditingController>> techGroups = [];
  List<Map<String, TextEditingController>> langCtrls = [];
  List<TextEditingController> softCtrls = [];
  List<Map<String, TextEditingController>> certCtrls = [];

  @override
  void initState() {
    super.initState();
    _addTechGroup();
    _addLanguage();
    _addSoftSkill();
    _addCertification();
  }

  void _addTechGroup() => setState(() {
    techGroups.add({
      'title': TextEditingController(),
      'skills': TextEditingController(),
    });
  });

  void _addLanguage() => setState(() {
    langCtrls.add({
      'language': TextEditingController(),
      'level': TextEditingController(),
    });
  });

  void _addSoftSkill() => setState(() {
    softCtrls.add(TextEditingController());
  });

  void _addCertification() => setState(() {
    certCtrls.add({
      'title': TextEditingController(),
      'date': TextEditingController(),
    });
  });

  @override
  void dispose() {
    for (var m in techGroups) m.values.forEach((c) => c.dispose());
    for (var m in langCtrls) m.values.forEach((c) => c.dispose());
    for (var c in softCtrls) c.dispose();
    for (var m in certCtrls) m.values.forEach((c) => c.dispose());
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
                    itemBuilder: (_, idx) {
                      final y = years[idx];
                      return ListTile(
                        title: Center(
                          child: Text(
                            y.toString(),
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                        onTap: () {
                          controller.text = y.toString();
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Skills')),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: List.generate(
                  hedder.length,
                  (i) => stepCircle(hedder[i], i == 3, index: i),
                ),
              ),
              SizedBox(height: 24),

              _buildSectionTitle('Technical Skills'),
              ...techGroups.map(_buildTechGroup).toList(),
              _buildAddButton(_addTechGroup, 'Add Skill Group'),

              SizedBox(height: 24),
              _buildSectionTitle('Languages'),
              ...langCtrls.map(_buildLanguage).toList(),
              _buildAddButton(_addLanguage, 'Add Language'),

              SizedBox(height: 24),
              _buildSectionTitle('Soft Skills'),
              ...softCtrls.map(_buildSoftSkill).toList(),
              _buildAddButton(_addSoftSkill, 'Add Soft Skill'),

              SizedBox(height: 24),
              _buildSectionTitle('Certifications'),
              ...certCtrls.map(_buildCertification).toList(),
              _buildAddButton(_addCertification, 'Add Certification'),

              SizedBox(height: 30),
              ElevatedButton(
                onPressed: _onNext,
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

  Widget _buildSectionTitle(String text) => Padding(
    padding: EdgeInsets.symmetric(vertical: 12),
    child: Text(
      text,
      style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
    ),
  );

  Widget _buildAddButton(VoidCallback onTap, String label) => TextButton.icon(
    onPressed: onTap,
    icon: Icon(Icons.add),
    label: Text(label),
  );

  Widget _buildTechGroup(Map<String, TextEditingController> grp) {
    final idx = techGroups.indexOf(grp);
    return _buildItem('Group #${idx + 1}', [
      _buildTextField(
        grp['title']!,
        'Title',
        'e.g. Programming Skills',
        Icons.code,
      ),
      _buildTextField(
        grp['skills']!,
        'Skills',
        'Comma-separated list',
        Icons.list,
        maxLines: 2,
        alignTop: true,
      ),
    ], () => setState(() => techGroups.removeAt(idx)));
  }

  Widget _buildLanguage(Map<String, TextEditingController> grp) {
    final idx = langCtrls.indexOf(grp);
    return _buildItem('Language #${idx + 1}', [
      _buildTextField(
        grp['language']!,
        'Language',
        'e.g. English',
        Icons.language,
      ),
      _buildTextField(
        grp['level']!,
        'Proficiency',
        'e.g. Fluent',
        Icons.bar_chart,
      ),
    ], () => setState(() => langCtrls.removeAt(idx)));
  }

  Widget _buildSoftSkill(TextEditingController ctrl) {
    final idx = softCtrls.indexOf(ctrl);
    return Column(
      children: [
        Row(
          children: [
            Expanded(
              child: _buildTextField(
                ctrl,
                'Skill #${idx + 1}',
                'e.g. Communication',
                Icons.handshake,
              ),
            ),
            IconButton(
              icon: Icon(Icons.delete, color: Colors.red),
              onPressed: () => setState(() => softCtrls.removeAt(idx)),
            ),
          ],
        ),
        SizedBox(height: 10),
      ],
    );
  }

  Widget _buildCertification(Map<String, TextEditingController> grp) {
    final idx = certCtrls.indexOf(grp);
    return _buildItem('Certification #${idx + 1}', [
      _buildTextField(
        grp['title']!,
        'Title',
        'Certification Name',
        Icons.card_membership,
      ),
      _buildDateField(grp['date']!, 'Date', '2023', Icons.date_range),
    ], () => setState(() => certCtrls.removeAt(idx)));
  }

  Widget _buildItem(
    String heading,
    List<Widget> children,
    VoidCallback onDelete,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(heading, style: TextStyle(fontWeight: FontWeight.bold)),
        SizedBox(height: 8),
        ...children.map(
          (w) => Padding(padding: EdgeInsets.only(bottom: 8), child: w),
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
      decoration: InputDecoration(
        labelText: label,
        hintText: hint,
        prefixIcon: Icon(icon),
        alignLabelWithHint: alignTop,
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
        contentPadding: EdgeInsets.symmetric(vertical: 14, horizontal: 16),
      ),
      // واستبدل الـ validator في _buildDateField بنفس الشكل:
      validator: (value) {
        if (value == null || value.trim().isEmpty) {
          return 'This field is required';
        }
        final englishRegex = RegExp(r'^[\x00-\x7F]+$');
        if (!englishRegex.hasMatch(value)) {
          return 'Only English characters are allowed';
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
      decoration: InputDecoration(
        labelText: label,
        hintText: hint,
        prefixIcon: Icon(icon),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
        contentPadding: EdgeInsets.symmetric(vertical: 14, horizontal: 16),
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

  void _onNext() {
    if (!_formKey.currentState!.validate()) return;
    final tech =
        techGroups
            .map(
              (g) => TechnicalSkillGroup(
                title: g['title']!.text.trim(),
                skills:
                    g['skills']!.text.split(',').map((s) => s.trim()).toList(),
              ),
            )
            .toList();
    final langs =
        langCtrls
            .map(
              (g) => LanguageModel(
                name: g['language']!.text.trim(),
                level: g['level']!.text.trim(),
              ),
            )
            .toList();
    final soft = softCtrls.map((c) => c.text.trim()).toList();
    final certs =
        certCtrls
            .map(
              (g) => CertificationModel(
                title: g['title']!.text.trim(),
                date: g['date']!.text.trim(),
              ),
            )
            .toList();
    final skills = SkillsModel(
      technicalGroups: tech,
      languages: langs,
      softSkills: soft,
      certifications: certs,
    );
    Navigator.push(
      context,
      MaterialPageRoute(
        builder:
            (_) => ProjectsScreen(
              contactInfo: widget.contactInfo,
              educationInfo: widget.educationInfo,
              experienceInfo: widget.experienceInfo,
              skillsInfo: skills,
            ),
      ),
    );
  }
}
