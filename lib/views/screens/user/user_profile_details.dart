import 'package:flutter/material.dart';
import '/themes/colors.dart';
import '/views/widgets/input_field.dart';
import '/views/screens/user/user_edit_profile.dart';


class UserProfileDetailsScreen extends StatelessWidget {
  const UserProfileDetailsScreen({super.key});
  static const String pageRoute = '/user_profile';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: appBarColor,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text('Profile details', style: TextStyle(color: Colors.black)),
        centerTitle: true,
      ),
      body: Container(
        color: appBackgroundColor,
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(height: 24),
                Stack(
                  alignment: Alignment.bottomRight,
                  children: [
                    CircleAvatar(
                      radius: 50,
                      backgroundImage: const AssetImage('assets/profile_picture.jpg'), // Replace with your image asset path
                      backgroundColor: Colors.grey[200],
                    ),
                    Positioned(
                      bottom: 0,
                      right: 0,
                      child: GestureDetector(
                        onTap: () {
                          // Navigate to the EditUserProfileScreen when the edit icon is clicked
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const EditUserProfileScreen(),
                            ),
                          );
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: Colors.white,
                            border: Border.all(color: Colors.grey, width: 1),
                          ),
                          padding: const EdgeInsets.all(5),
                          child: const Icon(
                            Icons.edit,
                            color: Colors.black,
                            size: 20,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                const Text(
                  'Full name', // Replace with dynamic name if needed
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 4),
                const Text(
                  'youremail@domain.com', // Replace with dynamic email if needed
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.grey,
                  ),
                ),
                const SizedBox(height: 24),
                InputField(
                  label: 'Full name',
                  enabled: false,
                  backgroundColor: Colors.white,
                  controller: TextEditingController(text: 'sirine'),
                ),
                const SizedBox(height: 16),
                InputField(
                  label: 'Email',
                  enabled: false,
                  backgroundColor: Colors.white,
                  controller: TextEditingController(text: 'sirine44@example.com'),
                ),
                const SizedBox(height: 16),
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
                    const SizedBox(width: 25),
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
                const SizedBox(height: 30),
                InputField(
                  label: 'Date of birth',
                  enabled: false,
                  backgroundColor: Colors.white,
                  controller: TextEditingController(text: '22-07-2004'),
                ),
                const SizedBox(height: 16),
                InputField(
                  label: 'Phone number',
                  enabled: false,
                  backgroundColor: Colors.white,
                  controller: TextEditingController(text: '+213 6 12 34 56 78'),
                ),
                const SizedBox(height: 16),
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
