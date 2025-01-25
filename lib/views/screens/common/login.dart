import 'package:donate_application/views/screens/organization/org_homepage.dart';
import 'package:donate_application/views/screens/organization/signup_as_organization.dart';
import 'package:donate_application/views/screens/user/user_homepage.dart';
import 'package:flutter/material.dart';
import 'package:donate_application/databases/tables/organization.dart';
import 'package:donate_application/databases/tables/participant.dart';
import '../../../themes/colors.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});
  static const String pageRoute = '/login';

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool rememberMe = false; // Checkbox state
  bool obscurePassword = true; // Password visibility state
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final DBOrganizationTable organizationTable = DBOrganizationTable();
  final DBParticipantTable participantTable = DBParticipantTable();

  Future<void> _handleLogin() async {
    String email = emailController.text.trim();
    String password = passwordController.text.trim();

    if (email.isEmpty || password.isEmpty) {
      _showMessage("Please enter both email and password.");
      return;
    }

    try {
      // Check organization
      var org = await organizationTable.getRecord("email", email);
      if (org != null && org['password'] == password) {
        
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => OrgHomePage()),
        );
        return;
      }

      // Check participant
      var participant = await participantTable.getRecord("email", email);
      if (participant != null && participant['password'] == password) {
       
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => UserHomePage()),
        );
        return;
      }

      // If no match found
      _showMessage("Invalid email or password.");
    } catch (e) {
      _showMessage("An error occurred: $e");
    }
  }

  void _showMessage(String message, {bool isSuccess = false}) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: isSuccess ? Colors.green : Colors.red,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: appBackgroundColor,
      body: Stack(
        children: [
          // Gradient background
          Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  formGradientStart,
                  formGradientEnd,
                ],
                stops: [0.29, 0.98],
              ),
            ),
          ),
          // Wave clipper section
          ClipPath(
            clipper: WaveClipper(),
            child: Container(
              height: 300,
              color: backgroundColor,
            ),
          ),
          // Main login form
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Center(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      'Login',
                      style: TextStyle(
                        fontSize: 32,
                        fontWeight: FontWeight.bold,
                        color: textColor,
                      ),
                    ),
                    const SizedBox(height: 40),
                    TextField(
                      controller: emailController,
                      decoration: const InputDecoration(
                        prefixIcon: Icon(Icons.email, color: primaryColor),
                        labelText: 'Email',
                        labelStyle: TextStyle(color: labelColor),
                        border: UnderlineInputBorder(),
                      ),
                    ),
                    const SizedBox(height: 20),
                    TextField(
                      controller: passwordController,
                      obscureText: obscurePassword,
                      decoration: InputDecoration(
                        prefixIcon: const Icon(Icons.lock, color: primaryColor),
                        labelText: 'Password',
                        labelStyle: const TextStyle(color: labelColor),
                        border: const UnderlineInputBorder(),
                        suffixIcon: IconButton(
                          icon: Icon(
                            obscurePassword ? Icons.visibility_off : Icons.visibility,
                            color: primaryColor,
                          ),
                          onPressed: () {
                            setState(() {
                              obscurePassword = !obscurePassword;
                            });
                          },
                        ),
                      ),
                    ),
                    const SizedBox(height: 10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Checkbox(
                              value: rememberMe,
                              onChanged: (value) {
                                setState(() {
                                  rememberMe = value!;
                                });
                              },
                              activeColor: primaryColor,
                            ),
                            const Text(
                              'Remember me',
                              style: TextStyle(color: labelColor),
                            ),
                          ],
                        ),
                        TextButton(
                          onPressed: () {},
                          child: const Text(
                            'Forgot password?',
                            style: TextStyle(color: labelColor),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),
                    ElevatedButton(
                      onPressed: _handleLogin,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: buttonColor,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                        padding: const EdgeInsets.symmetric(
                            vertical: 15, horizontal: 80),
                      ),
                      child: const Text(
                        'LOGIN',
                        style: TextStyle(
                          color: buttonTextColor,
                          fontSize: 16,
                        ),
                      ),
                    ),
                    const SizedBox(height: 30),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                          "Don't have an account?",
                          style: TextStyle(color: textColor),
                        ),
                        TextButton(
                          onPressed: () {
                            Navigator.pushReplacementNamed(
                                context, '/signup_as_user');
                          },
                          child: const Text(
                            'Sign Up',
                            style: TextStyle(
                              color: primaryColor,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
