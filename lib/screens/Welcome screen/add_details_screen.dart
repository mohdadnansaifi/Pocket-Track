import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:pocket_track/common_widgets/custom_snackbar.dart';
import 'package:provider/provider.dart';

import '../../common_widgets/button.dart';
import '../../common_widgets/custom_text_fields.dart';
import '../../providers/user_provider.dart';
import '../main_screen.dart';

class AddDetailsScreen extends StatefulWidget {
  const AddDetailsScreen({super.key});

  @override
  State<AddDetailsScreen> createState() => _AddDetailsScreenState();
}

class _AddDetailsScreenState extends State<AddDetailsScreen> {
  final _firstNameController = TextEditingController();
  final _lastNameController = TextEditingController();
  final _salaryController = TextEditingController();

  String _gender = 'Male';
  File? _image;

  final ImagePicker _picker = ImagePicker();

  Future<void> _pickImage() async {
    final pickedFile =
    await _picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      setState(() {
        _image = File(pickedFile.path);
      });
    }
  }

  void _saveDetails() async {
    final firstName = _firstNameController.text.trim();
    final lastName = _lastNameController.text.trim();
    final salaryText = _salaryController.text.trim();

    // 🔥 VALIDATION
    if (firstName.isEmpty) {
      CustomSnackbar.show(context, "First name is required");
      return;
    }

    if (lastName.isEmpty) {
      CustomSnackbar.show(context, "Last name is required");
      return;
    }

    if (salaryText.isEmpty) {
      CustomSnackbar.show(context, "Please enter your salary");
      return;
    }

    final salary = double.tryParse(salaryText);

    if (salary == null || salary <= 0) {
      CustomSnackbar.show(context, "Enter a valid salary");
      return;
    }

    final userProvider =
    Provider.of<UserProvider>(context, listen: false);

    try {
      await userProvider.updateUser(
        fName: firstName,
        lName: lastName,
        sal: salary,
        img: _image?.path,
      );

      if (!mounted) return;

      CustomSnackbar.show(context, "Details Saved!");

      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (_) => const MainScreen()),
            (route) => false,
      );

    } catch (e) {
      if (!mounted) return;

      CustomSnackbar.show(context, "Failed to save details");
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Your Details")),

      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [

            // 🔹 Profile Image
            GestureDetector(
              onTap: _pickImage,
              child: CircleAvatar(
                radius: 50,
                backgroundImage:
                _image != null ? FileImage(_image!) : null,
                child: _image == null
                    ? const Icon(Icons.camera_alt, size: 30)
                    : null,
              ),
            ),

            const SizedBox(height: 20),

            // 🔹 First Name
            CustomTextField(
              controller: _firstNameController,
              label: 'First Name',
            ),

            const SizedBox(height: 12),

            // 🔹 Last Name
            CustomTextField(
              controller: _lastNameController,
              label: 'Last Name',
            ),

            const SizedBox(height: 12),

            // 🔹 Salary
            CustomTextField(
              controller: _salaryController,
              keyboardType: TextInputType.number,
             label: 'Monthly salary',
            ),

            const SizedBox(height: 20),

            // 🔹 Gender
            Row(
              children: [
                const Text("Gender: "),
                const SizedBox(width: 10),

                ChoiceChip(
                  label: const Text("Male"),
                  selected: _gender == 'Male',
                  onSelected: (_) {
                    setState(() => _gender = 'Male');
                  },
                ),

                const SizedBox(width: 10),

                ChoiceChip(
                  label: const Text("Female"),
                  selected: _gender == 'Female',
                  onSelected: (_) {
                    setState(() => _gender = 'Female');
                  },
                ),
              ],
            ),

            const SizedBox(height: 30),

            // 🔹 Save Button
            SizedBox(
              width: double.infinity,
              child: UElevatedButton(
                onPressed: _firstNameController.text.isEmpty ||
                    _lastNameController.text.isEmpty ||
                    _salaryController.text.isEmpty
                    ? null
                    : _saveDetails,
                child: const Text("Save Details"),
              ),
            ),
          ],
        ),
      ),
    );
  }
}