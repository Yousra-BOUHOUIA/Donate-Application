import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import '../../widgets/build3DTextField.dart';
import '../../widgets/build3DDropdown.dart';
import '../../../themes/colors.dart';
import '../../widgets/footer.dart';
import 'package:donate_application/databases/tables/campaign.dart';

class CreateCampaignScreen extends StatefulWidget {
  const CreateCampaignScreen({super.key});

  @override
  _CreateCampaignScreenState createState() => _CreateCampaignScreenState();
}

class _CreateCampaignScreenState extends State<CreateCampaignScreen> {
  final DBCampaignTable _dbCampaignTable = DBCampaignTable();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>(); // Add form key

  final TextEditingController _dueDateController = TextEditingController();
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _locationController = TextEditingController();
  final TextEditingController _resourcesController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  File? _selectedImage;
  String? _selectedType;

  String? _imageErrorMessage; // Variable to store the image error message

  final List<String> campaignTypes = [
    "event",
    "donation"
  ];

  Future<void> _pickImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      setState(() {
        _selectedImage = File(pickedFile.path);
        _imageErrorMessage = null; // Clear error message when an image is selected
      });
    }
  }

  String? _validateDate(String? value) {
    if (value == null || value.isEmpty) {
      return "Please enter a due date";
    }
    final dateRegex = RegExp(r'^\d{2}-\d{2}-\d{4}$'); // DD-MM-YYYY format
    if (!dateRegex.hasMatch(value)) {
      return "Invalid date format (DD-MM-YYYY)";
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
          child: Form(
            key: _formKey, // Add form key
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
                if (_imageErrorMessage != null) // Show error message if there is an error
                  Padding(
                    padding: const EdgeInsets.only(top: 8.0),
                    child: Text(
                      _imageErrorMessage!,
                      style: const TextStyle(color: Colors.red, fontSize: 14),
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
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter a title';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 25),
                build3DTextField(
                  'Location',
                  controller: _locationController,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter a location';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 25),
                build3DTextField(
                  'Resources Needed',
                  controller: _resourcesController,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter resources needed';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 25),
                build3DTextField(
                  'Description',
                  controller: _descriptionController,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter a description';
                    }
                    return null;
                  },
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
                      onPressed: () async {
                        if (_formKey.currentState?.validate() ?? false) {

                          if (_selectedImage == null) {
                            setState(() {
                              _imageErrorMessage = 'Image is required';
                            });
                            return;
                          }

                          // Validate type
                          if (_selectedType == null || _selectedType!.isEmpty) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text('Please select a type'),
                              ),
                            );
                            return;
                          }

                          // Prepare campaign data
                          Map<String, dynamic> campaignData = {
                            'image': await _selectedImage!.readAsBytes(),
                            'location': _locationController.text,
                            'title': _titleController.text,
                            'type': _selectedType,
                            'resource': int.tryParse(_resourcesController.text) ?? 0,
                            'description': _descriptionController.text,
                            'campaign_date': _dueDateController.text,
                          };

                          // Insert record into database
                          final success =
                              await _dbCampaignTable.insertRecord(campaignData);

                          if (success) {
                            final allCampaigns =
                                await _dbCampaignTable.getAllRecords();
                            print("All campaigns in the database:");
                            for (var campaign in allCampaigns) {
                              print(campaign);
                            }

                            // Clear input fields and reset state
                            _dueDateController.clear();
                            _titleController.clear();
                            _locationController.clear();
                            _resourcesController.clear();
                            _descriptionController.clear();
                            setState(() {
                              _selectedImage = null;
                              _selectedType = null;
                              _imageErrorMessage = null; // Clear error message on success
                            });

                            // Show success message
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text('Campaign Created and Saved!'),
                              ),
                            );
                          } else {
                            // Show failure message
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text('Failed to create campaign.'),
                              ),
                            );
                          }
                        }
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
      ),
      bottomNavigationBar: const Footer(isOrganization: true),
    );
  }
}
