import 'package:flutter/material.dart';
import 'package:pocket_track/common_widgets/custom_circle_avatar.dart';
import 'package:provider/provider.dart';
import '../../../providers/user_provider.dart';
import '../../../services/prefs.dart';
import '../../../utils/constants/colors.dart';
import '../../Profile screen/profile_screen.dart';

class GreetingWithProfilePic extends StatelessWidget {
  const GreetingWithProfilePic({super.key});

  @override
  Widget build(BuildContext context) {
    final imagePath = PrefsService.profileImage;
    final user = Provider.of<UserProvider>(context);


    return Row(
      children: [

        // 🔹 Profile Image
        GestureDetector(
          onTap:(){ Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => const ProfileScreen(),
            ),
          );},
          child: CustomAvatar(
            imagePath: imagePath,
            radius: 20,
          )
        ),

        const SizedBox(width: 12),

        // 🔹 Greeting Text
        Text(
          "Hello, ${user.firstName} 👋",
          style: const TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,color: UColors.white
          ),
        ),
      ],
    );
  }
}