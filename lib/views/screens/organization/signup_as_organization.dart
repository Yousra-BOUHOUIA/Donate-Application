import 'package:flutter/material.dart';
import '../../../themes/colors.dart';
import '../../../imports/user_barrel.dart';
import '../../../imports/common_barrel.dart';

class SignUpAsOrganizationPage extends StatefulWidget {
  const SignUpAsOrganizationPage({super.key});
  static const String pageRoute = '/signup_as_organization';

  @override
  _SignUpAsOrganizationPageState createState() =>
      _SignUpAsOrganizationPageState();
}

class _SignUpAsOrganizationPageState extends State<SignUpAsOrganizationPage> {
  bool isUser = false; // To track the switch state
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();
  bool _isPasswordVisible = false;
  bool _isConfirmPasswordVisible = false;
  String? uploadedFilePath;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
            child: Form(
              key: _formKey,
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
                          color: Colors.white,
                        ),
                      ),
                      Switch(
                        value: isUser,
                        onChanged: (value) {
                          if (value) {
                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                    const SignUpAsUserPage(), // Replace with actual widget
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
                  buildCustomTextField(Icons.business, "Organization Name"),
                  const SizedBox(height: 20),
                  buildCustomTextField(Icons.phone, "Phone"),
                  const SizedBox(height: 20),
                  buildCustomTextField(Icons.location_on, "Address"),
                  const SizedBox(height: 20),
                  buildCustomTextField(Icons.payment, "Do you support money transaction?"),
                  const SizedBox(height: 20),
                  buildCustomTextField(Icons.account_balance, "Bank Account"),
                  const SizedBox(height: 20),
                  buildCustomTextField(Icons.business_center, "Type"),
                  const SizedBox(height: 20),
                  buildCustomTextField(Icons.share, "Social Media"),
                  const SizedBox(height: 20),
                  buildCustomTextField(Icons.email, "Email"),
                  const SizedBox(height: 20),
                  // File upload field
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        "Document Upload",
                        style: TextStyle(color: appButtonColor, fontSize: 16),
                      ),
                      const SizedBox(height: 8),
                      IconButton(
                        onPressed: () async {
                          // Implement file picker logic here
                          setState(() {
                            uploadedFilePath = "example_document.pdf"; // Mock file name
                          });
                        },
                        icon: const Icon(Icons.upload_file, size: 32),
                        color: appButtonColor,
                      ),
                      if (uploadedFilePath != null)
                        Text(
                          "Uploaded: $uploadedFilePath",
                          style: const TextStyle(color: Colors.white),
                        ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  // Password field with toggle visibility
                  buildPasswordTextField(
                    _passwordController,
                    "Password",
                    _isPasswordVisible,
                    (value) {
                      setState(() {
                        _isPasswordVisible = value;
                      });
                    },
                  ),
                  const SizedBox(height: 20),
                  // Confirm Password field with toggle visibility
                  buildPasswordTextField(
                    _confirmPasswordController,
                    "Confirm Password",
                    _isConfirmPasswordVisible,
                    (value) {
                      setState(() {
                        _isConfirmPasswordVisible = value;
                      });
                    },
                  ),
                  const SizedBox(height: 40),
                  Center(
                    child: ElevatedButton(
                      onPressed: () {
                        if (_formKey.currentState?.validate() ?? false) {
                          // Navigate to org_home route
                          Navigator.pushNamed(context, '/org_home');
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: appButtonColor,
                        padding: const EdgeInsets.symmetric(
                            vertical: 15, horizontal: 50),
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
                          MaterialPageRoute(
                              builder: (context) =>
                                  const LoginPage()),
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
          ),
        ],
      ),
    );
  }

  Widget buildCustomTextField(IconData icon, String label) {
    return TextFormField(
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Please enter $label';
        }
        return null;
      },
      decoration: InputDecoration(
        prefixIcon: Icon(icon, color: appButtonColor),
        labelText: label,
        labelStyle: const TextStyle(color: appButtonColor),
        enabledBorder: const UnderlineInputBorder(
          borderSide: BorderSide(color: appButtonColor),
        ),
        focusedBorder: const UnderlineInputBorder(
          borderSide: BorderSide(color: appButtonColor),
        ),
      ),
    );
  }

  Widget buildPasswordTextField(TextEditingController controller, String label,
      bool isPasswordVisible, Function(bool) onToggleVisibility) {
    return TextFormField(
      controller: controller,
      obscureText: !isPasswordVisible,
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Please enter your $label';
        }
        if (label == "Password" && value.length < 6) {
          return 'Password must be at least 6 characters';
        }
        if (label == "Confirm Password" &&
            value != _passwordController.text) {
          return 'Passwords do not match';
        }
        return null;
      },
      decoration: InputDecoration(
        prefixIcon: const Icon(Icons.lock, color: appButtonColor),
        labelText: label,
        labelStyle: const TextStyle(color: appButtonColor),
        enabledBorder: const UnderlineInputBorder(
          borderSide: BorderSide(color: appButtonColor),
        ),
        focusedBorder: const UnderlineInputBorder(
          borderSide: BorderSide(color: appButtonColor),
        ),
        suffixIcon: IconButton(
          icon: Icon(
            isPasswordVisible ? Icons.visibility : Icons.visibility_off,
            color: appButtonColor,
          ),
          onPressed: () => onToggleVisibility(!isPasswordVisible),
        ),
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
    path.quadraticBezierTo(firstControlPoint.dx, firstControlPoint.dy,
        firstEndPoint.dx, firstEndPoint.dy);

    var secondControlPoint = Offset(size.width * 0.8, size.height * 0.4);
    var secondEndPoint = Offset(size.width, 0);
    path.quadraticBezierTo(secondControlPoint.dx, secondControlPoint.dy,
        secondEndPoint.dx, secondEndPoint.dy);

    path.lineTo(size.width, 0);
    path.lineTo(0, 0);
    path.close();

    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}
