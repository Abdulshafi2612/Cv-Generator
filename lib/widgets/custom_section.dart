import 'package:flutter/material.dart';

class CustomSection extends StatelessWidget {
  final String title;
  final List<Map<String, TextEditingController>> entries;
  final List<Widget> Function(Map<String, TextEditingController>) fieldBuilders;
  final VoidCallback onAdd;
  final void Function(int) onRemove;
  final String addButtonText;

  const CustomSection({
    super.key,
    required this.title,
    required this.entries,
    required this.fieldBuilders,
    required this.onAdd,
    required this.onRemove,
    required this.addButtonText,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 12),
        ...entries.asMap().entries.map((entry) {
          final index = entry.key;
          final controllers = entry.value;
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                '$title #${index + 1}',
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              ...fieldBuilders(controllers).map(
                (w) => Padding(
                  padding: const EdgeInsets.only(bottom: 8.0),
                  child: w,
                ),
              ),
              Align(
                alignment: Alignment.centerRight,
                child: IconButton(
                  icon: const Icon(Icons.delete, color: Colors.red),
                  onPressed: () => onRemove(index),
                ),
              ),
              const Divider(),
            ],
          );
        }),
        Padding(
          padding: const EdgeInsets.only(top: 16.0),
          child: TextButton.icon(
            onPressed: onAdd,
            icon: const Icon(Icons.add),
            label: Text(addButtonText),
          ),
        ),
      ],
    );
  }
}
