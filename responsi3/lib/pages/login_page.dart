import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}



class _LoginPageState extends State<LoginPage> {
  
  bool isRegister = false;
  bool isForgotPassword = false;
  bool isPasswordHidden = true;
  
  final firstNameController = TextEditingController();
final lastNameController = TextEditingController();
final registerEmailController = TextEditingController();
final registerPasswordController = TextEditingController();
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  Future<void> login() async {
  final response = await http.post(
    Uri.parse('http://127.0.0.1:8000/api/login'),
    headers: {
      'Accept': 'application/json',
    },
    body: {
      'email': emailController.text,
      'password': passwordController.text,
    },
  );

  if (response.statusCode == 200) {
  final data = jsonDecode(response.body);

  final prefs = await SharedPreferences.getInstance();

  await prefs.setString(
    'token',
    data['token'],
  );

  await prefs.setString(
    'name',
    data['user']['name'],
  );

  Navigator.pushNamed(context, '/home');
}else {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Login gagal'),
      ),
    );
  }
}
Future<void> register() async {
  final response = await http.post(
    Uri.parse('http://127.0.0.1:8000/api/register'),
    headers: {
      'Accept': 'application/json',
    },
    body: {
      'name':'${firstNameController.text} ${lastNameController.text}',
      'email': registerEmailController.text,
      'password': registerPasswordController.text,
    },
  );

  if (response.statusCode == 200 ||
      response.statusCode == 201) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Register berhasil'),
      ),
    );

    setState(() {
      isRegister = false;
    });
  } else {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Register gagal'),
      ),
    );
  }
}


  Widget buildTextField({
    required BuildContext context,
    required String hint,
    bool isPassword = false,
    TextEditingController? controller,
  }) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final fieldColor = isDark ? const Color(0xFF1E1E1E) : const Color(0xFFF5F5F5);
    final borderColor = isDark ? Colors.transparent : const Color(0xFFD9D9D9);
    final hintColor = isDark ? Colors.grey[500]! : const Color(0xFFB4B4B4);
    final textColor = isDark ? Colors.white : Colors.black;
    final navyColor = isDark ? Colors.blueAccent : const Color(0xFF18286D);

    return Container(
      height: 58,
      decoration: BoxDecoration(
        color: fieldColor,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(
          color: borderColor,
          width: 1,
        ),
      ),
      child: TextField(
        obscureText: isPassword ? isPasswordHidden : false,
        style: GoogleFonts.poppins(
          fontSize: 15,
          color: textColor, 
          fontWeight: FontWeight.w500,
        ),
        decoration: InputDecoration(
          border: InputBorder.none,
          contentPadding: const EdgeInsets.only(
            left: 20,
            right: 80,
            top: 18,
            bottom: 18,
          ),
          hintText: hint,
          hintStyle: GoogleFonts.poppins(
            fontSize: 15,
            color: hintColor, 
            fontWeight: FontWeight.w400,
          ),
        ),
        controller: controller,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    
    final isDark = Theme.of(context).brightness == Brightness.dark;
    
    final Color pageBackgroundColor = Theme.of(context).scaffoldBackgroundColor;
    final Color navyColor = isDark ? Colors.blueAccent : const Color(0xFF18286D);
    final Color lightGrey = isDark ? const Color(0xFF1E1E1E) : const Color(0xFFE9E9E9);
    final Color hintColor = isDark ? Colors.grey[400]! : const Color(0xFFB4B4B4);
    final Color textColor = isDark ? Colors.white : Colors.black;
    final Color tabActiveBg = isDark ? const Color(0xFF333333) : Colors.white;
    final Color googleBtnBg = isDark ? const Color(0xFF1E1E1E) : Colors.white;
    final Color borderColor = isDark ? Colors.transparent : const Color(0xFFD9D9D9);

    return Scaffold(
      backgroundColor: pageBackgroundColor, 
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 18),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Job Seeker Portal',
                style: GoogleFonts.poppins(
                  fontSize: 20,
                  fontWeight: FontWeight.w700,
                  color: textColor, 
                ),
              ),

              const SizedBox(height: 8),

              Text(
                'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor',
                style: GoogleFonts.poppins(
                  fontSize: 13,
                  color: isDark ? Colors.white70 : Colors.black, 
                  fontWeight: FontWeight.w400,
                  height: 1.5,
                ),
              ),

              const SizedBox(height: 22),

              Container(
                height: 56,
                padding: const EdgeInsets.all(5),
                decoration: BoxDecoration(
                  color: lightGrey, 
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: GestureDetector(
                        onTap: () {
                          setState(() {
                            isRegister = false;
                            isForgotPassword = false;
                          });
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            color: !isRegister ? tabActiveBg : Colors.transparent,
                            borderRadius: BorderRadius.circular(6),
                            boxShadow: !isRegister
                                ? [
                                    BoxShadow(
                                      color: Colors.black.withOpacity(isDark ? 0.3 : 0.03),
                                      blurRadius: 8,
                                      offset: const Offset(0, 2),
                                    ),
                                  ]
                                : [],
                          ),
                          child: Center(
                            child: Text(
                              'SIGN IN',
                              style: GoogleFonts.poppins(
                                fontSize: 14,
                                fontWeight: FontWeight.w700,
                                color: !isRegister ? navyColor : hintColor,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),

                    Expanded(
                      child: GestureDetector(
                        onTap: () {
                          setState(() {
                            isRegister = true;
                            isForgotPassword = false;
                          });
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            color: isRegister ? tabActiveBg : Colors.transparent, 
                            borderRadius: BorderRadius.circular(6),
                            boxShadow: isRegister
                                ? [
                                    BoxShadow(
                                      color: Colors.black.withOpacity(isDark ? 0.3 : 0.03),
                                      blurRadius: 8,
                                      offset: const Offset(0, 2),
                                    ),
                                  ]
                                : [],
                          ),
                          child: Center(
                            child: Text(
                              'REGISTER',
                              style: GoogleFonts.poppins(
                                fontSize: 14,
                                fontWeight: FontWeight.w700,
                                color: isRegister ? navyColor : hintColor, 
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 26),

              if (!isRegister && !isForgotPassword) ...[
                buildTextField(
  context: context,
  hint: 'Email',
  controller: emailController,
),

                const SizedBox(height: 16),

                buildTextField(
  context: context,
  hint: 'Password',
  isPassword: true,
  controller: passwordController,
),

                const SizedBox(height: 28),

                SizedBox(
                  width: double.infinity,
                  height: 56,
                  child: ElevatedButton(
                    onPressed: () {
  login();
},
                    style: ElevatedButton.styleFrom(
                      backgroundColor: navyColor, 
                      elevation: 0,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    child: Text(
                      'LOGIN',
                      style: GoogleFonts.poppins(
                        fontSize: 15,
                        fontWeight: FontWeight.w700,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),

                const SizedBox(height: 18),

                Row(
                  children: [
                    Text(
                      'Forgot your password? ',
                      style: GoogleFonts.poppins(
                        color: hintColor,
                        fontSize: 14,
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          isForgotPassword = true;
                        });
                      },
                      child: Text(
                        'Reset here',
                        style: GoogleFonts.poppins(
                          color: navyColor,
                          fontSize: 14,
                          fontWeight: FontWeight.w700,
                          decoration: TextDecoration.underline,
                          decorationColor: navyColor,
                        ),
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 38),

                Center(
                  child: Text(
                    'Or sign in with',
                    style: GoogleFonts.poppins(
                      fontSize: 14,
                      color: hintColor,
                    ),
                  ),
                ),

                const SizedBox(height: 26),

                Container(
                  width: double.infinity,
                  height: 56,
                  decoration: BoxDecoration(
                    color: const Color(0xFF3E6AE1),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Row(
                    children: [
                      const SizedBox(width: 22),
                      SvgPicture.asset(
                        'assets/icons/fb.svg',
                        width: 24,
                        height: 24,
                      ),
                      const Spacer(),
                      Text(
                        'Login With Facebook',
                        style: GoogleFonts.poppins(
                          color: Colors.white,
                          fontSize: 15,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const Spacer(),
                      const SizedBox(width: 46),
                    ],
                  ),
                ),

                const SizedBox(height: 14),

                Container(
                  width: double.infinity,
                  height: 56,
                  decoration: BoxDecoration(
                    color: googleBtnBg, 
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(
                      color: borderColor,
                    ),
                  ),
                  child: Row(
                    children: [
                      const SizedBox(width: 22),
                      Image.asset(
                        'assets/icons/google.png',
                        width: 24,
                        height: 24,
                        fit: BoxFit.contain,
                      ),
                      const Spacer(),
                      Text(
                        'Login With Google',
                        style: GoogleFonts.poppins(
                          color: textColor, 
                          fontSize: 15,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const Spacer(),
                      const SizedBox(width: 46),
                    ],
                  ),
                ),
              ],

              if (isForgotPassword) ...[
                buildTextField(
                  context: context,
                  hint: 'Password',
                  isPassword: true,
                ),

                const SizedBox(height: 26),

                SizedBox(
                  width: double.infinity,
                  height: 56,
                  child: ElevatedButton(
                    onPressed: () {
  login();
},
                    style: ElevatedButton.styleFrom(
                      backgroundColor: navyColor,
                      elevation: 0,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    child: Text(
                      'SUBMIT',
                      style: GoogleFonts.poppins(
                        fontSize: 15,
                        fontWeight: FontWeight.w700,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),

                const SizedBox(height: 18),

                Row(
                  children: [
                    Text(
                      'Sign in to your registered account ',
                      style: GoogleFonts.poppins(
                        color: hintColor,
                        fontSize: 14,
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          isForgotPassword = false;
                        });
                      },
                      child: Text(
                        'Login here',
                        style: GoogleFonts.poppins(
                          color: navyColor,
                          fontSize: 14,
                          fontWeight: FontWeight.w700,
                          decoration: TextDecoration.underline,
                          decorationColor: navyColor,
                        ),
                      ),
                    ),
                  ],
                ),
              ],

              if (isRegister) ...[
                buildTextField(
  context: context,
  hint: 'William',
  controller: firstNameController,
),
                const SizedBox(height: 16),

                buildTextField(
  context: context,
  hint: 'Smith',
  controller: lastNameController,
),

                const SizedBox(height: 16),

                buildTextField(
  context: context,
  hint: 'info@example.com',
  controller: registerEmailController,
),
                const SizedBox(height: 16),

                buildTextField(
                  context: context,
                  hint: 'Password',
                  isPassword: true,
                   controller: registerPasswordController,
                ),

                const SizedBox(height: 26),

                SizedBox(
                  width: double.infinity,
                  height: 56,
                  child: ElevatedButton(
                    onPressed: () {
                     register();
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: navyColor,
                      elevation: 0,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    child: Text(
                      'REGISTER',
                      style: GoogleFonts.poppins(
                        fontSize: 15,
                        fontWeight: FontWeight.w700,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),

                const SizedBox(height: 24),

                Center(
                  child: RichText(
                    textAlign: TextAlign.center,
                    text: TextSpan(
                      style: GoogleFonts.poppins(
                        fontSize: 13,
                        color: hintColor,
                      ),
                      children: [
                        const TextSpan(
                          text: 'By tapping "Sign Up" you accept our ',
                        ),
                        TextSpan(
                          text: 'terms',
                          style: GoogleFonts.poppins(
                            color: navyColor,
                            fontWeight: FontWeight.w700,
                            decoration: TextDecoration.underline,
                          ),
                        ),
                        const TextSpan(text: ' and '),
                        TextSpan(
                          text: 'condition',
                          style: GoogleFonts.poppins(
                            color: navyColor,
                            fontWeight: FontWeight.w700,
                            decoration: TextDecoration.underline,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

                const SizedBox(height: 24),

                Container(
                  width: double.infinity,
                  height: 56,
                  decoration: BoxDecoration(
                    color: Colors.transparent,
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(
                      color: isDark ? Colors.grey[700]! : const Color(0xFF8E95A5), 
                      width: 1.2,
                    ),
                  ),
                  child: InkWell(
                    onTap: () {
                      Navigator.pushNamed(context, '/home');
                    },
                    borderRadius: BorderRadius.circular(8),
                    child: Center(
                      child: Text(
                        'CONTINUE AS GUEST',
                        style: GoogleFonts.poppins(
                          fontSize: 15,
                          fontWeight: FontWeight.w700,
                          color: textColor, 
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}