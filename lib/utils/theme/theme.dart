
import 'package:flutter/material.dart';
import 'package:pocket_track/utils/theme/widget%20theme/appbar_theme.dart';
import 'package:pocket_track/utils/theme/widget%20theme/elevated_button_theme.dart';
import 'package:pocket_track/utils/theme/widget%20theme/outlined_button_theme.dart';
import 'package:pocket_track/utils/theme/widget%20theme/text_field_theme.dart';
import 'package:pocket_track/utils/theme/widget%20theme/text_theme.dart';

import '../constants/colors.dart';

class UAppTheme{
  UAppTheme._();

  static ThemeData lightTheme = ThemeData(
    useMaterial3: true,
    fontFamily: 'Nunito',
    brightness: Brightness.light,
    primaryColor: UColors.primary,
    disabledColor: Colors.grey,
    textTheme: UTextTheme.lightTextTheme,
    scaffoldBackgroundColor:UColors.white ,
    appBarTheme:UAppBarTheme.lightAppBarTheme ,
    elevatedButtonTheme: UElevatedButtonTheme.lightElevatedButtonTheme,
    inputDecorationTheme:UTextFormFieldTheme.lightInputDecorationTheme ,
    outlinedButtonTheme: UOutlinedButtonTheme.lightOutlinedButtonTheme,
  );
  static ThemeData darkTheme = ThemeData(
    useMaterial3: true,
    fontFamily: 'Nunito',
    brightness: Brightness.dark,
    primaryColor: UColors.primary,
    disabledColor: Colors.grey,
    textTheme: UTextTheme.darkTextTheme,
    scaffoldBackgroundColor:UColors.black ,
    appBarTheme:UAppBarTheme.darkAppBarTheme ,
    elevatedButtonTheme:UElevatedButtonTheme.darkElevatedButtonTheme ,
    inputDecorationTheme:UTextFormFieldTheme.darkInputDecorationTheme,
    outlinedButtonTheme: UOutlinedButtonTheme.darkOutlinedButtonTheme,
  );
}