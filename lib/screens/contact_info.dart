import 'package:cv_maker/screens/education_screen.dart';
import 'package:cv_maker/models/contact_info_model.dart';
import 'package:cv_maker/widgets/step_circule.dart';
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

  InputDecoration buildInputDecoration({
    required String label,
    required String hint,
    required IconData icon,
  }) {
    return InputDecoration(
      labelText: label,
      hintText: hint,
      prefixIcon: Icon(icon),
      border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
      contentPadding: EdgeInsets.symmetric(vertical: 14, horizontal: 16),
    );
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
                  return AlertDialog(
                    title: Text('Contact Me'),
                    content: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          'Mohammad Abdul-Shafi',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                          ),
                        ),
                        // Text('+201274018376'),
                        SizedBox(height: 16),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            IconButton(
                              icon: Icon(Icons.facebook, color: Colors.blue),
                              onPressed: () async {
                                final fbAppUrl = Uri.parse(
                                  "fb://facewebmodal/f?href=https://www.facebook.com/shefoo26122003",
                                );
                                final fbWebUrl = Uri.parse(
                                  "https://www.facebook.com/shefoo26122003",
                                );

                                // نحاول نفتح التطبيق، ولو فشل نفتح الموقع
                                if (await canLaunchUrl(fbAppUrl)) {
                                  await launchUrl(fbAppUrl);
                                } else {
                                  await launchUrl(
                                    fbWebUrl,
                                    mode: LaunchMode.externalApplication,
                                  );
                                }
                              },
                            ),
                            IconButton(
                              icon: FaIcon(
                                FontAwesomeIcons.linkedin,
                                color: Colors.blue,
                              ),
                              onPressed: () async {
                                final url = Uri.parse(
                                  "https://www.linkedin.com/in/mohammad-abdul-shafi-a8935a21b/",
                                );
                                await launchUrl(
                                  url,
                                  mode: LaunchMode.externalApplication,
                                );
                              },
                            ),
                            IconButton(
                              icon: FaIcon(
                                FontAwesomeIcons.whatsapp,
                                color: Colors.green,
                              ),
                              onPressed: () async {
                                final phone = '+201200466959';
                                final url = Uri.parse(
                                  "https://wa.me/${phone.replaceAll('+', '')}",
                                );
                                await launchUrl(
                                  url,
                                  mode: LaunchMode.externalApplication,
                                );
                              },
                            ),
                          ],
                        ),
                      ],
                    ),
                    actions: [
                      TextButton(
                        child: Text('Close'),
                        onPressed: () => Navigator.of(context).pop(),
                      ),
                    ],
                  );
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
                  return stepCircle(hedder[i], i == 0 ? true : false, index: i);
                }),
              ),
              SizedBox(height: 20),

              // Full Name
              TextFormField(
                autovalidateMode: AutovalidateMode.onUserInteraction,
                controller: fullNameController,
                decoration: buildInputDecoration(
                  label: 'Full Name',
                  hint: 'e.g., Ahmed Mohamed Ibrahim ',
                  icon: Icons.person,
                ),
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Please enter your full name';
                  }
                  final arabicRegex = RegExp(r'[\u0600-\u06FF]');
                  if (arabicRegex.hasMatch(value)) {
                    return 'Please write your data in English only';
                  }
                  return null;
                },
              ),
              SizedBox(height: 12),

              // Email
              TextFormField(
                // autovalidateMode: AutovalidateMode.onUserInteraction,
                controller: emailController,
                decoration: buildInputDecoration(
                  label: 'Email Address',
                  hint: 'name@example.com',
                  icon: Icons.email,
                ),
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

              // Phone
              TextFormField(
                // autovalidateMode: AutovalidateMode.onUserInteraction,
                controller: phoneController,
                keyboardType: TextInputType.phone,
                decoration: buildInputDecoration(
                  label: 'Phone Number',
                  hint: '01234567890',
                  icon: Icons.phone,
                ),
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Please enter your phone number';
                  } else if (!RegExp(r'^\d+$').hasMatch(value.trim())) {
                    return 'Phone number must contain digits only';
                  } else if (!RegExp(r'^\d{11}$').hasMatch(value.trim())) {
                    return 'Phone number must be 11 digits';
                  }
                  return null;
                },
              ),
              SizedBox(height: 12),

              // Address
              TextFormField(
                autovalidateMode: AutovalidateMode.onUserInteraction,
                controller: addressController,
                decoration: buildInputDecoration(
                  label: 'Home Address',
                  hint: '24 Street 5, Miami',
                  icon: Icons.home,
                ),
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Please enter your home address';
                  }
                  final arabicRegex = RegExp(r'[\u0600-\u06FF]');
                  if (arabicRegex.hasMatch(value)) {
                    return 'Please write your data in English only';
                  }
                  return null;
                },
              ),
              SizedBox(height: 12),

              // City
              TextFormField(
                autovalidateMode: AutovalidateMode.onUserInteraction,
                controller: cityController,
                decoration: buildInputDecoration(
                  label: 'City, State',
                  hint: 'Alexandria, Egypt',
                  icon: Icons.location_city,
                ),
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Please enter your city and state';
                  }
                  final arabicRegex = RegExp(r'[\u0600-\u06FF]');
                  if (arabicRegex.hasMatch(value)) {
                    return 'Please write your data in English only';
                  }
                  return null;
                },
              ),
              SizedBox(height: 12),

              // LinkedIn
              TextFormField(
                // autovalidateMode: AutovalidateMode.onUserInteraction,
                controller: linkedinController,
                decoration: buildInputDecoration(
                  label: 'LinkedIn Profile',
                  hint: 'https://www.linkedin.com/in/yourname',
                  icon: Icons.link,
                ),
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
              SizedBox(height: 20),

              // Objective
              TextFormField(
                autovalidateMode: AutovalidateMode.onUserInteraction,
                controller: objectiveController,
                maxLines: 5,
                decoration: InputDecoration(
                  labelText: 'Objective',
                  hintText:
                      'e.g., Communications and Electronics Engineering student at Alexandria University, seeking opportunities to apply skills in app development, programming, and system analysis in a professional environment.',
                  prefixIcon: Icon(Icons.format_align_left),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  alignLabelWithHint: true,
                  contentPadding: EdgeInsets.all(16),
                ),
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Please write your objective';
                  }

                  // Check for Arabic letters
                  final arabicRegex = RegExp(r'[\u0600-\u06FF]');
                  if (arabicRegex.hasMatch(value)) {
                    return 'Please write your data in English only';
                  }

                  return null;
                },
              ),

              SizedBox(height: 24),

              // Next Step Button
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    setState(() {
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
                              (context) => EducationScreen(
                                contactInfo: contactInfoModel,
                              ),
                        ),
                      );
                    });
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
