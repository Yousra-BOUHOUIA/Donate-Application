import 'package:flutter/material.dart';
import '/themes/colors.dart';
import '/views/widgets/input_field.dart';

class EditOrgProfileScreen extends StatelessWidget {
  const EditOrgProfileScreen({super.key});

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
        title: const Text('Edit profile', style: TextStyle(color: Colors.black)),
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
                InputField(
                  label: "Organization name",
                  controller: TextEditingController(text: "Hilal Ahmar"),
                  enabled: true,
                ),
                const SizedBox(height: 20),
                InputField(
                  label: "Email",
                  controller: TextEditingController(text: "contact@hilal-ahmer-algeria.org"),
                  enabled: true,
                ),
                const SizedBox(height: 20),
                InputField(
                  label: "Type",
                  controller: TextEditingController(text: "Humanitarian non-profit"),
                  enabled: true,
                ),
                const SizedBox(height: 20),
                InputField(
                  label: "Phone number",
                  controller: TextEditingController(text: "+213 21 92 74 00"),
                  enabled: true,
                ),
                const SizedBox(height: 20),
                InputField(
                  label: "Address",
                  controller: TextEditingController(
                    text: "Rue Bouzered Hocine, Annaba 23000, Algeria",
                  ),
                  enabled: true,
                ),
                const SizedBox(height: 20),
                InputField(
                  label: "About the organization",
                  controller: TextEditingController(
                    text:
                    "Hilal Ahmar is a non-profit organization dedicated to providing humanitarian aid and support to vulnerable communities in Algeria. We offer essential services such as healthcare, emergency relief, and educational programs to empower individuals and help them build a better future.",
                  ),
                  enabled: true,
                  maxLines: 8, // Increased maxLines for a larger field
                  contentPadding: const EdgeInsets.symmetric(vertical: 20, horizontal: 12), // Add padding for better spacing
                ),
                const SizedBox(height: 20),
                const Text(
                  "Social platforms",
                  style: TextStyle(color: Colors.grey, fontSize: 15),
                ),
                const SizedBox(height: 10),
                _buildSocialPlatformTile(
                  context,
                  initialText: "https://www.hilaleahmar.com",
                  icon: Icons.remove_circle,
                  iconColor: appButtonColor,
                  actionColor: appButtonColor,
                ),
                const SizedBox(height: 10),
                _buildSocialPlatformTile(
                  context,
                  initialText: "https://web.facebook.com/p/",
                  icon: Icons.remove_circle,
                  iconColor: appButtonColor,
                  actionColor: appButtonColor,
                ),
                const SizedBox(height: 10),
                _buildSocialPlatformTile(
                  context,
                  initialText: "Add a new platform link",
                  icon: Icons.add_circle,
                  iconColor: appButtonColor,
                  actionColor: appButtonColor,
                ),
                const SizedBox(height: 40),
                ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    minimumSize: const Size(double.infinity, 50),
                    backgroundColor: appButtonColor ,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  child: const Text("Save changes", style: TextStyle(fontSize: 16, color: Colors.white)),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildSocialPlatformTile(
    BuildContext context, {
    required String initialText,
    required IconData icon,
    required Color iconColor,
    required Color actionColor, // Color for the button background
  }) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.2),
            spreadRadius: 2,
            blurRadius: 4,
            offset: const Offset(0, 2), // Shadow position
          ),
        ],
      ),
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(horizontal: 16),
        title: Row(
          children: [
            // TextField wrapped in Expanded to take available space
            Expanded(
              child: TextField(
                style: const TextStyle(color: Colors.black, fontWeight: FontWeight.normal), // Removed bold styling
                decoration: InputDecoration(
                  border: InputBorder.none,
                  hintText: initialText,
                  hintStyle: const TextStyle(color: Colors.black), // Set hint text color to black
                ),
              ),
            ),
            // IconButton placed inside a CircleAvatar to add background color
            Padding(
              padding: const EdgeInsets.only(left: 8), // Adding space between TextField and button
              child: CircleAvatar(
                radius: 20,
                backgroundColor: actionColor, // Background color of the circle
                child: IconButton(
                  icon: Icon(icon, color: Colors.white),
                  onPressed: () {},
                  iconSize: 30,
                  splashRadius: 30,
                  padding: EdgeInsets.zero, // Set padding to zero to center the icon
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
