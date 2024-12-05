import 'package:flutter/material.dart';
import '/themes/colors.dart';
import '/imports/user_barrel.dart';
import '/imports/common_barrel.dart';


void main() {
  runApp(const SignUpAsOrganizationPage());
}

class SignUpAsOrganizationPage extends StatefulWidget {
  const SignUpAsOrganizationPage({super.key});

  @override
  _SignUpAsOrganizationPageState createState() => _SignUpAsOrganizationPageState();
}

class _SignUpAsOrganizationPageState extends State<SignUpAsOrganizationPage> {
  bool isUser = false; // To track the switch state

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
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
                ),
              ),
            ),
            // Background wave
            ClipPath(
              clipper: WaveClipper(),
              child: Container(
                height: 300,
                color: backgroundColor,
              ),
            ),
            // Content
            SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 40.0, vertical: 80.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 60),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        "As an organization",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                          color: Color.fromARGB(255, 255, 255, 255),
                        ),
                      ),
                      Switch(
                        value: isUser,
                        onChanged: (value) {
                          if (value) { 
                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const SignUpAsUserPage(),
                              ),
                            );
                          }
                          setState(() {
                            isUser = value;
                          });
                        },
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  const Text(
                    "Create an account",
                    style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 30),
                  // Input fields
                  const CustomTextField(
                    icon: Icons.business,
                    label: "Organization Name",
                  ),
                  const SizedBox(height: 20),
                  const CustomTextField(
                    icon: Icons.phone,
                    label: "Phone",
                  ),
                  const SizedBox(height: 20),
                  const CustomTextField(
                    icon: Icons.location_on,
                    label: "Address",
                  ),
                  const SizedBox(height: 20),
                  const CustomTextField(
                    icon: Icons.payment,
                    label: "Do you support money transaction?",
                  ),
                  const SizedBox(height: 20),
                  const CustomTextField(
                    icon: Icons.account_balance,
                    label: "Bank Account",
                  ),
                  const SizedBox(height: 20),
                  const CustomTextField(
                    icon: Icons.business_center,
                    label: "Type",
                  ),
                  const SizedBox(height: 20),
                  const CustomTextField(
                    icon: Icons.share,
                    label: "Social Media",
                  ),
                  const SizedBox(height: 20),
                  const CustomTextField(
                    icon: Icons.email,
                    label: "Email",
                  ),
                  const SizedBox(height: 20),
                  const CustomTextField(
                    icon: Icons.upload_file,
                    label: "Document Upload",
                  ),
                  const SizedBox(height: 20),
                  const CustomTextField(
                    icon: Icons.lock,
                    label: "Password",
                    isPassword: true,
                  ),
                  const SizedBox(height: 20),
                  const CustomTextField(
                    icon: Icons.lock_outline,
                    label: "Confirm Password",
                    isPassword: true,
                  ),
                  const SizedBox(height: 40),
                  Center(
                    child: ElevatedButton(
                      onPressed: () {},
                      style: ElevatedButton.styleFrom(
                        backgroundColor: appButtonColor,
                        padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 50),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                      ),
                      child: const Text(
                        'SIGN UP',
                        style: TextStyle(fontSize: 16, color: Colors.white),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  Center(
                    child: TextButton(
                      onPressed: () {
                      Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const LoginPage()), 
                      );
                      },
                      child: const Text(
                        "Already have an account? Login In",
                        style: TextStyle(
                          fontSize: 14,
                          color: appButtonColor,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class CustomTextField extends StatefulWidget {
  final IconData icon;
  final String label;
  final bool isPassword;

  const CustomTextField({
    super.key,
    required this.icon,
    required this.label,
    this.isPassword = false,
  });

  @override
  _CustomTextFieldState createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  bool _obscureText = true; 

  @override
  Widget build(BuildContext context) {
    return TextField(
      obscureText: widget.isPassword ? _obscureText : false,
      decoration: InputDecoration(
        prefixIcon: Icon(widget.icon, color: appButtonColor),
        labelText: widget.label,
        labelStyle: const TextStyle(color: appButtonColor),
        border: const UnderlineInputBorder(),
        enabledBorder: const UnderlineInputBorder(
          borderSide: BorderSide(color: appButtonColor),
        ),
        focusedBorder: const UnderlineInputBorder(
          borderSide: BorderSide(color: appButtonColor),
        ),
        suffixIcon: widget.isPassword
            ? IconButton(
                icon: Icon(
                  _obscureText ? Icons.visibility : Icons.visibility_off,
                  color: appButtonColor,
                ),
                onPressed: () {
                  setState(() {
                    _obscureText = !_obscureText;
                  });
                },
              )
            : null,
      ),
    );
  }
}

class WaveClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    var path = Path();
    path.lineTo(0, size.height * 0.6);

    var firstControlPoint = Offset(size.width * 0.2, size.height * 0.2);
    var firstEndPoint = Offset(size.width * 0.5, size.height * 0.3);
    path.quadraticBezierTo(
        firstControlPoint.dx, firstControlPoint.dy, firstEndPoint.dx, firstEndPoint.dy);

    var secondControlPoint = Offset(size.width * 0.8, size.height * 0.4);
    var secondEndPoint = Offset(size.width, 0);
    path.quadraticBezierTo(
        secondControlPoint.dx, secondControlPoint.dy, secondEndPoint.dx, secondEndPoint.dy);

    path.lineTo(size.width, 0);
    path.lineTo(0, 0);
    path.close();

    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}
