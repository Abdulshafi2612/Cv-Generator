import 'package:flutter/material.dart';

typedef OnTapCallback = Future<void> Function(BuildContext context);

class StyledTextFormField extends StatelessWidget {
  final TextEditingController controller;
  final String label;
  final String hint;
  final IconData icon;
  final bool readOnly;
  final OnTapCallback? onTap;
  final String? Function(String?)? validator;

  const StyledTextFormField({
    Key? key,
    required this.controller,
    required this.label,
    required this.hint,
    required this.icon,
    this.readOnly = false,
    this.onTap,
    this.validator, required int maxLines, required bool alignTop,
  }) : super(key: key);

  InputDecoration get _decoration => InputDecoration(
        labelText: label,
        hintText: hint,
        prefixIcon: Icon(icon, color: Colors.blueAccent),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: Colors.blueAccent.withOpacity(0.5)),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: Colors.blueAccent),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: Colors.redAccent),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: Colors.redAccent.shade700),
        ),
      );

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      readOnly: readOnly,
      onTap: onTap == null ? null : () => onTap!(context),
      autovalidateMode: AutovalidateMode.onUserInteraction,
      decoration: _decoration,
      validator: validator,
    );
  }
}
