import 'package:flutter/material.dart';
import '../../../themes/colors.dart';
import '../../../imports/organization_barrel.dart';
import '../../../imports/common_barrel.dart';

class SignUpAsUserPage extends StatefulWidget {
  const SignUpAsUserPage({super.key});
  static const String pageRoute = '/signup_as_user';

  @override
  _SignUpAsUserPageState createState() => _SignUpAsUserPageState();
}

class _SignUpAsUserPageState extends State<SignUpAsUserPage> {
  bool isUser = true; // To track the switch state
  bool _isPasswordVisible = false; // To toggle password visibility
  bool _isConfirmPasswordVisible = false; // To toggle confirm password visibility

  final _formKey = GlobalKey<FormState>();
  final Map<String, String> _formData = {};
  String? _password; // Temporary variable for password validation

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
                        "As a user",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                          color: Colors.white,
                        ),
                      ),
                      Switch(
                        value: isUser,
                        onChanged: (value) {
                          if (!value) {
                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                    const SignUpAsOrganizationPage(),
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
                  CustomTextField(
                    icon: Icons.person,
                    label: "Name",
                    validator: (value) =>
                        value!.isEmpty ? "Name is required" : null,
                    onSaved: (value) => _formData['name'] = value!,
                  ),
                  const SizedBox(height: 20),
                  CustomTextField(
                    icon: Icons.email,
                    label: "Email",
                    validator: (value) {
                      if (value!.isEmpty) return "Email is required";
                      final emailRegex = RegExp(r'^[^@]+@[^@]+\.[^@]+');
                      if (!emailRegex.hasMatch(value)) {
                        return "Enter a valid email address";
                      }
                      return null;
                    },
                    onSaved: (value) => _formData['email'] = value!,
                  ),
                  const SizedBox(height: 20),
                  CustomTextField(
                    icon: Icons.transgender,
                    label: "Gender",
                    validator: (value) =>
                        value!.isEmpty ? "Gender is required" : null,
                    onSaved: (value) => _formData['gender'] = value!,
                  ),
                  const SizedBox(height: 20),
                  CustomTextField(
                    icon: Icons.work,
                    label: "Profession",
                    validator: (value) =>
                        value!.isEmpty ? "Profession is required" : null,
                    onSaved: (value) => _formData['profession'] = value!,
                  ),
                  const SizedBox(height: 20),
                  CustomTextField(
                    icon: Icons.calendar_today,
                    label: "Date of Birth",
                    validator: (value) =>
                        value!.isEmpty ? "Date of Birth is required" : null,
                    onSaved: (value) => _formData['dob'] = value!,
                  ),
                  const SizedBox(height: 20),
                  CustomTextField(
                    icon: Icons.phone,
                    label: "Phone",
                    validator: (value) {
                      if (value!.isEmpty) return "Phone is required";
                      final phoneRegex = RegExp(r'^\d{10}$');
                      if (!phoneRegex.hasMatch(value)) {
                        return "Enter a valid phone number";
                      }
                      return null;
                    },
                    onSaved: (value) => _formData['phone'] = value!,
                  ),
                  const SizedBox(height: 20),
                  CustomTextField(
                    icon: Icons.location_on,
                    label: "Address",
                    validator: (value) =>
                        value!.isEmpty ? "Address is required" : null,
                    onSaved: (value) => _formData['address'] = value!,
                  ),
                  const SizedBox(height: 20),
                  // Password Field with Eye Icon Toggle
                  CustomTextField(
                    icon: Icons.lock,
                    label: "Password",
                    isPassword: !_isPasswordVisible,
                    validator: (value) {
                      if (value == null || value.length < 6) {
                        return "Password must be at least 6 characters";
                      }
                      _password = value; // Store password temporarily
                      return null;
                    },
                    onSaved: (value) => _formData['password'] = value!,
                    suffixIcon: IconButton(
                      icon: Icon(
                        _isPasswordVisible
                            ? Icons.visibility_off
                            : Icons.visibility,
                        color: appButtonColor,
                      ),
                      onPressed: () {
                        setState(() {
                          _isPasswordVisible = !_isPasswordVisible;
                        });
                      },
                    ),
                  ),
                  const SizedBox(height: 20),
                  // Confirm Password Field with Eye Icon Toggle
                  CustomTextField(
                    icon: Icons.lock_outline,
                    label: "Confirm Password",
                    isPassword: !_isConfirmPasswordVisible,
                    validator: (value) {
                      if (value == null || value != _password) {
                        return "Passwords do not match";
                      }
                      return null;
                    },
                    suffixIcon: IconButton(
                      icon: Icon(
                        _isConfirmPasswordVisible
                            ? Icons.visibility_off
                            : Icons.visibility,
                        color: appButtonColor,
                      ),
                      onPressed: () {
                        setState(() {
                          _isConfirmPasswordVisible = !_isConfirmPasswordVisible;
                        });
                      },
                    ),
                  ),
                  const SizedBox(height: 40),
                  Center(
                    child: ElevatedButton(
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          _formKey.currentState!.save();
                          // Navigate to the home screen
                          Navigator.pushReplacementNamed(context, '/user_home');
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
                              builder: (context) => const LoginPage()),
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
}

class CustomTextField extends StatelessWidget {
  final IconData icon;
  final String label;
  final bool isPassword;
  final String? Function(String?) validator;
  final void Function(String?)? onSaved;
  final Widget? suffixIcon;

  const CustomTextField({
    super.key,
    required this.icon,
    required this.label,
    this.isPassword = false,
    required this.validator,
    this.onSaved,
    this.suffixIcon,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      obscureText: isPassword,
      validator: validator,
      onSaved: onSaved,
      decoration: InputDecoration(
        prefixIcon: Icon(icon, color: appButtonColor),
        labelText: label,
        labelStyle: const TextStyle(color: appButtonColor),
        border: const UnderlineInputBorder(),
        enabledBorder: const UnderlineInputBorder(
          borderSide: BorderSide(color: appButtonColor),
        ),
        focusedBorder: const UnderlineInputBorder(
          borderSide: BorderSide(color: appButtonColor),
        ),
        suffixIcon: suffixIcon,
      ),
    );
  }
}

class WaveClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final path = Path();
    path.lineTo(0, size.height);
    final firstControlPoint = Offset(size.width / 4, size.height - 50);
    final firstEndPoint = Offset(size.width / 2, size.height - 30);
    path.quadraticBezierTo(
        firstControlPoint.dx, firstControlPoint.dy, firstEndPoint.dx, firstEndPoint.dy);
    final secondControlPoint =
        Offset(size.width - (size.width / 4), size.height);
    final secondEndPoint = Offset(size.width, size.height - 50);
    path.quadraticBezierTo(
        secondControlPoint.dx, secondControlPoint.dy, secondEndPoint.dx, secondEndPoint.dy);
    path.lineTo(size.width, 0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) => false;
}
