import 'package:flutter/material.dart';

class CustomTopBar extends StatelessWidget {
  final String title;
  final VoidCallback onBackTap;
  final VoidCallback onMenuTap;

  const CustomTopBar({
    super.key,
    required this.title,
    required this.onBackTap,
    required this.onMenuTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          GestureDetector(
            onTap: onBackTap,
            child: Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: const Color(0xFFE6E6E6)),
              ),
              child: const Icon(
                Icons.arrow_back_ios_new,
                size: 18,
                color: Color(0xFF18286D),
              ),
            ),
          ),

          Text(
            title,
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w700,
              color: Colors.black,
            ),
          ),

          GestureDetector(
            onTap: onMenuTap,
            child: Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: const Color(0xFFE6E6E6)),
              ),
              child: const Icon(
                Icons.tune,
                size: 20,
                color: Color(0xFF18286D),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
