import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import '../../widgets/build3DTextField.dart';
import '../../widgets/build3DDropdown.dart';
import '../../../themes/colors.dart';
import '../../widgets/footer.dart';

class CreateCampaignScreen extends StatefulWidget {
  const CreateCampaignScreen({super.key});

  @override
  _CreateCampaignScreenState createState() => _CreateCampaignScreenState();
}

class _CreateCampaignScreenState extends State<CreateCampaignScreen> {
  final TextEditingController _dueDateController = TextEditingController();
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _locationController = TextEditingController();
  final TextEditingController _resourcesController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  File? _selectedImage;
  String? _selectedType;

  final List<String> campaignTypes = [
    "Fundraiser",
    "Volunteer Recruitment",
    "Awareness Campaign",
    "Donation Drive",
    "Charity Event"
  ];

  Future<void> _pickImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      setState(() {
        _selectedImage = File(pickedFile.path);
      });
    }
  }

  String? _validateDate(String? value) {
    if (value == null || value.isEmpty) {
      return "Please enter a due date";
    }
    final dateRegex = RegExp(r'^\d{4}-\d{2}-\d{2}$'); // Format: YYYY-MM-DD
    if (!dateRegex.hasMatch(value)) {
      return "Invalid date format (YYYY-MM-DD)";
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: appBarColor,
        elevation: 0,
        title: const Text(
          'Create Campaign',
          style: TextStyle(color: Colors.black),
        ),
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () {
            Navigator.pop(context); 
          },
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              GestureDetector(
                onTap: _pickImage,
                child: Container(
                  height: 200,
                  width: 80,
                  decoration: BoxDecoration(
                    color: Colors.grey[200],
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.5),
                        spreadRadius: 1,
                        blurRadius: 5,
                        offset: const Offset(0, 3),
                      ),
                    ],
                  ),
                  child: _selectedImage != null
                      ? ClipRRect(
                          borderRadius: BorderRadius.circular(20),
                          child: Image.file(
                            _selectedImage!,
                            fit: BoxFit.cover,
                          ),
                        )
                      : const Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.image, size: 50, color: Colors.grey),
                            SizedBox(height: 10),
                            Text(
                              'Upload pictures',
                              style: TextStyle(color: Colors.grey),
                            ),
                          ],
                        ),
                ),
              ),
              const SizedBox(height: 25),
              Row(
                children: [
                  Expanded(
                    child: build3DDropdown(
                      'Type',
                      campaignTypes,
                      (value) {
                        setState(() {
                          _selectedType = value!;
                        });
                      },
                    ),
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: build3DTextField(
                      'Due Date',
                      controller: _dueDateController,
                      validator: _validateDate,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 25),
              build3DTextField(
                'Title',
                controller: _titleController,
              ),
              const SizedBox(height: 25),
              build3DTextField(
                'Location',
                controller: _locationController,
              ),
              const SizedBox(height: 25),
              build3DTextField(
                'Resources Needed',
                controller: _resourcesController,
              ),
              const SizedBox(height: 25),
              build3DTextField(
                'Description',
                controller: _descriptionController,
              ),
              const SizedBox(height: 35),
              Center(
                child: SizedBox(
                  width: 150,
                  height: 50,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: appButtonColor,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(35),
                      ),
                    ),
                    onPressed: () {
                      if (_dueDateController.text.isEmpty ||
                          _selectedType == null) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('Please complete the form'),
                          ),
                        );
                        return;
                      }

                      // Reset the form
                      _dueDateController.clear();
                      _titleController.clear();
                      _locationController.clear();
                      _resourcesController.clear();
                      _descriptionController.clear();
                      setState(() {
                        _selectedImage = null;
                        _selectedType = null;
                      });
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Campaign Created!'),
                        ),
                      );
                    },
                    child: const Text(
                      'Create',
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: const Footer(isOrganization: true),
    );
  }
}
