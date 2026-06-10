import 'package:flutter/material.dart';

ValueNotifier<bool> isLightTheme = ValueNotifier(true);
ValueNotifier<Color> primaryColor = ValueNotifier(const Color(0xFFD32F2F));

ThemeData buildThemeData(Color seedColor, bool isLight) {
  final colorScheme = ColorScheme.fromSeed(
    seedColor: seedColor,
    brightness: isLight ? Brightness.light : Brightness.dark,
  );

  return ThemeData(
    useMaterial3: true,
    brightness: isLight ? Brightness.light : Brightness.dark,
    colorScheme: colorScheme,

    
scaffoldBackgroundColor: isLight ? Colors.white : const Color(0xFF121212),

    appBarTheme: AppBarTheme(
      backgroundColor:
          isLight ? Colors.white : const Color(0xFF1E1E1E),
      foregroundColor: isLight ? Colors.black : Colors.white,
      elevation: 0,
      centerTitle: true,
    ),
     cardColor:
        isLight ? const Color(0xFFE8EDF7) : const Color(0xFF1E1E1E),

    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      backgroundColor:
          isLight ? Colors.white : const Color(0xFF1E1E1E),
      selectedItemColor: seedColor,
      unselectedItemColor: isLight ? Colors.grey : Colors.white70,
    ),

    drawerTheme: DrawerThemeData(
      backgroundColor:
          isLight ? Colors.white : const Color(0xFF1E1E1E),
    ),

    textTheme: TextTheme(
      bodyLarge: TextStyle(
        color: isLight ? Colors.black : Colors.white,
      ),
      bodyMedium: TextStyle(
        color: isLight ? Colors.black87 : Colors.white70,
      ),
    ),
  );
}