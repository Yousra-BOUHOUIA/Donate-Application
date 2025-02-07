import 'package:donate_application/bloc/SignUp.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../themes/colors.dart';
import '../../../imports/organization_barrel.dart';
import '../../../imports/common_barrel.dart';
import 'package:donate_application/databases/tables/participant.dart';

class SignUpAsUserPage extends StatefulWidget {
  const SignUpAsUserPage({super.key});
  static const String pageRoute = '/signup_as_user';

  @override
  _SignUpAsUserPageState createState() => _SignUpAsUserPageState();
}

class _SignUpAsUserPageState extends State<SignUpAsUserPage> {
  bool isUser = true;

  DBParticipantTable dbParticipantTable = DBParticipantTable();
  

  final _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _genderController = TextEditingController();
  final TextEditingController _professionController = TextEditingController();
  final TextEditingController _dobController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController = TextEditingController();

  String? _password; 

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _genderController.dispose();
    _professionController.dispose();
    _dobController.dispose();
    _phoneController.dispose();
    _addressController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
  
    return BlocBuilder<SignupCubit, Map<String, dynamic>>(
      builder: (context, state) {
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
                  BlocListener<SignupCubit, Map<String, dynamic>>(
                    listenWhen: (previous, current) => previous["isUser"] != current["isUser"],
                    listener: (context, state) {
                      if (state["isUser"] == false) {
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(builder: (context) => const SignUpAsOrganizationPage()),
                        );
                      } else {
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(builder: (context) => const SignUpAsUserPage()),
                        );
                      }
                    },
                    child: Switch(
                      value: state["isUser"] ?? true,
                      onChanged: (value) {
                    
                        context.read<SignupCubit>().switchUserType(value);
                      },
                    ),
                  )



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
                    controller: _nameController,
                    icon: Icons.person,
                    label: "Name",
                    validator: (value) => value!.isEmpty ? "Name is required" : null,
                  ),
                  const SizedBox(height: 20),
                  CustomTextField(
                    controller: _emailController,
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
                  ),
                  const SizedBox(height: 20),
                  CustomTextField(
                    controller: _genderController,
                    icon: Icons.transgender,
                    label: "Gender",
                    validator: (value) => value!.isEmpty ? "Gender is required" : null,
                  ),
                  const SizedBox(height: 20),
                  CustomTextField(
                    controller: _professionController,
                    icon: Icons.work,
                    label: "Profession",
                    validator: (value) => value!.isEmpty ? "Profession is required" : null,
                  ),
                  const SizedBox(height: 20),
                  CustomTextField(
                    controller: _dobController,
                    icon: Icons.calendar_today,
                    label: "Date of Birth",
                    validator: (value) => value!.isEmpty ? "Date of Birth is required" : null,
                  ),
                  const SizedBox(height: 20),
                  CustomTextField(
                    controller: _phoneController,
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
                  ),
                  const SizedBox(height: 20),
                  CustomTextField(
                    controller: _addressController,
                    icon: Icons.location_on,
                    label: "Address",
                    validator: (value) => value!.isEmpty ? "Address is required" : null,
                  ),
                  const SizedBox(height: 20),
                  // Password Field with Eye Icon Toggle
                   CustomTextField(
                        controller: _passwordController,
                        icon: Icons.lock,
                        label: "Password",
                        isPassword: !state["isPasswordVisible"],
                        validator: (value) {
                          if (value == null || value.length < 6) {
                            return "Password must be at least 6 characters";
                          }
                          return null;
                        },
                        suffixIcon: IconButton(
                          icon: Icon(
                            state["isPasswordVisible"] ? Icons.visibility : Icons.visibility_off,
                            color: appButtonColor,
                          ),
                          onPressed: () {
                            context.read<SignupCubit>().togglePasswordVisibility();
                          },
                        ),
                      ),
                      const SizedBox(height: 20),
                      CustomTextField(
                        controller: _confirmPasswordController,
                        icon: Icons.lock_outline,
                        label: "Confirm Password",
                        isPassword: !state["isConfirmPasswordVisible"],
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "Confirm your password";
                          }
                          return null;
                        },
                        suffixIcon: IconButton(
                          icon: Icon(
                            state["isConfirmPasswordVisible"] ? Icons.visibility : Icons.visibility_off,
                            color: appButtonColor,
                          ),
                          onPressed: () {
                            context.read<SignupCubit>().toggleConfirmPasswordVisibility();
                          },
                        ),
                      ),
                  const SizedBox(height: 40),
                  Center(
                    child: ElevatedButton(
   onPressed: () async {
  if (_formKey.currentState!.validate()) {
    print("Validating form inputs...");

    Map<String, dynamic> userData = {
      'name': _nameController.text,
      'email': _emailController.text,
      'gender': _genderController.text,
      'profession': _professionController.text,
      'date_of_birth': _dobController.text,
      'phone_num': _phoneController.text,
      'address': _addressController.text,
      'password': _passwordController.text,
      'image': '', 
    };
      
    bool result = await dbParticipantTable.insertRecord(userData);

    if (result == true) {
      // Success scenario
      print("User data inserted successfully with row ID: $result");

      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) => const AlertDialog(
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              CircularProgressIndicator(),
              SizedBox(height: 20),
              Text(
                "We have successfully created your account! Please wait a moment.",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
            ],
          ),
        ),
      );

      await Future.delayed(const Duration(seconds: 8));
      if (mounted) {
        Navigator.pop(context); // Close dialog
        Navigator.pushReplacementNamed(context, '/login'); 
      }
    } else {
      // Error scenario
      print("Failed to insert user data. Please check the logs for details.");
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Failed to register user. Please try again.")),
      );
    }
  }
},
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
                        style: TextStyle(fontSize: 14, color: appButtonColor),
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
        );
  }
}

class CustomTextField extends StatelessWidget {
  final TextEditingController controller;
  final IconData icon;
  final String label;
  final bool isPassword;
  final String? Function(String?) validator;
  final Widget? suffixIcon;

  const CustomTextField({
    super.key,
    required this.controller,
    required this.icon,
    required this.label,
    this.isPassword = false,
    required this.validator,
    this.suffixIcon,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      obscureText: isPassword,
      validator: validator,
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
    var path = Path();
    path.lineTo(0, size.height * 0.6);

    var firstControlPoint = Offset(size.width * 0.2, size.height * 0.2);
    var firstEndPoint = Offset(size.width * 0.5, size.height * 0.3);
    path.quadraticBezierTo(firstControlPoint.dx, firstControlPoint.dy,
        firstEndPoint.dx, firstEndPoint.dy);

    var secondControlPoint = Offset(size.width * 0.8, size.height * 0.4);
    var secondEndPoint = Offset(size.width, size.height * 0.3);
    path.quadraticBezierTo(secondControlPoint.dx, secondControlPoint.dy,
        secondEndPoint.dx, secondEndPoint.dy);

    path.lineTo(size.width, 0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return false;
  }
}
