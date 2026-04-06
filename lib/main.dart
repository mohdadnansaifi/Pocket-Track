import 'package:flutter/material.dart';
import 'package:pocket_track/providers/theme_provider.dart';
import 'package:pocket_track/providers/user_provider.dart';
import 'package:pocket_track/screens/Welcome%20screen/welcome_screen.dart';
import 'package:pocket_track/screens/main_screen.dart';
import 'package:pocket_track/services/prefs.dart';
import 'package:pocket_track/utils/theme/theme.dart';
import 'package:provider/provider.dart';
import '../providers/transactions_provider.dart';

void main()async {
  WidgetsFlutterBinding.ensureInitialized();

  await PrefsService.init();

  runApp(
      MultiProvider(providers: [
        ChangeNotifierProvider(create: (_) => TransactionProvider()),
        ChangeNotifierProvider(create: (_) => ThemeProvider()),
        ChangeNotifierProvider(create: (_) => UserProvider()),

      ],
     child:  const MyApp(),
      )
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    return MaterialApp(
        title: 'Flutter Demo',
        themeMode:themeProvider.themeMode ,
        debugShowCheckedModeBanner: false,
        theme: UAppTheme.lightTheme,
        darkTheme: UAppTheme.darkTheme,
      home: PrefsService.isUserSaved
          ? const MainScreen()
          : const WelcomeScreen(),
    );
  }
}