import 'package:flutter/material.dart';
import '../../widgets/input_field.dart';
import '../../../themes/colors.dart';



class EditUserProfileScreen extends StatelessWidget {
  const EditUserProfileScreen({super.key});
    static const String pageRoute = '/user_edit_profile';


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFFF8F6F6),
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text('Edit profile', style: TextStyle(color: Colors.black)),
        centerTitle: true,
      ),
      body: Container(
        color: const Color(0xFFF8F6F6),
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                InputField(
                  label: "Full name",
                  controller: TextEditingController(text: "Your name"),
                  enabled: true,
                ),
                const SizedBox(height: 20),
                InputField(
                  label: "Email",
                  controller: TextEditingController(text: "youremail@domain.com"),
                  enabled: true,
                ),
                const SizedBox(height: 20),
                Row(
                  children: [
                    Expanded(
                      child: InputField(
                        label: "Gender",
                        controller: TextEditingController(text: "Female"),
                        enabled: true,
                      ),
                    ),
                    const SizedBox(width: 20),
                    Expanded(
                      child: InputField(
                        label: "Profession",
                        controller: TextEditingController(text: "Student"),
                        enabled: true,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                InputField(
                  label: "Date of birth",
                  controller: TextEditingController(text: "22 - 07 - 2004"),
                  enabled: true,
                ),
                const SizedBox(height: 20),
                InputField(
                  label: "Phone number",
                  controller: TextEditingController(text: "0612 34 56 78"),
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
                const SizedBox(height: 100), // Spacing before the button
                ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    minimumSize: const Size(double.infinity, 50),
                    backgroundColor: appButtonColor,
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
}
