import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import '../../widgets/input_field.dart';
import '../../../themes/colors.dart';
import '../../../databases/db_helper.dart';

class EditUserProfileScreen extends StatefulWidget {
  final int userId; // User ID passed from the previous screen

  const EditUserProfileScreen({super.key, required this.userId});
  static const String pageRoute = '/user_edit_profile';

  @override
  _EditUserProfileScreenState createState() => _EditUserProfileScreenState();
}

class _EditUserProfileScreenState extends State<EditUserProfileScreen> {
  Map<String, dynamic>? userData;
  final Map<String, TextEditingController> _controllers = {};
  File? _imageFile;
  final ImagePicker _picker = ImagePicker();

  @override
  void initState() {
    super.initState();
    _fetchUserData();
  }

  Future<void> _fetchUserData() async {
    final db = await DBHelper.getDatabase();
    final result = await db.query(
      'participant',
      where: 'participant_id = ?',
      whereArgs: [widget.userId],
      limit: 1,
    );

    if (result.isNotEmpty) {
      setState(() {
        userData = result.first;
        _initializeControllers();
      });
    }
  }

  void _initializeControllers() {
    _controllers['name'] = TextEditingController(text: userData?['name']?.toString());
    _controllers['email'] = TextEditingController(text: userData?['email']?.toString());
    _controllers['gender'] = TextEditingController(text: userData?['gender']?.toString());
    _controllers['profession'] = TextEditingController(text: userData?['profession']?.toString());
    _controllers['date_of_birth'] = TextEditingController(text: userData?['date_of_birth']?.toString());
    _controllers['phone_num'] = TextEditingController(text: userData?['phone_num']?.toString());
    _controllers['address'] = TextEditingController(text: userData?['address']?.toString());
  }

  Future<void> _pickImage() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      setState(() {
        _imageFile = File(pickedFile.path);
      });
    }
  }

  Future<void> _saveChanges() async {
    String? imageBase64;
    if (_imageFile != null) {
      List<int> imageBytes = await _imageFile!.readAsBytes();
      imageBase64 = base64Encode(imageBytes);
    }

    Map<String, dynamic> updatedData = {
      'name': _controllers['name']?.text,
      'email': _controllers['email']?.text,
      'gender': _controllers['gender']?.text,
      'profession': _controllers['profession']?.text,
      'date_of_birth': _controllers['date_of_birth']?.text,
      'phone_num': _controllers['phone_num']?.text,
      'address': _controllers['address']?.text,
      'image': imageBase64 ?? userData?['image'], // Use existing image if no new image is picked
    };

    final db = await DBHelper.getDatabase();
    int count = await db.update(
      'participant',
      updatedData,
      where: 'participant_id = ?',
      whereArgs: [widget.userId],
    );

    if (count > 0) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Profile updated successfully!')),
      );
      Navigator.pop(context, true); // Return true to indicate success
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Failed to update profile.')),
      );
    }
  }

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
      body: userData == null
          ? const Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    GestureDetector(
                      onTap: _pickImage,
                      child: CircleAvatar(
                        radius: 50,
                        backgroundImage: _imageFile != null
                            ? FileImage(_imageFile!) as ImageProvider
                            : (userData?['image'] != null
                                ? MemoryImage(base64Decode(userData!['image']))
                                : const AssetImage('assets/images/user_profile.png')) as ImageProvider,
                        backgroundColor: Colors.grey[200],
                      ),
                    ),
                    const SizedBox(height: 20),
                    InputField(
                      label: "Full name",
                      controller: _controllers['name'],
                      enabled: true,
                    ),
                    const SizedBox(height: 20),
                    InputField(
                      label: "Email",
                      controller: _controllers['email'],
                      enabled: true,
                    ),
                    const SizedBox(height: 20),
                    Row(
                      children: [
                        Expanded(
                          child: InputField(
                            label: "Gender",
                            controller: _controllers['gender'],
                            enabled: true,
                          ),
                        ),
                        const SizedBox(width: 20),
                        Expanded(
                          child: InputField(
                            label: "Profession",
                            controller: _controllers['profession'],
                            enabled: true,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),
                    InputField(
                      label: "Date of birth",
                      controller: _controllers['date_of_birth'],
                      enabled: true,
                    ),
                    const SizedBox(height: 20),
                    InputField(
                      label: "Phone number",
                      controller: _controllers['phone_num'],
                      enabled: true,
                    ),
                    const SizedBox(height: 20),
                    InputField(
                      label: "Address",
                      controller: _controllers['address'],
                      enabled: true,
                    ),
                    const SizedBox(height: 100),
                    ElevatedButton(
                      onPressed: _saveChanges,
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
    );
  }
}