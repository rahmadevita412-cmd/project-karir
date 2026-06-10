import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';

class NextPage extends StatefulWidget {
  const NextPage({super.key});

  @override
  State<NextPage> createState() => _NextPageState();
}

class _NextPageState extends State<NextPage> {
  int selectedIndex = 0;

  final List<Map<String, String>> items = [
    {
      'title': 'JOB SEEKERS',
      'subtitle': 'Finding a job here never\nbeen easier than before',
      'icon': 'assets/icons/job.svg',
    },
    {
      'title': 'COMPANY',
      'subtitle': 'Let’s recruit your great\ncandidate faster here',
      'icon': 'assets/icons/perus.svg',
    },
    {
      'title': 'JOB SEEKERS',
      'subtitle': 'Finding a job here never\nbeen easier than before',
      'icon': 'assets/icons/job.svg',
    },
    {
      'title': 'COMPANY',
      'subtitle': 'Let’s recruit your great\ncandidate faster here',
      'icon': 'assets/icons/perus.svg',
    },
  ];

  @override
  Widget build(BuildContext context) {
    
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final bgColor = Theme.of(context).scaffoldBackgroundColor;
    final textColor = isDark ? Colors.white : Colors.black;
    final primaryBrandColor = isDark ? Colors.blueAccent : const Color(0xFF1A2B6D);
    final subTextColor = isDark ? Colors.grey[400] : const Color(0xFF8D8D8D);
    final cardBgColor = isDark ? const Color(0xFF1E1E1E) : Colors.white;
    final cardTitleColor = isDark ? Colors.white : const Color(0xFF1A1A1A);
    final cardSubTextColor = isDark ? Colors.white70 : const Color(0xFF4F4F4F);
    final iconContainerColor = isDark ? const Color(0xFF2C2C2C) : const Color(0xFFF1F3FF);

    return Scaffold(
      backgroundColor: bgColor, 
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            children: [
              const SizedBox(height: 26),

              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    width: 68,
                    height: 68,
                    decoration: BoxDecoration(
                      color: primaryBrandColor, 
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Center(
                      child: SvgPicture.asset(
                        'assets/icons/logoo.svg',
                        width: 34,
                        height: 34,
                        colorFilter: const ColorFilter.mode(
                          Colors.white,
                          BlendMode.srcIn,
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(width: 14),

                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Karier',
                        style: GoogleFonts.poppins(
                          fontSize: 30,
                          fontWeight: FontWeight.w700,
                          color: primaryBrandColor, 
                          height: 1,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        'Job Portal App',
                        style: GoogleFonts.poppins(
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                          color: subTextColor, 
                        ),
                      ),
                    ],
                  ),
                ],
              ),

              const SizedBox(height: 78),

              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Who are you?',
                  style: GoogleFonts.poppins(
                    fontSize: 21,
                    fontWeight: FontWeight.w700,
                    color: textColor, 
                  ),
                ),
              ),

              const SizedBox(height: 18),

              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor',
                  style: GoogleFonts.poppins(
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                    color: subTextColor,
                    height: 1.6,
                  ),
                ),
              ),

              const SizedBox(height: 40),

              Expanded(
                child: GridView.builder(
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: items.length,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 4,
                    mainAxisSpacing: 16,
                    crossAxisSpacing: 16,
                    childAspectRatio: 0.62,
                  ),
                  itemBuilder: (context, index) {
                    final item = items[index];
                    final isSelected = selectedIndex == index;

                    return GestureDetector(
                      onTap: () {
                        setState(() {
                          selectedIndex = index;
                        });
                      },
                      child: Stack(
                        clipBehavior: Clip.none,
                        children: [
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 14,
                              vertical: 18,
                            ),
                            decoration: BoxDecoration(
                              color: cardBgColor, 
                              borderRadius: BorderRadius.circular(12),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withOpacity(isDark ? 0.3 : 0.04), 
                                  blurRadius: 12,
                                  offset: const Offset(0, 4),
                                ),
                              ],
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Container(
                                  width: 78,
                                  height: 78,
                                  decoration: BoxDecoration(
                                    color: iconContainerColor, 
                                    borderRadius: BorderRadius.circular(18),
                                  ),
                                  child: Center(
                                    child: SvgPicture.asset(
                                      item['icon']!,
                                      width: 42,
                                      height: 42,
                                    ),
                                  ),
                                ),

                                const SizedBox(height: 24),

                                Text(
                                  item['title']!,
                                  textAlign: TextAlign.center,
                                  style: GoogleFonts.poppins(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w700,
                                    color: cardTitleColor, 
                                  ),
                                ),

                                const SizedBox(height: 14),

                                Expanded(
                                  child: Text(
                                    item['subtitle']!,
                                    textAlign: TextAlign.center,
                                    style: GoogleFonts.poppins(
                                      fontSize: 13,
                                      fontWeight: FontWeight.w400,
                                      color: cardSubTextColor,
                                      height: 1.5,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),

                          if (isSelected)
                            Positioned(
                              bottom: -14,
                              left: 0,
                              right: 0,
                              child: Center(
                                child: Container(
                                  width: 32,
                                  height: 32,
                                  decoration: const BoxDecoration(
                                    color: Color(0xFF17A31B),
                                    shape: BoxShape.circle,
                                  ),
                                  child: const Icon(
                                    Icons.check,
                                    color: Colors.white,
                                    size: 20,
                                  ),
                                ),
                              ),
                            ),
                        ],
                      ),
                    );
                  },
                ),
              ),

              const SizedBox(height: 22),

              SizedBox(
                width: double.infinity,
                height: 58,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.pushNamed(context, '/login');
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: primaryBrandColor, 
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  child: Text(
                    'NEXT',
                    style: GoogleFonts.poppins(
                      fontSize: 15,
                      fontWeight: FontWeight.w700,
                      color: Colors.white,
                      letterSpacing: 0.5,
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 16),
            ],
          ),
        ),
      ),
    );
  }
}