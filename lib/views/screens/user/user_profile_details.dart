import 'package:donate_application/themes/colors.dart';
import 'package:flutter/material.dart';
import 'package:donate_application/views/widgets/input_field.dart';

class UserProfileDetailsScreen extends StatelessWidget {
  const UserProfileDetailsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: appBarColor,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text('Profile details', style: TextStyle(color: Colors.black)),
        centerTitle: true,
      ),
      body: Container(
        color: appBackgroundColor,
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 24),
                InputField(
                  label: 'Full name',
                  enabled: false, 
                  backgroundColor: Colors.white,
                  controller: TextEditingController(text: 'sirine'),
                ),
                SizedBox(height: 16),
                InputField(
                  label: 'Email',
                  enabled: false, 
                  backgroundColor: Colors.white,
                  controller: TextEditingController(text: 'sirine44@example.com'),
                ),
                SizedBox(height: 16),
                Row(
                  children: [
                    Expanded(
                      child: InputField(
                        label: "Gender",
                        enabled: false, 
                        backgroundColor: Colors.white, 
                        controller: TextEditingController(text: 'Female'),
                      ),
                    ),
                    SizedBox(width: 25),
                    Expanded(
                      child: InputField(
                        label: "Profession",
                        enabled: false, 
                        backgroundColor: Colors.white,
                        controller: TextEditingController(text: 'Student'),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 30),
                InputField(
                  label: 'Date of birth',
                  enabled: false,
                  backgroundColor: Colors.white,
                  controller: TextEditingController(text: '22-07-2004'),
                ),
                SizedBox(height: 16),
                InputField(
                  label: 'Phone number',
                  enabled: false,
                  backgroundColor: Colors.white, 
                  controller: TextEditingController(text: '+213 6 12 34 56 78'),
                ),
                SizedBox(height: 16),
                InputField(
                  label: 'Address',
                  enabled: false, 
                  backgroundColor: Colors.white,
                  controller: TextEditingController(
                      text: 'Rue Bouzered Hocine, Annaba 23000, Algeria'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
