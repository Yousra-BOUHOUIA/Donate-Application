import 'package:donate_application/views/widgets/input_field.dart';
import 'package:flutter/material.dart';
import 'package:donate_application/themes/colors.dart';

void main() => runApp(ChangePasswordApp());

class ChangePasswordApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: ChangePasswordScreen(),
    );
  }
}

class ChangePasswordScreen extends StatelessWidget {
  final TextEditingController oldPasswordController = TextEditingController();
  final TextEditingController newPasswordController = TextEditingController();
  final TextEditingController confirmPasswordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: appBackgroundColor,
      appBar: AppBar(
        title: Text("Change Password", style: TextStyle(color: Description_Text)),
        centerTitle: true,
        backgroundColor: appBarColor,
        elevation: 0,
        foregroundColor: Description_Text,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(height: 50), // Add space between AppBar and input field
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.9,
              child: InputField(
                label: "Your old password",
                controller: oldPasswordController,
                backgroundColor: Colors.grey[200]!,
              ),
            ),
            SizedBox(height: 12),
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.9,
              child: InputField(
                label: "Your new password",
                controller: newPasswordController,
                backgroundColor: Colors.grey[200]!,
              ),
            ),
            SizedBox(height: 12),
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.95,
              child: InputField(
                label: "Please confirm your password",
                controller: confirmPasswordController,
                backgroundColor: Colors.grey[200]!,
              ),
            ),
            SizedBox(height: 60),
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.95,
              child: ElevatedButton(
                onPressed: () {
                  // Handle password change logic here
                  print("Old Password: ${oldPasswordController.text}");
                  print("New Password: ${newPasswordController.text}");
                  print("Confirm Password: ${confirmPasswordController.text}");
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: appButtonColor,
                  padding: EdgeInsets.symmetric(vertical: 16),
                  textStyle: TextStyle(fontSize: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(4),
                    side: BorderSide(color: Colors.white, width: 1.5),
                  ),
                ),
                child: Text(
                  "Save changes",
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
