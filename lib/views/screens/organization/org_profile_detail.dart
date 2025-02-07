import 'dart:convert';
import 'dart:typed_data';
import 'package:donate_application/databases/tables/organization.dart';
import 'package:flutter/material.dart';
import '../../../themes/colors.dart';
import '../../widgets/input_field.dart';
import '../../../imports/organization_barrel.dart';


class OrgProfileDetailsScreen extends StatefulWidget {
  const OrgProfileDetailsScreen({super.key});
  static const String pageRoute = '/org_profile_details';

  @override
  _OrgProfileDetailsScreenState createState() => _OrgProfileDetailsScreenState();
}

class _OrgProfileDetailsScreenState extends State<OrgProfileDetailsScreen> {
  Map<String, dynamic>? organizationData;
  final DBOrganizationTable dbHelper = DBOrganizationTable();
  int? organizationId; // Store the fetched ID
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    _fetchOrganizationIdAndData();
  }

  Future<void> _fetchOrganizationIdAndData() async {
    // Fetch the last registered organization ID
    final lastOrg = await dbHelper.getLastRegisteredOrganization();
    setState(() {
      organizationId = lastOrg['organization_id']; // Store the fetched ID
    });

    // Fetch organization data using the fetched ID
    if (organizationId != null) {
      final data = await dbHelper.getRecord('organization_id', organizationId!);
      setState(() {
        organizationData = data;
        isLoading = false;
      });
    }
  }

  Uint8List? _getImageBytes(dynamic imageData) {
  if (imageData == null) return null;

  if (imageData is Uint8List) {
    return imageData; // Already in the correct format
  } else if (imageData is String && imageData.isNotEmpty) {
    try {
      return base64Decode(imageData);
    } catch (e) {
      return null;
    }
  }
  return null;
}


  @override
  Widget build(BuildContext context) {
    Uint8List? imageBytes = _getImageBytes(organizationData?['image']);

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
          : organizationData == null || organizationId == null
              ? const Center(child: Text("No organization data found"))
              : SingleChildScrollView(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 24),
                      Center(
                        child: Stack(
                          alignment: Alignment.bottomRight,
                          children: [
                            CircleAvatar(
                              radius: 50,
                              backgroundColor: Colors.grey[200],
                              backgroundImage: imageBytes != null
                                  ? MemoryImage(imageBytes) as ImageProvider
                                  : const AssetImage('assets/images/org_profile.jpg'),
                            ),
                            Positioned(
                              bottom: 0,
                              right: 0,
                              child: GestureDetector(
                                onTap: () {
                                  // Navigate to the edit screen with the fetched organization ID
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => EditOrgProfileScreen(organizationId: organizationId!),
                                    ),
                                  ).then((value) {
                                    if (value == true) {
                                      _fetchOrganizationIdAndData(); // Refresh data after editing
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
                      ),
                      const SizedBox(height: 16),
                      Text(
                        organizationData!['organization_name'] ?? '',
                        style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        organizationData!['email'] ?? '',
                        style: const TextStyle(fontSize: 14, color: Colors.grey),
                      ),
                      const SizedBox(height: 24),
                      _buildInputField("Organization Name", organizationData!['organization_name']),
                      _buildInputField("Email", organizationData!['email']),
                      _buildInputField("Type", organizationData!['organization_type']),
                      _buildInputField("Phone Number", organizationData!['phone_num'].toString()),
                      _buildInputField("Address", organizationData!['address']),
                      const SizedBox(height: 20),
                      _buildInputField("Bank Account", organizationData!['bank_account']?.toString() ?? 'Not available'),
                      const SizedBox(height: 20),
                      const Text("Social Platforms", style: TextStyle(color: Colors.grey, fontSize: 15)),
                      const SizedBox(height: 10),
                      _buildSocialPlatformTile(context, organizationData!['social_media'] ?? "No link provided"),
                      const SizedBox(height: 40),
                    ],
                  ),
                ),
    );
  }

  Widget _buildInputField(String label, String value, {int maxLines = 1}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        InputField(
          label: label,
          controller: TextEditingController(text: value),
          enabled: false,
          maxLines: maxLines,
          contentPadding: const EdgeInsets.symmetric(vertical: 20, horizontal: 10),
        ),
        const SizedBox(height: 20),
      ],
    );
  }

  Widget _buildSocialPlatformTile(BuildContext context, String link) {
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
        title: TextField(
          enabled: false,
          style: const TextStyle(color: Colors.black),
          decoration: InputDecoration(
            border: InputBorder.none,
            hintText: link,
            hintStyle: const TextStyle(color: Colors.black),
          ),
        ),
      ),
    );
  }
}