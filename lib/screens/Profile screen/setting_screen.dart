
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../providers/theme_provider.dart';
import '../../utils/constants/colors.dart';


class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
    @override
    Widget build(BuildContext context) {
       final themeProvider = Provider.of<ThemeProvider>(context);

      return Scaffold(
        appBar: AppBar(title: const Text("Settings",style: TextStyle(color: UColors.white),),
        backgroundColor: UColors.primary,),

        body: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text("Theme"),

              RadioGroup<ThemeMode>(
                groupValue: themeProvider.themeMode,
                onChanged: (value) {
                  themeProvider.setTheme(value!);
                },
                child: Column(
                  children: const [
                    RadioListTile(
                      value: ThemeMode.system,
                      title: Text("System"),
                    ),
                    RadioListTile(
                      value: ThemeMode.light,
                      title: Text("Light"),
                    ),
                    RadioListTile(
                      value: ThemeMode.dark,
                      title: Text("Dark"),
                    ),
                  ],
                ),
              ),
            ],
          )
        ),
      );
    }
  }
