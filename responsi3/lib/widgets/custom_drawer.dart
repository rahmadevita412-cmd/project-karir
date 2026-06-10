import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomDrawer extends StatelessWidget {
  const CustomDrawer({super.key});

  Widget buildMenuItem({
    required BuildContext context,
    required IconData icon,
    required String title,
    required String route,
    bool isActive = false,
    Color iconColor = const Color(0xFFAAAAAA),
  }) {
    
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final defaultColor = isDark ? Colors.white70 : iconColor;

    return GestureDetector(
      onTap: () {
        Navigator.pop(context);
        Navigator.pushNamed(context, route);
      },
      child: Container(
        width: double.infinity,
        margin: const EdgeInsets.only(bottom: 12),
        padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 14),
        decoration: BoxDecoration(
          gradient: isActive
              ? const LinearGradient(
                  colors: [
                    Color(0xFF1D2B6B),
                    Color(0xFF6670A9),
                  ],
                  begin: Alignment.centerLeft,
                  end: Alignment.centerRight,
                )
              : null,
          color: isActive ? null : Colors.transparent,
          borderRadius: const BorderRadius.only(
            topRight: Radius.circular(12),
            bottomRight: Radius.circular(12),
          ),
        ),
        child: Row(
          children: [
            Icon(
              icon,
              color: isActive ? Colors.white : defaultColor,
              size: 22,
            ),
            const SizedBox(width: 16),
            Text(
              title,
              style: TextStyle(
                fontSize: 15,
                fontWeight: isActive ? FontWeight.w600 : FontWeight.w500,
                color: isActive ? Colors.white : defaultColor,
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
  
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Drawer(
      width: 285,
     
      backgroundColor: Theme.of(context).drawerTheme.backgroundColor ?? (isDark ? const Color(0xFF1E1E1E) : Colors.white),
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 14),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header Logo + Close
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Container(
                        width: 54,
                        height: 54,
                        padding: const EdgeInsets.all(7),
                        decoration: BoxDecoration(
                          color: const Color(0xFF1D2B6B),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: SvgPicture.asset(
                          'assets/icons/logoo.svg',
                          colorFilter: const ColorFilter.mode(
                            Colors.white,
                            BlendMode.srcIn,
                          ),
                        ),
                      ),
                      const SizedBox(width: 10),
                      Text(
                        'Karier',
                        style: GoogleFonts.poppins(
                          fontSize: 30,
                          fontWeight: FontWeight.w700,
                         
                          color: isDark ? Colors.white : const Color(0xFF18286D),
                        ),
                      ),
                    ],
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: Container(
                      width: 26,
                      height: 26,
                      decoration: BoxDecoration(
                        color: isDark ? const Color(0xFF333333) : const Color(0xFFCFCFCF),
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(
                        Icons.close,
                        size: 16,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 28),
              buildMenuItem(
                context: context,
                icon: Icons.home_filled,
                title: 'Home',
                route: '/home',
                isActive: true,
                iconColor: const Color(0xFFAAAAAA),
              ),
              buildMenuItem(
                context: context,
                icon: Icons.notifications,
                title: 'Notifications (2)',
                route: '/notification',
              ),
              buildMenuItem(
                context: context,
                icon: Icons.person,
                title: 'Profile',
                route: '/profile',
              ),
              buildMenuItem(
                context: context,
                icon: Icons.message,
                title: 'Message',
                route: '/message',
              ),
              buildMenuItem(
                context: context,
                icon: Icons.grid_view_rounded,
                title: 'Elements',
                route: '/elements',
              ),
              buildMenuItem(
                context: context,
                icon: Icons.settings,
                title: 'Setting',
                route: '/setting',
              ),
              buildMenuItem(
                context: context,
                icon: Icons.logout,
                title: 'Logout',
                route: '/logout',
                iconColor: const Color(0xFFFF5A5F),
              ),
              const Spacer(),
              Padding(
                padding: const EdgeInsets.only(bottom: 18),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Karier Job Portal',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w700,
                        color: isDark ? Colors.white70 : const Color(0xFFB5B5C8),
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      'App Version 1.0.0',
                      style: TextStyle(
                        fontSize: 12,
                        color: isDark ? Colors.white54 : const Color(0xFFB5B5C8),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}