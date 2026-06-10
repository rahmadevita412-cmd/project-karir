import 'package:flutter/material.dart';
import 'package:responsi3/pages/categories_page.dart';
import 'package:responsi3/pages/latest_page.dart';
import 'package:responsi3/pages/profile_page.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List categories = [];
List companies = [];
List vacancies = [];
String userName = 'Guest';
  Future<void> getCategories() async {
  final response = await http.get(
    Uri.parse('http://127.0.0.1:8000/api/categories'),
  );

  if (response.statusCode == 200) {
    setState(() {
      categories = jsonDecode(response.body);
    });
  }
}
Future<void> getCompanies() async {
  final response = await http.get(
    Uri.parse('http://127.0.0.1:8000/api/companies'),
  );

  print(response.body);

  if (response.statusCode == 200) {
    setState(() {
      companies = jsonDecode(response.body);
    });
  }
}
Future<void> getVacancies() async {
  final response = await http.get(
    Uri.parse('http://127.0.0.1:8000/api/vacancies'),
  );

  if (response.statusCode == 200) {
    setState(() {
      vacancies = jsonDecode(response.body);
    });
  }
}
Future<void> getUserName() async {
  final prefs = await SharedPreferences.getInstance();

  setState(() {
    userName = prefs.getString('name') ?? 'Guest';
  });
}
@override
void initState() {
  super.initState();
  getCategories();
  getCompanies();
  getVacancies();
  getUserName();
}
  @override
  Widget build(BuildContext context) {
 
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final bgColor = isDark ? Theme.of(context).scaffoldBackgroundColor : const Color(0xFFF9FAFC);

    return Scaffold(
      backgroundColor: bgColor,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 24.0,
              vertical: 20.0,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildHeader(),
                const SizedBox(height: 24),
                _buildSearchBar(),
                const SizedBox(height: 24),
                _buildStatsCards(),
                const SizedBox(height: 32),
                _buildSectionTitle('Categories', 'More'),
                const SizedBox(height: 16),
                _buildCategoriesList(),
                const SizedBox(height: 32),
                _buildCompaniesList(),
                const SizedBox(height: 32),
                _buildSectionTitle('Latest Vacancies', 'More'),
                const SizedBox(height: 16),
                _buildLatestVacanciesGrid(),
                const SizedBox(height: 30),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildHeader() {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Good Morning',
              style: TextStyle(fontSize: 14, color: isDark ? Colors.white70 : Colors.black87),
            ),
            const SizedBox(height: 4),
            Text(
  userName,
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.w800,
                color: isDark ? Colors.white : Colors.black,
              ),
            ),
          ],
        ),
        InkWell(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const ProfilePage(),
              ),
            );
          },
          child: ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: Image.asset(
              'assets/icons/profile.jpg',
              width: 50,
              height: 50,
              fit: BoxFit.cover,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildSearchBar() {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final containerColor = isDark ? const Color(0xFF1E1E1E) : Colors.white;
    final borderColor = isDark ? Colors.transparent : Colors.grey.shade200;
    final hintAndIconColor = isDark ? Colors.grey.shade500 : Colors.grey;
    final textColor = isDark ? Colors.white : Colors.black;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
        color: containerColor,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: borderColor),
      ),
      child: TextField(
        style: TextStyle(color: textColor), 
        decoration: InputDecoration(
          hintText: 'Search job here...',
          hintStyle: TextStyle(color: hintAndIconColor, fontSize: 14),
          border: InputBorder.none,
          suffixIcon: Icon(Icons.search, color: hintAndIconColor),
        ),
      ),
    );
  }

  Widget _buildStatsCards() {
    double screenWidth = MediaQuery.of(context).size.width;
    double statWidth = screenWidth > 800 ? (screenWidth - 100) / 4 : screenWidth * 0.7;

    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      clipBehavior: Clip.none,
      child: Row(
        children: [
          _buildStatCard('874', 'Jobs Applied', const Color(0xFF1B223C), true, statWidth),
          const SizedBox(width: 16),
          _buildStatCard('34', 'Interviewed', const Color(0xFF2563EB), false, statWidth),
          const SizedBox(width: 16),
          _buildStatCard('874', 'Jobs Applied', const Color(0xFFFF4D4F), true, statWidth),
          const SizedBox(width: 16),
          _buildStatCard('34', 'Interviewed', const Color(0xFFA855F7), false, statWidth),
        ],
      ),
    );
  }

  Widget _buildStatCard(String count, String label, Color bgColor, bool isUp, double cardWidth) {

    return Container(
      width: cardWidth,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Flexible(
                child: Text(
                  count,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 28,
                    fontWeight: FontWeight.w900,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              const Icon(Icons.ssid_chart, color: Colors.white, size: 36),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            label,
            style: const TextStyle(
              color: Colors.white70,
              fontSize: 13,
              fontWeight: FontWeight.w500,
            ),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Icon(
                isUp ? Icons.arrow_drop_up : Icons.arrow_drop_down,
                color: isUp ? const Color(0xFF4ADE80) : const Color(0xFFF87171),
              ),
              const Text(
                '0.6%',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildSectionTitle(String title, String actionText) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w800,
            color: isDark ? Colors.white : Colors.black87,
          ),
        ),
        Text(
          actionText,
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.bold,
            color: isDark ? Colors.blueAccent : const Color(0xFF1B223C),
          ),
        ),
      ],
    );
  }

  Widget _buildCategoriesList() {
  double screenWidth = MediaQuery.of(context).size.width;
  double catWidth =
      screenWidth > 800 ? (screenWidth - 100) / 4 : screenWidth * 0.45;

  return SingleChildScrollView(
    scrollDirection: Axis.horizontal,
    child: Row(
      children: categories.map<Widget>((category) {
        return Padding(
          padding: const EdgeInsets.only(right: 12),
          child: _buildCategoryItem(
            Icons.work,
            category['name'],
            catWidth,
          ),
        );
      }).toList(),
    ),
  );
}

  Widget _buildCategoryItem(IconData icon, String title, double catWidth) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final bgColor = isDark ? const Color(0xFF1E1E1E) : const Color(0xFFEEF2FF);
    final borderColor = isDark ? Colors.grey.shade800 : const Color(0xFFD6E4FF);
    final iconAndTextColor = isDark ? Colors.blueAccent : const Color(0xFF1D4ED8);

    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const CategoriesPage()),
        );
      },
      borderRadius: BorderRadius.circular(10),
      child: Container(
        width: catWidth,
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
        decoration: BoxDecoration(
          color: bgColor,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: borderColor),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: 20, color: iconAndTextColor),
            const SizedBox(width: 8),
            Expanded(
              child: Text(
                title,
                style: TextStyle(
                  color: iconAndTextColor,
                  fontWeight: FontWeight.bold,
                  fontSize: 14,
                ),
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCompaniesList() {
  double screenWidth = MediaQuery.of(context).size.width;
  double compWidth =
      screenWidth > 800 ? (screenWidth - 100) / 4 : screenWidth * 0.55;

  return SingleChildScrollView(
    scrollDirection: Axis.horizontal,
    clipBehavior: Clip.none,
    child: Row(
      children: companies.map<Widget>((company) {
        return Padding(
          padding: const EdgeInsets.only(right: 16),
          child: _buildCompanyCard(
            company['name'],
            company['location'],
            '${company['vacancy_count']} Vacancy',
            const Color(0xFF16A34A),
            true,
            compWidth,
          ),
        );
      }).toList(),
    ),
  );
}
  Widget _buildCompanyCard(
    String name,
    String location,
    String vacancy,
    Color color,
    bool isC,
    double compWidth,
  ) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final cardBg = isDark ? const Color(0xFF1E1E1E) : Colors.white;
    final borderColor = isDark ? Colors.transparent : Colors.grey.shade100;
    final shadowColor = isDark ? Colors.black.withOpacity(0.3) : Colors.grey.withOpacity(0.04);
    
    final nameColor = isDark ? Colors.white : Colors.black87;
    final locColor = isDark ? Colors.grey.shade400 : Colors.grey.shade600;
    final vacColor = isDark ? Colors.blueAccent : const Color(0xFF1B223C);

    return Container(
      width: compWidth,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: cardBg,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: borderColor),
        boxShadow: [
          BoxShadow(
            color: shadowColor,
            blurRadius: 10,
            spreadRadius: 2,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        children: [
          Container(
            height: 60,
            width: 60,
            decoration: BoxDecoration(
              color: color,
              borderRadius: BorderRadius.circular(16),
            ),
            alignment: Alignment.center,
            child: isC
                ? const Text(
                    'C',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 36,
                      fontWeight: FontWeight.w900,
                    ),
                  )
                : Container(
                    width: 24,
                    height: 24,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(color: Colors.white, width: 6),
                    ),
                  ),
          ),
          const SizedBox(height: 16),
          Text(
            name,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 14,
              color: nameColor,
            ),
            textAlign: TextAlign.center,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
          const SizedBox(height: 4),
          Text(
            location,
            style: TextStyle(color: locColor, fontSize: 12),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
          const SizedBox(height: 16),
          Text(
            vacancy,
            style: TextStyle(
              fontWeight: FontWeight.w900,
              color: vacColor,
              fontSize: 13,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLatestVacanciesGrid() {
  return GridView.builder(
    shrinkWrap: true,
    physics: const NeverScrollableScrollPhysics(),
    itemCount: vacancies.length,
    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
      crossAxisCount: 2,
      crossAxisSpacing: 16,
      mainAxisSpacing: 16,
      childAspectRatio: 3.5,
    ),
    itemBuilder: (context, index) {
      final vacancy = vacancies[index];

      return _buildJobCard(
  vacancy,
  vacancy['title'],
  const Color(0xFFB062E0),
  vacancy['job_type'],
  vacancy['salary'],
  true,
);
    },
  );
}
  Widget _buildJobCard(
  Map vacancy,
  String title,
  Color logoColor,
  String type,
  String salary,
  bool isBookmarked,
){
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final cardBg = isDark ? const Color(0xFF1E1E1E) : Colors.white;
    final borderColor = isDark ? Colors.transparent : Colors.grey.shade100;
    final shadowColor = isDark ? Colors.black.withOpacity(0.3) : Colors.grey.withOpacity(0.04);
    
    final titleColor = isDark ? Colors.white : Colors.black87;
    final locTimeColor = isDark ? Colors.grey.shade500 : Colors.grey.shade500;
    final activeBookmark = isDark ? Colors.blueAccent : const Color(0xFF1B223C);
    final inactiveBookmark = isDark ? Colors.grey.shade600 : Colors.grey.shade400;
    
    final badgeBg = isDark ? const Color(0xFF2C2C2E) : const Color(0xFFEEF2FF);
    final badgeText = isDark ? Colors.blueAccent : const Color(0xFF1D4ED8);
    final salaryColor = isDark ? Colors.white : Colors.black87;

    return InkWell(
  onTap: () {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => LatestPage(
          vacancy: vacancy,
        ),
      ),
    );
  },
      borderRadius: BorderRadius.circular(16),
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: cardBg,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: borderColor),
          boxShadow: [
            BoxShadow(
              color: shadowColor,
              blurRadius: 10,
              spreadRadius: 2,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  height: 40,
                  width: 40,
                  decoration: BoxDecoration(
                    color: logoColor,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: const Icon(
                    Icons.headphones,
                    color: Colors.white,
                    size: 22,
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        title,
                        style: TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.w800,
                          color: titleColor,
                        ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(height: 4),
                      Text(
                        'Medan, ID',
                        style: TextStyle(
                          fontSize: 10,
                          color: locTimeColor,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 4),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Icon(
                      isBookmarked ? Icons.bookmark : Icons.bookmark_border,
                      size: 20,
                      color: isBookmarked ? activeBookmark : inactiveBookmark,
                    ),
                    const SizedBox(height: 8),
                    Text(
                      '2h',
                      style: TextStyle(
                        fontSize: 10,
                        color: locTimeColor,
                      ),
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 16),
            Wrap(
              alignment: WrapAlignment.spaceBetween,
              crossAxisAlignment: WrapCrossAlignment.center,
              runSpacing: 8,
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 8,
                    vertical: 4,
                  ),
                  decoration: BoxDecoration(
                    color: badgeBg,
                    borderRadius: BorderRadius.circular(6),
                  ),
                  child: Text(
                    type,
                    style: TextStyle(
                      fontSize: 9,
                      fontWeight: FontWeight.w800,
                      color: badgeText,
                    ),
                  ),
                ),
                Text(
                  salary,
                  style: TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w900,
                    color: salaryColor,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}