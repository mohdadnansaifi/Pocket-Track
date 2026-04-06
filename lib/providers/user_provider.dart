import 'package:flutter/material.dart';
import '../services/prefs.dart';

class UserProvider with ChangeNotifier {
  String firstName = '';
  String lastName = '';
  double salary = 0;
  String? imagePath;

  UserProvider() {
    loadUser();
  }

  void loadUser() {
    firstName = PrefsService.firstName;
    lastName = PrefsService.lastName;
    salary = PrefsService.salary;
    imagePath = PrefsService.profileImage;

    notifyListeners();
  }

  Future<void> updateUser({
    required String fName,
    required String lName,
    required double sal,
    String? img,
  }) async {
    await PrefsService.saveUserDetails(
      firstName: fName,
      lastName: lName,
      salary: sal,
      gender: PrefsService.gender,
      imagePath: img,
    );

    // update local state
    firstName = fName;
    lastName = lName;
    salary = sal;
    imagePath = img;

    notifyListeners(); // 🔥 THIS IS KEY
  }

  void clearUser() {
    firstName = '';
    lastName = '';
    salary = 0;
    imagePath = null;

    notifyListeners(); // 🔥 important
  }
}