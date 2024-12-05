import 'package:flutter/material.dart';
import 'package:donate_application/themes/colors.dart';
import 'package:donate_application/imports/user_barrel.dart';


class LoginPage extends StatefulWidget {
  const LoginPage({super.key});
      static const String pageRoute = '/login';


  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool rememberMe = false; // Checkbox state
  bool obscurePassword = true; // Password visibility state

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: appBackgroundColor, // Set the background color of the Scaffold
        body: Stack(
          children: [
            // Gradient background
            Container(
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    formGradientStart, // Gradient start color
                    formGradientEnd,   // Gradient end color
                  ],
                  stops: [
                    0.29, // 29% stop
                    0.98, // 98% stop
                  ],
                ),
              ),
            ),
            // Wave clipper section
            ClipPath(
              clipper: WaveClipper(),
              child: Container(
                height: 300, // Adjust the height to fit your design
                color: backgroundColor, // Background color of the wave
              ),
            ),
            // Main login form with padding
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0), // 20px padding on both left and right
              child: Center(
                child: Padding(
                  padding: const EdgeInsets.all(16.0), // Padding inside the form
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      // Login Title
                      const Text(
                        'Login',
                        style: TextStyle(
                          fontSize: 32,
                          fontWeight: FontWeight.bold,
                          color: textColor, // Text color from the color file
                        ),
                      ),
                      const SizedBox(height: 40),
                      // Email input field
                      const TextField(
                        decoration: InputDecoration(
                          prefixIcon: Icon(Icons.email, color: primaryColor), // Primary color
                          labelText: 'Email',
                          labelStyle: TextStyle(color: labelColor), // Label color
                          border: UnderlineInputBorder(),
                        ),
                      ),
                      const SizedBox(height: 20),
                      // Password input field
                      TextField(
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
                      // Remember me and forgot password row
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
                      // Login button
                      ElevatedButton(
                        onPressed: () {},
                        style: ElevatedButton.styleFrom(
                          backgroundColor: buttonColor, // Button color
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30),
                          ),
                          padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 80),
                        ),
                        child: const Text(
                          'LOGIN',
                          style: TextStyle(color: buttonTextColor, fontSize: 16), // Button text color
                        ),
                      ),
                      const SizedBox(height: 30),
                      // Signup link
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text(
                            "Don't have an account ?",
                            style: TextStyle(color: textColor),
                          ),
                          TextButton(
  onPressed: () {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const SignUpAsUserPage()), 
    );
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
      ),
    );
  }
}

class WaveClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    var path = Path();
    path.lineTo(0, size.height * 0.6); // Starting point with added height

    // First wave curve: gentler wave
    var firstControlPoint = Offset(size.width * 0.2, size.height * 0.2); // Closer to the curve for gentler wave
    var firstEndPoint = Offset(size.width * 0.5, size.height * 0.3); 
    path.quadraticBezierTo(
        firstControlPoint.dx, firstControlPoint.dy, firstEndPoint.dx, firstEndPoint.dy);

    // Second wave curve: gentler outward wave
    var secondControlPoint = Offset(size.width * 0.8, size.height * 0.4); // Closer for gentler curve
    var secondEndPoint = Offset(size.width, 0); // End at the top-right corner
    path.quadraticBezierTo(
        secondControlPoint.dx, secondControlPoint.dy, secondEndPoint.dx, secondEndPoint.dy);

    path.lineTo(size.width, 0); // Go up to the top-right corner
    path.lineTo(0, 0); // Return to the top-left corner
    path.close();

    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) => false;
}
