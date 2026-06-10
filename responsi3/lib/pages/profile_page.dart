import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../widgets/custom_drawer.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  static const Color navyColor = Color(0xFF16276B);
  Map user = {};
  @override
void initState() {
  super.initState();
  getProfile();
}
Future<void> getProfile() async {
  final prefs = await SharedPreferences.getInstance();

  String? token = prefs.getString('token');

  final response = await http.get(
    Uri.parse('http://127.0.0.1:8000/api/profile'),
    headers: {
      'Accept': 'application/json',
      'Authorization': 'Bearer $token',
    },
  );

  if (response.statusCode == 200) {
    setState(() {
      user = jsonDecode(response.body);
    });
  }
}


  @override
  Widget build(BuildContext context) {
   
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final bgColor = Theme.of(context).scaffoldBackgroundColor;
    final textColor = isDark ? Colors.white : Colors.black;
    final cardBgColor = isDark ? const Color(0xFF1E1E1E) : Colors.white;
    final borderColor = isDark ? Colors.transparent : const Color(0xFFE2E2E2);

    return Scaffold(
      backgroundColor: bgColor,
      drawerScrimColor: Colors.black.withOpacity(0.35),
      drawer: const CustomDrawer(),
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            SliverAppBar(
              pinned: true,
              backgroundColor: bgColor,
              surfaceTintColor: bgColor,
              shadowColor: Colors.transparent,
              scrolledUnderElevation: 0,
              elevation: 0,
              automaticallyImplyLeading: false,
              toolbarHeight: 80,
              titleSpacing: 18,
              title: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                    onTap: () {
                      Navigator.pushNamed(context, '/home');
                    },
                    child: Container(
                      width: 42,
                      height: 42,
                      decoration: BoxDecoration(
                        border: Border.all(color: borderColor),
                        borderRadius: BorderRadius.circular(10),
                        color: cardBgColor,
                      ),
                      child: Icon(
                        Icons.arrow_back_ios_new,
                        color: isDark ? Colors.white : navyColor,
                        size: 18,
                      ),
                    ),
                  ),
                  Text(
                    'Profile',
                    style: GoogleFonts.poppins(
                      fontSize: 18,
                      fontWeight: FontWeight.w700,
                      color: textColor,
                    ),
                  ),
                  Builder(
                    builder: (context) => Container(
                      width: 42,
                      height: 42,
                      decoration: BoxDecoration(
                        border: Border.all(color: borderColor),
                        borderRadius: BorderRadius.circular(10),
                        color: cardBgColor,
                      ),
                      child: IconButton(
                        padding: EdgeInsets.zero,
                        onPressed: () {
                          Scaffold.of(context).openDrawer();
                        },
                        icon: Icon(
                          Icons.tune,
                          color: isDark ? Colors.white : navyColor,
                          size: 22,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 24,
                  vertical: 8,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(20),
                          child: Image.asset(
                            'assets/icons/profile.jpg',
                            width: 96,
                            height: 96,
                            fit: BoxFit.cover,
                          ),
                        ),
                        const SizedBox(width: 18),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
  user['name'] ?? 'Loading...',
  style: GoogleFonts.poppins(
    fontSize: 18,
    fontWeight: FontWeight.w700,
    color: textColor,
  ),
),
                              const SizedBox(height: 4),
Text(
  user['email'] ?? '',
  style: GoogleFonts.poppins(
    fontSize: 14,
    color: isDark ? Colors.white70 : const Color(0xFF8D8D8D),
  ),
),
                              const SizedBox(height: 14),
                              Row(
                                children: [
                                  SvgPicture.asset(
                                    'assets/icons/fb.svg',
                                    width: 32,
                                    height: 32,
                                  ),
                                  const SizedBox(width: 10),
                                  SvgPicture.asset(
                                    'assets/icons/db.svg',
                                    width: 32,
                                    height: 32,
                                  ),
                                  const SizedBox(width: 10),
                                  SvgPicture.asset(
                                    'assets/icons/be.svg',
                                    width: 32,
                                    height: 32,
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 18),
                    Text(
                      'Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugi',
                      style: GoogleFonts.poppins(
                        fontSize: 14,
                        color: isDark ? Colors.white70 : const Color(0xFF6C6C6C),
                        height: 1.5,
                      ),
                    ),
                    const SizedBox(height: 24),
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.symmetric(
                        horizontal: 24,
                        vertical: 18,
                      ),
                      decoration: BoxDecoration(
                        color: navyColor,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'My Resume',
                                style: GoogleFonts.poppins(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w700,
                                  fontSize: 17,
                                ),
                              ),
                              const SizedBox(height: 4),
                              Text(
                                'david_resume.pdf',
                                style: GoogleFonts.poppins(
                                  color: Colors.white,
                                  fontSize: 14,
                                ),
                              ),
                            ],
                          ),
                          SvgPicture.asset(
                            'assets/icons/dk.svg',
                            width: 20,
                            height: 20,
                            colorFilter: const ColorFilter.mode(
                              Colors.white,
                              BlendMode.srcIn,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 30),
                    Text(
                      'Skills',
                      style: GoogleFonts.poppins(
                        fontSize: 16,
                        fontWeight: FontWeight.w700,
                        color: textColor,
                      ),
                    ),
                    const SizedBox(height: 20),
                    Row(
                      children: const [
                        SkillWidget(percent: 70, title: 'Drawing'),
                        SizedBox(width: 24),
                        SkillWidget(percent: 50, title: 'Research'),
                        SizedBox(width: 24),
                        SkillWidget(percent: 80, title: 'Sketch'),
                      ],
                    ),
                    const SizedBox(height: 36),
                    Text(
                      'Experience',
                      style: GoogleFonts.poppins(
                        fontSize: 16,
                        fontWeight: FontWeight.w700,
                        color: textColor,
                      ),
                    ),
                    const SizedBox(height: 24),
                   
                    experienceItem(
                      context,
                      '2018 - Now',
                      'Principal UI Designer',
                      'Kongkalikong Studios',
                      true,
                    ),
                    experienceItem(
                      context,
                      '2015 - 2018',
                      'Lead Graphic Designer',
                      'Skuylah Inc.',
                      false,
                    ),
                    experienceItem(
                      context,
                      '2012 - 2015',
                      'Junior Graphic Designer',
                      'Yokbisa yok Crew',
                      false,
                      isLast: true,
                    ),
                    const SizedBox(height: 30),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  static Widget experienceItem(
    BuildContext context, 
    String year,
    String title,
    String company,
    bool filled, {
    bool isLast = false,
  }) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return IntrinsicHeight(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Column(
            children: [
              Container(
                width: 22,
                height: 22,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: filled ? navyColor : (isDark ? const Color(0xFF1E1E1E) : Colors.white),
                  border: Border.all(
                    color: navyColor,
                    width: 2,
                  ),
                ),
              ),
              if (!isLast)
                Expanded(
                  child: Container(
                    width: 1.5,
                    margin: const EdgeInsets.only(top: 2),
                    color: navyColor,
                  ),
                ),
            ],
          ),
          const SizedBox(width: 18),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(bottom: 24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    year,
                    style: GoogleFonts.poppins(
                      color: isDark ? Colors.white70 : navyColor,
                      fontSize: 14,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    title,
                    style: GoogleFonts.poppins(
                      fontSize: 15,
                      fontWeight: FontWeight.w700,
                      color: isDark ? Colors.white : Colors.black,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    company,
                    style: GoogleFonts.poppins(
                      color: isDark ? Colors.white54 : Colors.grey,
                      fontSize: 14,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class SkillWidget extends StatelessWidget {
  final int percent;
  final String title;

  const SkillWidget({
    super.key,
    required this.percent,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    
    return Column(
      children: [
        SizedBox(
          width: 82,
          height: 82,
          child: Stack(
            fit: StackFit.expand,
            children: [
              CircularProgressIndicator(
                value: percent / 100,
                strokeWidth: 8,
                backgroundColor: isDark ? const Color(0xFF333333) : const Color(0xFFD9D9D9),
                valueColor: AlwaysStoppedAnimation(
                  isDark ? Colors.blueAccent : const Color(0xFF16276B),
                ),
              ),
              Center(
                child: Text(
                  '$percent%',
                  style: GoogleFonts.poppins(
                    fontWeight: FontWeight.w700,
                    color: isDark ? Colors.white : const Color(0xFF16276B),
                    fontSize: 18,
                  ),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 12),
        Text(
          title,
          style: GoogleFonts.poppins(
            fontWeight: FontWeight.w700,
            fontSize: 14,
            color: isDark ? Colors.white : Colors.black,
          ),
        ),
      ],
    );
  }
}