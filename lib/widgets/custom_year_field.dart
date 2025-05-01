import 'package:flutter/material.dart';

class CustomYearField extends StatelessWidget {
  final TextEditingController controller;
  final String label;
  final String hint;
  final IconData icon;
  final String bottomSheetTitle;
  final String? Function(String?)? validator;

  const CustomYearField({
    super.key,
    required this.controller,
    required this.label,
    required this.hint,
    required this.icon,
    required this.bottomSheetTitle,
    this.validator,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      readOnly: true,
      onTap: () async {
        final currentYear = DateTime.now().year;
        final startYear = currentYear - 50;
        final endYear = currentYear + 50;

        final years = List.generate(endYear - startYear + 1, (i) => startYear + i).reversed.toList();
        final scrollController = ScrollController(
          initialScrollOffset: years.indexOf(currentYear) * 55,
        );

        await showModalBottomSheet(
          context: context,
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
          ),
          builder: (context) {
            return Container(
              padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 12),
              height: 400,
              child: Column(
                children: [
                  Text(
                    bottomSheetTitle,
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.blueAccent,
                    ),
                  ),
                  const SizedBox(height: 10),
                  const Divider(thickness: 1),
                  Expanded(
                    child: ListView.separated(
                      controller: scrollController,
                      itemCount: years.length,
                      separatorBuilder: (_, __) => const Divider(height: 1),
                      itemBuilder: (context, index) {
                        final year = years[index];
                        return ListTile(
                          title: Center(
                            child: Text(
                              year.toString(),
                              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
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
      },
      autovalidateMode: AutovalidateMode.onUserInteraction,
      decoration: InputDecoration(
        labelText: label,
        hintText: hint,
        prefixIcon: Icon(icon),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
        contentPadding: const EdgeInsets.symmetric(vertical: 14, horizontal: 16),
      ),
      validator: validator,
    );
  }
}
