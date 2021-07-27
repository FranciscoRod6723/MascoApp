import 'package:flutter/material.dart';

Widget buildInput(String title, TextEditingController controller) => TextFormField(
    style: TextStyle(fontSize: 18),
    maxLines: 3,
    decoration: InputDecoration(
      labelText: title,
      border: UnderlineInputBorder(),
      hintText: title,
    ),
    validator: (title) => 
      title != null && title.isEmpty ? title + 'cannot be emty' : null,
    controller: controller,
  );