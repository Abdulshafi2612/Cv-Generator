import 'package:flutter/material.dart';

class SectionControllers {
  // Create controllers for training, courses, and activities
  static Map<String, TextEditingController> createTraining() => {
    'place': TextEditingController(),
    'name': TextEditingController(),
    'desc': TextEditingController(),
    'date': TextEditingController(),
  };

  static Map<String, TextEditingController> createCourse() => {
    'place': TextEditingController(),
    'date': TextEditingController(),
    'course': TextEditingController(),
  };

  static Map<String, TextEditingController> createActivity() => {
    'title': TextEditingController(),
    'date': TextEditingController(),
    'desc': TextEditingController(),
  };

  // Dispose all controllers in the list
  static void disposeControllers(List<Map<String, TextEditingController>> list) {
    for (var m in list) {
      for (var ctrl in m.values) {
        ctrl.dispose();
      }
    }
  }

  // General validation for text fields
  static String? validateText(String? value) {
    if (value == null || value.trim().isEmpty) return 'Required';
    final arabicRegex = RegExp(r'[\u0600-\u06FF]');
    if (arabicRegex.hasMatch(value)) return 'Please write your data in English only';
    return null;
  }

  // Validate year fields (if needed, can add more validation logic here)
  static String? validateYear(String? value) {
    if (value == null || value.trim().isEmpty) return 'Required';
    final yearRegex = RegExp(r'^\d{4}$');
    if (!yearRegex.hasMatch(value)) return 'Please enter a valid year (e.g., 2023)';
    return null;
  }
  static Map<String, TextEditingController> createSoftSkill() => {
  'skill': TextEditingController(),
};
}
