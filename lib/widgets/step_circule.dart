import 'package:flutter/material.dart';

Widget stepCircle(String title, bool isActive, {required int index}) {
  return Column(
    children: [
      Container(
        width: 20,
        height: 20,
        decoration: BoxDecoration(
          color: isActive ? Colors.blue : Colors.grey[300],
          shape: BoxShape.circle,
        ),
      ),
      SizedBox(height: 4),
      Text(title, style: TextStyle(fontSize: 10), textAlign: TextAlign.center),
    ],
  );
}
