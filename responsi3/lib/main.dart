import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'routes.dart';
import 'theme/app_theme.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<bool>(
      valueListenable: isLightTheme,
      builder: (context, isLight, _) {
        return ValueListenableBuilder<Color>(
          valueListenable: primaryColor,
          builder: (context, color, _) {
            return MaterialApp(
              debugShowCheckedModeBanner: false,
              initialRoute: '/',
              routes: appRoutes,
              theme: buildThemeData(color, true).copyWith(
                textTheme: GoogleFonts.poppinsTextTheme(
                   buildThemeData(color, true).textTheme,
                ),
              ),
              darkTheme: buildThemeData(color, false).copyWith(
                textTheme: GoogleFonts.poppinsTextTheme(
                  buildThemeData(color, false).textTheme,
                ),
              ),
              themeMode: isLight ? ThemeMode.light : ThemeMode.dark,
            );
          },
        );
      },
    );
  }
}