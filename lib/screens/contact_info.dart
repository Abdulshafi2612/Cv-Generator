import 'package:cv_maker/screens/education_screen.dart';
import 'package:cv_maker/models/contact_info_model.dart';
import 'package:cv_maker/widgets/contact_me.dart';
import 'package:cv_maker/widgets/step_circule.dart';
import 'package:cv_maker/widgets/custom_text_field.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

class ContactInfo extends StatefulWidget {
  @override
  State<ContactInfo> createState() => _ContactInfoState();
}

class _ContactInfoState extends State<ContactInfo> {
  final _formKey = GlobalKey<FormState>();

  // Controllers
  final fullNameController = TextEditingController();
  final emailController = TextEditingController();
  final phoneController = TextEditingController();
  final addressController = TextEditingController();
  final cityController = TextEditingController();
  final linkedinController = TextEditingController();
  final objectiveController = TextEditingController();

  List<String> hedder = [
    'Contact Information',
    'Education',
    'Experience',
    'Skills',
    'Projects',
  ];

  final emailRegex = RegExp(r'^[^@]+@[^@]+\.[^@]+');

  @override
  void dispose() {
    fullNameController.dispose();
    emailController.dispose();
    phoneController.dispose();
    addressController.dispose();
    cityController.dispose();
    linkedinController.dispose();
    objectiveController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Contact Information'),
        actions: [
          IconButton(
            icon: Icon(Icons.info_outline),
            onPressed: () {
              showDialog(
                context: context,
                builder: (context) {
                  return ContactMe();
                },
              );
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              // Steps indicator
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: List.generate(hedder.length, (i) {
                  return stepCircle(hedder[i], i == 0, index: i);
                }),
              ),
              SizedBox(height: 20),

              CustomTextField(
                controller: fullNameController,
                label: 'Full Name',
                hint: 'e.g., Ahmed Mohamed Ibrahim',
                icon: Icons.person,
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Please enter your full name';
                  }
                  if (RegExp(r'[\u0600-\u06FF]').hasMatch(value)) {
                    return 'Please write your data in English only';
                  }
                  return null;
                },
              ),
              SizedBox(height: 12),

              CustomTextField(
                controller: emailController,
                label: 'Email Address',
                hint: 'name@example.com',
                icon: Icons.email,
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Please enter your email';
                  } else if (!emailRegex.hasMatch(value.trim())) {
                    return 'Please enter a valid email';
                  }
                  return null;
                },
              ),
              SizedBox(height: 12),

              CustomTextField(
                controller: phoneController,
                label: 'Phone Number',
                hint: '01234567890',
                icon: Icons.phone,
                keyboardType: TextInputType.phone,
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Please enter your phone number';
                  } else if (!RegExp(r'^\d{11}$').hasMatch(value.trim())) {
                    return 'Phone number must be 11 digits';
                  }
                  return null;
                },
              ),
              SizedBox(height: 12),

              CustomTextField(
                controller: addressController,
                label: 'Home Address',
                hint: '24 Street 5, Miami',
                icon: Icons.home,
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Please enter your home address';
                  } else if (RegExp(r'[\u0600-\u06FF]').hasMatch(value)) {
                    return 'Please write your data in English only';
                  }
                  return null;
                },
              ),
              SizedBox(height: 12),

              CustomTextField(
                controller: cityController,
                label: 'City, State',
                hint: 'Alexandria, Egypt',
                icon: Icons.location_city,
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Please enter your city and state';
                  } else if (RegExp(r'[\u0600-\u06FF]').hasMatch(value)) {
                    return 'Please write your data in English only';
                  }
                  return null;
                },
              ),
              SizedBox(height: 12),

              CustomTextField(
                controller: linkedinController,
                label: 'LinkedIn Profile',
                hint: 'https://www.linkedin.com/in/yourname',
                icon: Icons.link,
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Please enter your LinkedIn link';
                  } else if (!value.startsWith('http') ||
                      !value.contains('linkedin.com')) {
                    return 'Please enter a valid LinkedIn URL';
                  }
                  return null;
                },
              ),
              SizedBox(height: 12),

              CustomTextField(
                controller: objectiveController,
                label: 'Objective',
                hint:
                    'e.g., Communications and Electronics Engineering student at Alexandria University, seeking opportunities to apply skills in app development, programming, and system analysis in a professional environment.',
                icon: Icons.format_align_left,
                isObjective: true,
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Please write your objective';
                  }

                  final arabicRegex = RegExp(r'[\u0600-\u06FF]');
                  if (arabicRegex.hasMatch(value)) {
                    return 'Please write your data in English only';
                  }

                  return null;
                },
              ),

              SizedBox(height: 24),

              ElevatedButton(
                onPressed: () {
                  // if (_formKey.currentState!.validate()) {
                  ContactInfoModel contactInfoModel = ContactInfoModel(
                    linkedIn: linkedinController.text,
                    fullName: fullNameController.text,
                    address: addressController.text,
                    phone: phoneController.text,
                    email: emailController.text,
                    city: cityController.text,
                    objective: objectiveController.text,
                  );

                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder:
                          (context) =>
                              EducationScreen(contactInfo: contactInfoModel),
                    ),
                  );
                  // }
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
