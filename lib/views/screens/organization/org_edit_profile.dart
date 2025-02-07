import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import '../../../databases/db_helper.dart';
import '../../../themes/colors.dart';
import '../../widgets/input_field.dart';
import '../../../databases/tables/organization.dart';

class EditOrgProfileScreen extends StatefulWidget {
  final int organizationId;

  const EditOrgProfileScreen({super.key, required this.organizationId});
  static const String pageRoute = '/org_edit_profile';

  @override
  _EditOrgProfileScreenState createState() => _EditOrgProfileScreenState();
}

class _EditOrgProfileScreenState extends State<EditOrgProfileScreen> {
  final DBOrganizationTable dbHelper = DBOrganizationTable();
  Map<String, dynamic>? organizationData;
  final Map<String, TextEditingController> _controllers = {};
  File? _imageFile;
  final ImagePicker _picker = ImagePicker();
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _fetchOrganizationData();
  }








 Future<void> checkTableStructure() async {
    final db = await DBHelper.getDatabase();
    var result = await db.rawQuery("PRAGMA table_info(organization)");
    print(result);  // Check the column names in the console
  }









  Future<void> _fetchOrganizationData() async {
    setState(() {
      _isLoading = true;
    });

    final data = await dbHelper.getRecord('organization_id', widget.organizationId);
    setState(() {
      organizationData = data;
      _initializeControllers();
      _isLoading = false;
    });
  }

  void _initializeControllers() {
    _controllers['organization_name'] = TextEditingController(text: organizationData?['organization_name']);
    _controllers['email'] = TextEditingController(text: organizationData?['email']);
    _controllers['organization_type'] = TextEditingController(text: organizationData?['organization_type']);
    _controllers['phone_num'] = TextEditingController(text: organizationData?['phone_num'].toString());
    _controllers['address'] = TextEditingController(text: organizationData?['address']);
    _controllers['bank_account'] = TextEditingController(text: organizationData?['bank_account'].toString());
    _controllers['social_media'] = TextEditingController(text: organizationData?['social_media']);
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
    setState(() {
      _isLoading = true;
    });

    String? imageBase64;
    if (_imageFile != null) {
      List<int> imageBytes = await _imageFile!.readAsBytes();
      imageBase64 = base64Encode(imageBytes);
    }

    Map<String, dynamic> updatedData = {
      'organization_name': _controllers['organization_name']?.text,
      'email': _controllers['email']?.text,
      'organization_type': _controllers['organization_type']?.text,
      'phone_num': int.tryParse(_controllers['phone_num']?.text ?? ''),
      'address': _controllers['address']?.text,
      'bank_account': int.tryParse(_controllers['bank_account']?.text ?? ''),
      'social_media': _controllers['social_media']?.text,
      'image': imageBase64 ?? organizationData?['image'], // Use existing image if no new image is picked
    };

    bool isUpdated = await dbHelper.updateRecord(updatedData, 'organization_id', widget.organizationId);
    setState(() {
      _isLoading = false;
    });

    if (isUpdated) {
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
        backgroundColor: appBarColor,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text('Edit profile', style: TextStyle(color: Colors.black)),
        centerTitle: true,
      ),
      body: _isLoading || organizationData == null
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
    : (organizationData?['image'] != null
        ? MemoryImage(organizationData!['image']) // Removed base64Decode
        : const AssetImage('assets/images/org_profile.jpg')) as ImageProvider,

                        backgroundColor: Colors.grey[200],
                      ),
                    ),
                    const SizedBox(height: 20),
                    InputField(
                      label: "Organization name",
                      controller: _controllers['organization_name'],
                      enabled: true,
                    ),
                    const SizedBox(height: 20),
                    InputField(
                      label: "Email",
                      controller: _controllers['email'],
                      enabled: true,
                    ),
                    const SizedBox(height: 20),
                    InputField(
                      label: "Type",
                      controller: _controllers['organization_type'],
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
                    const SizedBox(height: 20),
                    InputField(
                      label: "Bank Account",
                      controller: _controllers['bank_account'],
                      enabled: true,
                    ),
                    const SizedBox(height: 20),
                    const Text(
                      "Social platforms",
                      style: TextStyle(color: Colors.grey, fontSize: 15),
                    ),
                    const SizedBox(height: 10),
                    _buildSocialPlatformTile(
                      context,
                      initialText: _controllers['social_media']?.text ?? "No link provided",
                      icon: Icons.remove_circle,
                      iconColor: appButtonColor,
                      actionColor: appButtonColor,
                    ),
                    const SizedBox(height: 40),
                    ElevatedButton(
                      onPressed: _saveChanges,
                      style: ElevatedButton.styleFrom(
                        minimumSize: const Size(double.infinity, 50),
                        backgroundColor: appButtonColor,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      child: _isLoading
                          ? const CircularProgressIndicator(color: Colors.white)
                          : const Text("Save changes", style: TextStyle(fontSize: 16, color: Colors.white)),
                    ),

                  ],
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
    required Color actionColor,
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
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(horizontal: 16),
        title: Row(
          children: [
            Expanded(
              child: TextField(
                controller: _controllers['social_media'],
                style: const TextStyle(color: Colors.black, fontWeight: FontWeight.normal),
                decoration: InputDecoration(
                  border: InputBorder.none,
                  hintText: initialText,
                  hintStyle: const TextStyle(color: Colors.black),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 8),
              child: CircleAvatar(
                radius: 20,
                backgroundColor: actionColor,
                child: IconButton(
                  icon: Icon(icon, color: Colors.white),
                  onPressed: () {},
                  iconSize: 30,
                  splashRadius: 30,
                  padding: EdgeInsets.zero,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}