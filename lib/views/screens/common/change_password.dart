import '../../widgets/input_field.dart';
import 'package:flutter/material.dart';
import '../../../themes/colors.dart';
import 'package:donate_application/databases/tables/participant.dart'; 
import 'package:donate_application/databases/tables/organization.dart'; 


class ChangePasswordScreen extends StatefulWidget {
  final bool isOrganization;

  const ChangePasswordScreen({super.key, required this.isOrganization});
  static const String pageRoute = '/change_password';


  @override
  _ChangePasswordScreenState createState() => _ChangePasswordScreenState();
}

class _ChangePasswordScreenState extends State<ChangePasswordScreen> {
  final TextEditingController oldPasswordController = TextEditingController();
  final TextEditingController newPasswordController = TextEditingController();
  final TextEditingController confirmPasswordController = TextEditingController();

  Future<void> _updatePassword() async {
    String oldPassword = oldPasswordController.text;
    String newPassword = newPasswordController.text;
    String confirmPassword = confirmPasswordController.text;

    if (newPassword != confirmPassword) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Passwords do not match")),
      );
      return;
    }

    if (widget.isOrganization) {
      DBOrganizationTable dbOrganizationTable = DBOrganizationTable();
      int organizationId = 1; // This should be dynamically set based on the logged-in organization

      String currentPassword = await dbOrganizationTable.getPasswordById(organizationId);

      if (currentPassword != oldPassword) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Old password does not match")),
        );
        return;
      }

      Map<String, dynamic> updatedData = {'password': newPassword};
      bool success = await dbOrganizationTable.updateRecord(updatedData, 'organization_id', organizationId);

      if (success) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Password updated successfully")),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Failed to update password")),
        );
      }
    } else {
      DBParticipantTable dbParticipantTable = DBParticipantTable();
      int participantId = 1; // This should be dynamically set based on the logged-in participant

      String currentPassword = await dbParticipantTable.getPasswordById(participantId);

      if (currentPassword != oldPassword) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Old password does not match")),
        );
        return;
      }

      Map<String, dynamic> updatedData = {'password': newPassword};
      bool success = await dbParticipantTable.updateRecord(updatedData, 'participant_id', participantId);

      if (success) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Password updated successfully")),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Failed to update password")),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: appBackgroundColor,
      appBar: AppBar(
        title: const Text("Change Password", style: TextStyle(color: Description_Text)),
        centerTitle: true,
        backgroundColor: appBarColor,
        elevation: 0,
        foregroundColor: Description_Text,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Description_Text),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisSize: MainAxisSize.min,
            children: [
              const SizedBox(height: 50),
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.9,
                child: InputField(
                  label: "Your old password",
                  controller: oldPasswordController,
                  backgroundColor: Colors.grey[200]!,
                ),
              ),
              const SizedBox(height: 12),
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.9,
                child: InputField(
                  label: "Your new password",
                  controller: newPasswordController,
                  backgroundColor: Colors.grey[200]!,
                ),
              ),
              const SizedBox(height: 12),
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.95,
                child: InputField(
                  label: "Please confirm your password",
                  controller: confirmPasswordController,
                  backgroundColor: Colors.grey[200]!,
                ),
              ),
              const SizedBox(height: 60),
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.95,
                child: ElevatedButton(
                  onPressed: _updatePassword,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: appButtonColor,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    textStyle: const TextStyle(fontSize: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(4),
                      side: const BorderSide(color: Colors.white, width: 1.5),
                    ),
                  ),
                  child: const Text(
                    "Save changes",
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
