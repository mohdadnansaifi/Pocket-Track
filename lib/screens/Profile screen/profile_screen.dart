import 'package:flutter/material.dart';
import 'package:pocket_track/common_widgets/custom_circle_avatar.dart';
import 'package:pocket_track/screens/Profile%20screen/setting_screen.dart';
import 'package:provider/provider.dart';
import '../../providers/transactions_provider.dart';
import '../../providers/user_provider.dart';
import '../../services/prefs.dart';
import '../../utils/constants/colors.dart';
import '../Welcome screen/welcome_screen.dart';
import 'edit_profile.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  bool isDarkMode = false;

  void _logout() async {
    final transactionProvider =
    Provider.of<TransactionProvider>(context, listen: false);
    final userProvider = Provider.of<UserProvider>(context, listen: false);

    // 🔹 Clear DB + Provider
    await transactionProvider.clearAllTransactions();
    userProvider.clearUser();
    await PrefsService.clear();
    if(!mounted)return;
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (_) => const WelcomeScreen()),
      (route) => false,
    );
  }

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserProvider>(context);
    final imagePath = user.imagePath;
    return Scaffold(
      appBar: AppBar(title: const Text("Profile",style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),),centerTitle: true,
      backgroundColor: UColors.primary),

      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            // 🔹 Profile Section
            const SizedBox(height: 20,),
            CustomAvatar(imagePath: imagePath, radius: 50),

            const SizedBox(height: 5),

            Text(
              "${user.firstName} ${user.lastName}",
              style: const TextStyle(fontSize: 22, fontWeight: FontWeight.w700),
            ),

            // 🔹 Settings Section
            const Divider(),
            ListTile(
              leading: const Icon(Icons.edit),
              title: const Text("Edit Profile",style: TextStyle(fontSize: 18),),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => const EditProfileScreen()),
                );
              },
            ),

            const Divider(),

            ListTile(
              leading: const Icon(Icons.settings),
              title: const Text("Settings",style: TextStyle(fontSize: 18)),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => const SettingsScreen()),
                );
              },
            ),

            const Divider(),

            // 🔹 Logout
            ListTile(
              leading: const Icon(Icons.logout, color: Colors.red),
              title: const Text("Logout", style: TextStyle(color: Colors.red,fontSize: 18)),
              onTap: _logout,
            ),
            const Divider(),
          ],
        ),
      ),
    );
  }
}
