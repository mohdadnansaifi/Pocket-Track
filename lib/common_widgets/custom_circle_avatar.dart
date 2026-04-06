import 'dart:io';
import 'package:flutter/material.dart';

class CustomAvatar extends StatelessWidget {
  final String? imagePath;
  final double radius;
  final VoidCallback? onTap;

  const CustomAvatar({
    super.key,
    this.imagePath,
    this.radius = 30,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(2), // 👈 border thickness
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          border: Border.all(
            color: Colors.blue, // 🔵 border color
            width: 2,
          ),
        ),
        child: CircleAvatar(
          radius: radius,
          backgroundColor: Colors.grey.shade200,
          backgroundImage:
          imagePath != null ? FileImage(File(imagePath!)) : null,
          child: imagePath == null
              ? Icon(Icons.person, size: radius, color: Colors.grey)
              : null,
        ),
      ),
    );
  }
}