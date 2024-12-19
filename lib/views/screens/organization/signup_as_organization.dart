import 'package:flutter/material.dart';
import '../../../themes/colors.dart';
import '../../../imports/user_barrel.dart';
import 'package:donate_application/databases/tables/organization.dart';

// Widget for signing up as an organization
class SignUpAsOrganizationPage extends StatefulWidget {
  const SignUpAsOrganizationPage({super.key});
  static const String pageRoute = '/signup_as_organization';

  @override
  _SignUpAsOrganizationPageState createState() =>
      _SignUpAsOrganizationPageState();
}

class _SignUpAsOrganizationPageState extends State<SignUpAsOrganizationPage> {
  bool isUser = false;
  final _formKey = GlobalKey<FormState>();


  final DBOrganizationTable _dbOrganizationTable = DBOrganizationTable();
  
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =TextEditingController();
  final TextEditingController _organizationNameController =TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();
  final TextEditingController _bankAccountController = TextEditingController();
  final TextEditingController _organizationTypeController =TextEditingController();
  
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
            padding:
                const EdgeInsets.symmetric(horizontal: 40.0, vertical: 80.0),
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
                                    const SignUpAsUserPage(),
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
                  buildCustomTextField(Icons.business, "Organization Name"),
                  const SizedBox(height: 20),
                  buildCustomTextField(Icons.phone, "Phone"),
                  const SizedBox(height: 20),
                  buildCustomTextField(Icons.location_on, "Address"),
                  const SizedBox(height: 20),
                  buildCustomTextField(Icons.account_balance, "Bank Account"),
                  const SizedBox(height: 20),
                  buildCustomTextField(Icons.business_center, "Type"),
                  const SizedBox(height: 20),
                  buildCustomTextField(Icons.email, "Email"),
                  const SizedBox(height: 20),
                  // Password field
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
                  // Confirm Password field
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
                      onPressed: () async{
                        
                      Map<String, dynamic> OrganizationData = {
                        'organization_name': _organizationNameController.text,
                        'Phone': _phoneController.text,
                        'address': _addressController.text,
                        'bank_account': _bankAccountController.text,
                        'organization_type ': _organizationTypeController.text,
                        'email':_emailController.text,
                        'password ': _passwordController.text,
                      };

                      // Insert record into database
                      final success =
                          await _dbOrganizationTable.insertRecord(OrganizationData);
                      if (success) {
                        final allOrganizations =
                            await _dbOrganizationTable.getAllRecords();
                        print("All campaigns in the database:");
                        for (var organization in allOrganizations) {
                          print(organization);
                        }
                        // Clear input fields and reset state
                        _organizationNameController.clear();
                        _phoneController.clear();
                        _addressController.clear();
                        _bankAccountController.clear();
                        _organizationTypeController.clear();
                        _emailController.clear();
                        _passwordController.clear();

                        // Show success message
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('organization registred successufully!'),
                          ),
                        );
                      } else {
                        // Show failure message
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('Failed to register organization.'),
                          ),
                        );
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
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  // Build text field widget
  Widget buildCustomTextField(IconData icon, String label) {
    return TextFormField(
      controller: _getController(label),
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

  // Build password field widget
  Widget buildPasswordTextField(TextEditingController controller, String label,
      bool isPasswordVisible, Function(bool) onToggleVisibility) {
    return TextFormField(
      controller: controller,
      obscureText: !isPasswordVisible,
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Please enter $label';
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

  // Get appropriate controller based on the field label
  TextEditingController? _getController(String label) {
    switch (label) {
      case "Organization Name":
        return _organizationNameController;
      case "Phone":
        return _phoneController;
      case "Address":
        return _addressController;
      case "Bank Account":
        return _bankAccountController;
      case "Type":
        return _organizationTypeController;
      case "Email":
        return _emailController;
      default:
        return null;
    }
  }
}

// Custom clipper for the wave background
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
    var secondEndPoint = Offset(size.width, size.height * 0.1);
    path.quadraticBezierTo(secondControlPoint.dx, secondControlPoint.dy,
        secondEndPoint.dx, secondEndPoint.dy);

    path.lineTo(size.width, 0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    return false;
  }
}
