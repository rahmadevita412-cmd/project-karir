import 'package:flutter/material.dart';
import 'pages/start_page.dart';
import 'pages/next_page.dart';
import 'pages/login_page.dart';
import 'pages/notification_page.dart';
import 'pages/logout_page.dart';
import 'pages/home_page.dart';
import 'pages/elements_page.dart';
import 'pages/message_page.dart';
import 'pages/setting_page.dart';
import 'pages/profile_page.dart'; 

final Map<String, WidgetBuilder> appRoutes = {
  '/': (context) => const GetStartedPage(),
  '/next': (context) => const NextPage(),
  '/login': (context) => const LoginPage(),
  '/home': (context) => const HomePage(),
  '/notification': (context) => const NotificationPage(),
  '/logout': (context) => const LogoutPage(),
  '/elements': (context) => const ElementsPage(),
  '/message': (context) => const MessagePage(),
  '/setting': (context) => const SettingsPage(),
  '/profile': (context) => const ProfilePage(), 
};