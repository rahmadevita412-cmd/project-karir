import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:file_picker/file_picker.dart';

class LatestPage extends StatefulWidget {
  final Map vacancy;

  const LatestPage({
    super.key,
    required this.vacancy,
  });

  @override
  State<LatestPage> createState() => _LatestPageState();
}

class _LatestPageState extends State<LatestPage> {
  
  final phoneController = TextEditingController();
final nameController = TextEditingController();
final emailController = TextEditingController();
PlatformFile? selectedResume;
Future<void> pickResume() async {
  FilePickerResult? result = await FilePicker.platform.pickFiles(
    type: FileType.custom,
    allowedExtensions: ['pdf'],
    withData: true,
  );

  if (result != null) {
    setState(() {
      selectedResume = result.files.first;
    });

    print("FILE = ${selectedResume!.name}");
  }
}
Future<void> applyJob() async {
  final prefs = await SharedPreferences.getInstance();

  String? token = prefs.getString('token');

  if (selectedResume == null) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Silakan upload resume terlebih dahulu'),
      ),
    );
    return;
  }

  var request = http.MultipartRequest(
    'POST',
    Uri.parse('http://127.0.0.1:8000/api/apply'),
  );

  request.headers['Authorization'] = 'Bearer $token';
  request.headers['Accept'] = 'application/json';

  request.fields['vacancy_id'] =
      widget.vacancy['id'].toString();

  request.fields['phone'] =
      phoneController.text;

  request.files.add(
  http.MultipartFile.fromBytes(
    'resume',
    selectedResume!.bytes!,
    filename: selectedResume!.name,
  ),
);

  var response = await request.send();

  if (response.statusCode == 200 ||
      response.statusCode == 201) {

    Navigator.pop(context);

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Lamaran berhasil dikirim'),
      ),
    );
  } else {

    final responseBody =
        await response.stream.bytesToString();

    print(responseBody);

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Lamaran gagal'),
      ),
    );
  }
}
  
  void _showApplyBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) {
        
        final isDark = Theme.of(context).brightness == Brightness.dark;
        final bgColor = isDark ? const Color(0xFF1E1E1E) : Colors.white;
        final textColor = isDark ? Colors.white : const Color(0xFF14224A);
        final labelColor = isDark ? Colors.white : Colors.black87;
        final boxColor = isDark ? const Color(0xFF2C2C2C) : const Color(0xFFF8FAFC);
        final borderColor = isDark ? Colors.grey.shade800 : Colors.grey.shade200;
        final primaryColor = isDark ? Colors.blueAccent : const Color(0xFF14224A);

        return Container(
          padding: EdgeInsets.only(
            bottom: MediaQuery.of(context).viewInsets.bottom,
          ),
          decoration: BoxDecoration(
            color: bgColor,
            borderRadius: const BorderRadius.vertical(top: Radius.circular(30)),
          ),
          child: Container(
            height: MediaQuery.of(context).size.height * 0.8,
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: Container(
                    width: 50,
                    height: 5,
                    decoration: BoxDecoration(
                      color: isDark ? Colors.grey.shade700 : Colors.grey.shade300,
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                Text(
                  'Apply Job',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w900,
                    color: textColor, 
                  ),
                ),
                const SizedBox(height: 24),
                Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Upload Resume',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 14,
                            color: labelColor,
                          ),
                        ),
                        const SizedBox(height: 12),
                        GestureDetector(
  onTap: pickResume,
  child: Container(
    width: double.infinity,
    height: 120,
    decoration: BoxDecoration(
      border: Border.all(color: borderColor),
      borderRadius: BorderRadius.circular(12),
      color: boxColor,
    ),
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(
          Icons.add_circle_outline,
          color: primaryColor,
          size: 30,
        ),
        const SizedBox(height: 8),
        Text(
  selectedResume == null
      ? 'Upload Resume'
      : 'FILE: ${selectedResume!.name}',
          style: const TextStyle(
            color: Colors.grey,
            fontSize: 12,
          ),
        ),
      ],
    ),
  ),
),
                        const SizedBox(height: 24),
                        _buildInputField(
  context,
  'Name',
  'Enter your name',
  controller: nameController,
),
                        const SizedBox(height: 16),
                       _buildInputField(
  context,
  'Email',
  'Enter your email',
  controller: emailController,
),
                        const SizedBox(height: 16),
                       _buildInputField(
  context,
  'Number Phone',
  'Enter your phone number',
  controller: phoneController,
),
                        const SizedBox(height: 32),
                        ElevatedButton(
                          onPressed: () {
  applyJob();
},
                          style: ElevatedButton.styleFrom(
                            backgroundColor: primaryColor, 
                            minimumSize: const Size(double.infinity, 56),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                            elevation: 0,
                          ),
                          child: const Text(
                            'APPLY NOW',
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 15,
                            ),
                          ),
                        ),
                        const SizedBox(height: 20),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

Widget _buildInputField(
  BuildContext context,
  String label,
  String hint, {
  TextEditingController? controller,
}) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final labelColor = isDark ? Colors.white : Colors.black87;
    final fillColor = isDark ? const Color(0xFF2C2C2C) : const Color(0xFFF8FAFC);
    final borderColor = isDark ? Colors.transparent : Colors.grey.shade200;
    final focusedBorderColor = isDark ? Colors.blueAccent : const Color(0xFF14224A);
    final textColor = isDark ? Colors.white : Colors.black87;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 14,
            color: labelColor,
          ),
        ),
        const SizedBox(height: 8),
        TextField(
          controller: controller,
          style: TextStyle(color: textColor), 
          decoration: InputDecoration(
            hintText: hint,
            hintStyle: const TextStyle(color: Colors.grey, fontSize: 13),
            filled: true,
            fillColor: fillColor, 
            contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(color: borderColor),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(color: borderColor),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(
                color: focusedBorderColor,
                width: 1.5,
              ),
            ),
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
   
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final bgColor = isDark ? Theme.of(context).scaffoldBackgroundColor : Colors.white;
    final navBgColor = isDark ? const Color(0xFF1E1E1E) : Colors.white;
    final btnColor = isDark ? Colors.blueAccent : const Color(0xFF14224A);

    return Scaffold(
      backgroundColor: bgColor, 
      bottomNavigationBar: Container(
        padding: const EdgeInsets.all(24.0),
        decoration: BoxDecoration(
          color: navBgColor, // 
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(isDark ? 0.3 : 0.05),
              blurRadius: 10,
              offset: const Offset(0, -4),
            ),
          ],
        ),
        child: ElevatedButton(
          onPressed: () => _showApplyBottomSheet(context),
          style: ElevatedButton.styleFrom(
            backgroundColor: btnColor, 
            minimumSize: const Size(double.infinity, 56),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
          ),
          child: const Text(
            'APPLY FOR THIS JOB',
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 14,
              letterSpacing: 1.0,
            ),
          ),
        ),
      ),
      body: Column(
        children: [
          _buildTopHeader(context),
          const SizedBox(height: 40),
          Expanded(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Center(
                      child: Text(
  widget.vacancy['company']['name'],
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w900,
                          color: isDark ? Colors.white : Colors.black87, 
                        ),
                      ),
                    ),
                    const SizedBox(height: 32),
                    _buildJobHeader(context),
                    const SizedBox(height: 24),
                    _buildJobStats(context),
                    const SizedBox(height: 32),
                    _buildTabs(context),
                    const SizedBox(height: 24),
                    _buildDescription(context),
                    const SizedBox(height: 24),
                    _buildRequirements(context),
                    const SizedBox(height: 40),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTopHeader(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    
    return Stack(
      clipBehavior: Clip.none,
      children: [
        Container(
          height: 130,
          width: double.infinity,
          color: isDark ? const Color(0xFF121212) : const Color(0xFF14224A), // 👈 Header atas lebih gelap pas dark mode
          padding: const EdgeInsets.only(top: 50, left: 24, right: 24),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              InkWell(
                onTap: () => Navigator.pop(context),
                child: Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.white54),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: const Icon(
                    Icons.arrow_back_ios_new,
                    color: Colors.white,
                    size: 16,
                  ),
                ),
              ),
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.white54),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: const Icon(Icons.tune, color: Colors.white, size: 18),
              ),
            ],
          ),
        ),
        Positioned(
          bottom: -35,
          left: 0,
          right: 0,
          child: Center(
            child: Container(
              height: 70,
              width: 70,
              decoration: BoxDecoration(
                color: const Color(0xFF0F52BA),
                borderRadius: BorderRadius.circular(16),
                border: Border.all(
                  color: isDark ? Theme.of(context).scaffoldBackgroundColor : Colors.white, // 👈 Border logo menyesuaikan background
                  width: 4
                ),
              ),
              child: const Icon(
                Icons.headphones,
                color: Colors.white,
                size: 36,
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildJobHeader(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final titleColor = isDark ? Colors.white : Colors.black87;
    final subColor = isDark ? Colors.grey[400] : Colors.grey.shade600;
    final iconColor = isDark ? Colors.blueAccent : const Color(0xFF14224A);

    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
  widget.vacancy['title'],
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w900,
                color: titleColor,
              ),
            ),
            Icon(Icons.bookmark, color: iconColor, size: 24),
          ],
        ),
        const SizedBox(height: 8),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
  widget.vacancy['company']['location'],
              style: TextStyle(fontSize: 13, color: subColor),
            ),
            Text(
              'Posted 4h ago',
              style: TextStyle(fontSize: 13, color: subColor),
            ),
          ],
        ),
      ],
    );
  }

 Widget _buildJobStats(BuildContext context) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      _buildStatItem(
        context,
        'Salary',
        widget.vacancy['salary'],
      ),
      _buildStatItem(
        context,
        'Experience',
        widget.vacancy['experience'],
      ),
      _buildStatItem(
        context,
        'Employment',
        widget.vacancy['job_type'],
      ),
    ],
  );
}

  Widget _buildStatItem(BuildContext context, String label, String value) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final valColor = isDark ? Colors.white : const Color(0xFF14224A);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('Salary', style: TextStyle(fontSize: 11, color: Colors.grey)),
        const SizedBox(height: 4),
        Text(
          value,
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.bold,
            color: valColor,
          ),
        ),
      ],
    );
  }

  Widget _buildTabs(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final bgContainer = isDark ? const Color(0xFF2C2C2C) : const Color(0xFFF1F5F9);
    final activeTabBg = isDark ? const Color(0xFF1E1E1E) : Colors.white;
    final activeTabText = isDark ? Colors.blueAccent : const Color(0xFF14224A);

    return Container(
      padding: const EdgeInsets.all(4),
      decoration: BoxDecoration(
        color: bgContainer,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          Expanded(
            child: Container(
              padding: const EdgeInsets.symmetric(vertical: 12),
              decoration: BoxDecoration(
                color: activeTabBg,
                borderRadius: BorderRadius.circular(10),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(isDark ? 0.2 : 0.1),
                    blurRadius: 4,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: Center(
                child: Text(
                  'Job Desc.',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: activeTabText,
                  ),
                ),
              ),
            ),
          ),
          const Expanded(
            child: Center(
              child: Text(
                'Gallery',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.grey,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDescription(BuildContext context) {
  final isDark = Theme.of(context).brightness == Brightness.dark;

  return Text(
    widget.vacancy['description'],
    style: TextStyle(
      fontSize: 13,
      color: isDark ? Colors.grey[300] : Colors.grey.shade600,
      height: 1.5,
    ),
  );
}
  Widget _buildRequirements(BuildContext context) {
  final isDark = Theme.of(context).brightness == Brightness.dark;

  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(
        'Requirements',
        style: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w900,
          color: isDark ? Colors.white : Colors.black87,
        ),
      ),
      const SizedBox(height: 12),

      Text(
        widget.vacancy['requirements'],
        style: TextStyle(
          fontSize: 13,
          color: isDark ? Colors.grey[300] : Colors.grey.shade600,
          height: 1.5,
        ),
      ),
    ],
  );
}
  Widget _buildRequirementItem(BuildContext context, String text) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final iconColor = isDark ? Colors.blueAccent : const Color(0xFF14224A);
    final textColor = isDark ? Colors.grey[300] : Colors.grey.shade600;

    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: Row(
        children: [
          Icon(Icons.check_circle, color: iconColor, size: 18),
          const SizedBox(width: 12),
          Text(
            text,
            style: TextStyle(fontSize: 13, color: textColor),
          ),
        ],
      ),
    );
  }
}