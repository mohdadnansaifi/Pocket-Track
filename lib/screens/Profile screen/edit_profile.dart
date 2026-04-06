import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import '../../common_widgets/button.dart';
import '../../common_widgets/custom_circle_avatar.dart';
import '../../common_widgets/custom_snackbar.dart';
import '../../common_widgets/custom_text_fields.dart';
import '../../providers/user_provider.dart';
import '../../services/prefs.dart';
import '../../utils/constants/colors.dart';

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({super.key});

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {

  final _firstNameController =
  TextEditingController(text: PrefsService.firstName);

  final _lastNameController =
  TextEditingController(text: PrefsService.lastName);

  final _salaryController =
  TextEditingController(text: PrefsService.salary.toString());

  File? _image;
  final ImagePicker _picker = ImagePicker();

  Future<void> _pickImage() async {
    final picked =
    await _picker.pickImage(source: ImageSource.gallery);

    if (picked != null) {
      setState(() {
        _image = File(picked.path);
      });
    }
  }

  void _saveProfile() async {
    final salary = double.tryParse(_salaryController.text);

    if (_firstNameController.text.isEmpty ||
        _lastNameController.text.isEmpty ||
        salary == null) {
      CustomSnackbar.show(
        context,
        "Please fill all the fields",
      );
      return;
    }

    await Provider.of<UserProvider>(context, listen: false).updateUser(
      fName: _firstNameController.text,
      lName: _lastNameController.text,
      sal: salary,
      img: _image?.path ?? PrefsService.profileImage,
    );
    if(!mounted)return;
    Navigator.pop(context);
  }

  // ✅ CORRECT PLACE
  @override
  Widget build(BuildContext context) {
    final imagePath = _image?.path ?? PrefsService.profileImage;

    return Scaffold(
      appBar: AppBar(title: const Text("Edit Profile"),
      backgroundColor: UColors.primary,),

      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Stack(
              children: [

                CustomAvatar(
                  radius: 50,
                  imagePath: imagePath,
                  onTap: _pickImage,
                ),
                Positioned(top: 30, left: 0, right: 0,bottom: 50,
                    child: Opacity(
                      opacity: 0.5,
                        child: Icon(Icons.camera_alt,size: 50,)),),
              ],
            ),


            const SizedBox(height: 20),

            CustomTextField(
              controller: _firstNameController,
             label: 'First Name',
            ),

            const SizedBox(height: 12),

            CustomTextField(
              controller: _lastNameController,
              label: 'Last Name',
            ),

            const SizedBox(height: 12),

            CustomTextField(
              controller: _salaryController,
              keyboardType: TextInputType.number,
              label: 'Salary',
            ),

            const SizedBox(height: 30),

            UElevatedButton(
              onPressed: _saveProfile,
              child: const Text("Save Changes"),
            ),
          ],
        ),
      ),
    );
  }
}