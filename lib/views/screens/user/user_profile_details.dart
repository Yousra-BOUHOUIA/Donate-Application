import 'dart:convert';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../themes/colors.dart';
import '../../widgets/input_field.dart';
import 'user_edit_profile.dart';
import '../../../databases/db_helper.dart';


class UserProfileDetailsScreen extends StatefulWidget {
  const UserProfileDetailsScreen({super.key});
  static const String pageRoute = '/user_profile_details';

  @override
  State<UserProfileDetailsScreen> createState() => _UserProfileDetailsScreenState();
}

class _UserProfileDetailsScreenState extends State<UserProfileDetailsScreen> {
  Map<String, dynamic>? userData;
  bool isLoading = true;
  int? userId; // Store the fetched user ID

  @override
  void initState() {
    super.initState();
    _fetchUserData();
  }

  Future<void> _fetchUserData() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    String? userEmail = prefs.getString('current_user_email');
    if (userEmail != null) {
      final db = await DBHelper.getDatabase();
      final result = await db.query(
        'participant',
        where: 'email = ?',
        whereArgs: [userEmail],
        limit: 1,
      );

      if (result.isNotEmpty) {
        setState(() {
          userData = result.first;
          userId = userData!['participant_id']; // Store the fetched user ID
          isLoading = false;
        });
      } else {
        setState(() => isLoading = false);
      }
    } else {
      setState(() => isLoading = false);
    }
  }

  Uint8List? _getImageBytes(String? base64String) {
    if (base64String == null || base64String.isEmpty) return null;
    try {
      return base64Decode(base64String);
    } catch (e) {
      return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    Uint8List? imageBytes = _getImageBytes(userData?['image']);

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
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : userData == null
              ? const Center(child: Text("No user data found"))
              : SingleChildScrollView(
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
                            backgroundImage: imageBytes != null
                                ? MemoryImage(imageBytes) as ImageProvider
                                : const AssetImage('assets/images/user_profile.png'),
                            backgroundColor: Colors.grey[200],
                          ),
                          Positioned(
                            bottom: 0,
                            right: 0,
                            child: GestureDetector(
                              onTap: () {
                                // Navigate to the edit screen with the fetched user ID
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => EditUserProfileScreen(userId: userId!),
                                  ),
                                ).then((value) {
                                  if (value == true) {
                                    _fetchUserData(); // Refresh data after editing
                                  }
                                });
                              },
                              child: Container(
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: Colors.white,
                                  border: Border.all(color: Colors.grey, width: 1),
                                ),
                                padding: const EdgeInsets.all(5),
                                child: const Icon(Icons.edit, color: Colors.black, size: 20),
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 16),
                      Text(
                        userData!['name']?.toString() ?? "Unknown",
                        style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        userData!['email']?.toString() ?? "Unknown",
                        style: const TextStyle(fontSize: 14, color: Colors.grey),
                      ),
                      const SizedBox(height: 24),
                      InputField(
                        label: 'Full name',
                        enabled: false,
                        controller: TextEditingController(text: userData!['name']?.toString() ?? ""),
                      ),
                      const SizedBox(height: 16),
                      InputField(
                        label: 'Email',
                        enabled: false,
                        controller: TextEditingController(text: userData!['email']?.toString() ?? ""),
                      ),
                      const SizedBox(height: 16),
                      Row(
                        children: [
                          Expanded(
                            child: InputField(
                              label: "Gender",
                              enabled: false,
                              controller: TextEditingController(text: userData!['gender']?.toString() ?? ""),
                            ),
                          ),
                          const SizedBox(width: 25),
                          Expanded(
                            child: InputField(
                              label: "Profession",
                              enabled: false,
                              controller: TextEditingController(text: userData!['profession']?.toString() ?? ""),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 30),
                      InputField(
                        label: 'Date of birth',
                        enabled: false,
                        controller: TextEditingController(text: userData!['date_of_birth']?.toString() ?? ""),
                      ),
                      const SizedBox(height: 16),
                      InputField(
                        label: 'Phone number',
                        enabled: false,
                        controller: TextEditingController(text: userData!['phone_num']?.toString() ?? ""),
                      ),
                      const SizedBox(height: 16),
                      InputField(
                        label: 'Address',
                        enabled: false,
                        controller: TextEditingController(text: userData!['address']?.toString() ?? ""),
                      ),
                    ],
                  ),
                ),
    );
  }
}