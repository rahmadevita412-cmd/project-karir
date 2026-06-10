import 'package:flutter/material.dart';

class CategoriesPage extends StatefulWidget {
  const CategoriesPage({super.key});

  @override
  State<CategoriesPage> createState() => _CategoriesPageState();
}

class _CategoriesPageState extends State<CategoriesPage> {
  @override
  Widget build(BuildContext context) {

    final isDark = Theme.of(context).brightness == Brightness.dark;
    final bgColor = isDark ? Theme.of(context).scaffoldBackgroundColor : const Color(0xFFF9FAFC);

    return Scaffold(
      backgroundColor: bgColor,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildHeader(context),
                const SizedBox(height: 24),
                _buildSearchBar(context),
                const SizedBox(height: 20),
                _buildFilterChips(context),
                const SizedBox(height: 32),
                _buildResultsHeader(context),
                const SizedBox(height: 16),
                _buildJobsGrid(context),
                const SizedBox(height: 30),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final btnBg = isDark ? const Color(0xFF1E1E1E) : Colors.white;
    final iconColor = isDark ? Colors.white : const Color(0xFF1B223C);
    final borderColor = isDark ? Colors.transparent : Colors.grey.shade200;
    final textColor = isDark ? Colors.white : Colors.black87;

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        InkWell(
          onTap: () => Navigator.pop(context), 
          borderRadius: BorderRadius.circular(12),
          child: Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: btnBg,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: borderColor),
            ),
            child: Icon(Icons.arrow_back_ios_new, size: 18, color: iconColor),
          ),
        ),
        Text(
          'Search',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.w800, color: textColor),
        ),
        Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: btnBg,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: borderColor),
          ),
          child: Icon(Icons.tune, size: 20, color: iconColor),
        ),
      ],
    );
  }

  Widget _buildSearchBar(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final boxBg = isDark ? const Color(0xFF1E1E1E) : Colors.white;
    final borderColor = isDark ? Colors.transparent : Colors.grey.shade200;
    final hintColor = isDark ? Colors.grey.shade500 : Colors.grey.shade400;
    final textColor = isDark ? Colors.white : Colors.black87;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
        color: boxBg,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: borderColor),
      ),
      child: TextField(
        style: TextStyle(color: textColor), 
        decoration: InputDecoration(
          hintText: 'Search job here...',
          hintStyle: TextStyle(color: hintColor, fontSize: 14),
          border: InputBorder.none,
          suffixIcon: Icon(Icons.search, color: hintColor),
        ),
      ),
    );
  }

  Widget _buildFilterChips(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: [
          _buildChip(context, 'All', false),
          const SizedBox(width: 12),
          _buildChip(context, 'Fulltime', false),
          const SizedBox(width: 12),
          _buildChip(context, 'Freelance', true), 
          const SizedBox(width: 12),
          _buildChip(context, 'Intern', false),
        ],
      ),
    );
  }

  Widget _buildChip(BuildContext context, String label, bool isActive) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    
    
    final activeBg = isDark ? Colors.blueAccent : const Color(0xFF1B223C);
    final inactiveBg = isDark ? const Color(0xFF1E1E1E) : const Color(0xFFF0F4FF);
    
  
    final activeText = Colors.white;
    final inactiveText = isDark ? Colors.white70 : const Color(0xFF1D4ED8);
    
    
    final activeBorder = isDark ? Colors.blueAccent : const Color(0xFF1B223C);
    final inactiveBorder = isDark ? Colors.transparent : const Color(0xFFD6E4FF);

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
      decoration: BoxDecoration(
        color: isActive ? activeBg : inactiveBg,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: isActive ? activeBorder : inactiveBorder),
      ),
      child: Text(
        label,
        style: TextStyle(
          color: isActive ? activeText : inactiveText,
          fontWeight: FontWeight.bold,
          fontSize: 13,
        ),
      ),
    );
  }

  Widget _buildResultsHeader(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final titleColor = isDark ? Colors.white : Colors.black87;
    final subColor = isDark ? Colors.grey.shade400 : Colors.grey.shade500;
    final newestColor = isDark ? Colors.blueAccent : const Color(0xFF1B223C);

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '679 Results',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w900, color: titleColor),
            ),
            const SizedBox(height: 4),
            Text(
              'Based your filter',
              style: TextStyle(fontSize: 13, color: subColor),
            ),
          ],
        ),
        Row(
          children: [
            Text(
              'Newest',
              style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: newestColor),
            ),
            Icon(Icons.keyboard_arrow_down, color: newestColor),
          ],
        )
      ],
    );
  }

  Widget _buildJobsGrid(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Expanded(child: _buildJobCard(context, 'Software Engineer', const Color(0xFFB062E0), 'FULLTIME', '\$5K - \$10K', true)),
            const SizedBox(width: 16),
            Expanded(child: _buildJobCard(context, 'Senior Frontend Programmer', const Color(0xFFF07338), 'INTERN', '\$250 - \$500', false)),
          ],
        ),
        const SizedBox(height: 16),
        Row(
          children: [
            Expanded(child: _buildJobCard(context, 'Principal UI Designer', const Color(0xFF0F52BA), 'PART TIME', '\$250 - \$500', false)),
            const SizedBox(width: 16),
            Expanded(child: _buildJobCard(context, 'Senior Designer', const Color(0xFF50C878), 'INTERN', '\$250 - \$500', false)),
          ],
        ),
      ],
    );
  }

  Widget _buildJobCard(BuildContext context, String title, Color logoColor, String type, String salary, bool isBookmarked) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    
    final cardBg = isDark ? const Color(0xFF1E1E1E) : Colors.white;
    final borderColor = isDark ? Colors.transparent : Colors.grey.shade100;
    final shadowColor = isDark ? Colors.black.withOpacity(0.3) : Colors.grey.withOpacity(0.04);
    
    final titleColor = isDark ? Colors.white : Colors.black87;
    final subColor = isDark ? Colors.grey.shade400 : Colors.grey.shade500;
    
    final activeBookmark = isDark ? Colors.blueAccent : const Color(0xFF1B223C);
    final inactiveBookmark = isDark ? Colors.grey.shade600 : Colors.grey.shade400;
    
    final badgeBg = isDark ? const Color(0xFF2C2C2C) : const Color(0xFFEEF2FF);
    final badgeText = isDark ? Colors.blueAccent : const Color(0xFF1D4ED8);
    final salaryColor = isDark ? Colors.white : Colors.black87;

    return Container(
      padding: const EdgeInsets.all(16),
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
                height: 48,
                width: 48,
                decoration: BoxDecoration(color: logoColor, borderRadius: BorderRadius.circular(12)),
                child: const Icon(Icons.headphones, color: Colors.white, size: 28),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: TextStyle(fontSize: 14, fontWeight: FontWeight.w800, color: titleColor),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 6),
                    Text('Medan, Indonesia', style: TextStyle(fontSize: 11, color: subColor)),
                  ],
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Icon(
                    isBookmarked ? Icons.bookmark : Icons.bookmark_border,
                    size: 22,
                    color: isBookmarked ? activeBookmark : inactiveBookmark,
                  ),
                  const SizedBox(height: 12),
                  Text('2h ago', style: TextStyle(fontSize: 11, color: subColor)),
                ],
              ),
            ],
          ),
          const SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                decoration: BoxDecoration(color: badgeBg, borderRadius: BorderRadius.circular(6)),
                child: Text(
                  type,
                  style: TextStyle(fontSize: 10, fontWeight: FontWeight.w800, color: badgeText),
                ),
              ),
              Text(
                salary,
                style: TextStyle(fontSize: 14, fontWeight: FontWeight.w900, color: salaryColor),
              ),
            ],
          )
        ],
      ),
    );
  }
}