import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import '../../../databases/tables/user_donation.dart';  // Import the donation table database class
import '../../widgets/build3DDropdown.dart';
import '../../widgets/build3DTextField.dart';
import 'dart:io';
import '../../../themes/colors.dart';
import '../../widgets/footer.dart';

class AddDonationScreen extends StatefulWidget {
  const AddDonationScreen({super.key});
  static const String pageRoute = 'add_donation';

  @override
  State<AddDonationScreen> createState() => _AddDonationScreenState();
}

class _AddDonationScreenState extends State<AddDonationScreen> {
  final DBUser_donationTable _DBUser_donationTable = DBUser_donationTable();
  final ImagePicker _picker = ImagePicker();
  final _formKey = GlobalKey<FormState>();
  final _contactController = TextEditingController();
  final _itemNameController = TextEditingController();
  final _userNameController = TextEditingController();
  final _locationController = TextEditingController();

  String? _selectedColor;
  String? _selectedCondition;
  File? _selectedImage;
  String? _imageErrorMessage;

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

  void _resetForm() {
    setState(() {
      _selectedImage = null;
      _itemNameController.clear();
      _contactController.clear();
      _userNameController.clear();
      _locationController.clear();
      _selectedColor = null;
      _selectedCondition = null;
      _imageErrorMessage = null;  // Clear image error message
    });
    _formKey.currentState?.reset();
    print("Form has been reset!");
  }

  bool _validateContact(String value) {
    final emailRegex = RegExp(r"^[a-zA-Z0-9.]+@[a-zA-Z0-9]+\.[a-zA-Z]+");
    final phoneRegex = RegExp(r"^\d{10,15}$");
    return emailRegex.hasMatch(value) || phoneRegex.hasMatch(value);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: appBackgroundColor,
      appBar: AppBar(
        backgroundColor: appBarColor,
        elevation: 0,
        title: const Text(
          'Add Donation',
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
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              GestureDetector(
                onTap: _pickImage,
                child: Container(
                  height: 200,
                  width: 80,
                  decoration: BoxDecoration(
                    color: Colors.grey[300],
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.5),
                        spreadRadius: 2,
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
                          ): const Column(
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
           
              build3DTextField(
                'Item name',
                controller: _itemNameController,
              ),
              const SizedBox(height: 25),
              Row(
                children: [
                  Expanded(
                    child: build3DDropdown(
                      'Color',
                      ['black', 'white', 'grey', 'brown'],
                      (value) => _selectedColor = value,
                    ),
                  ),
                  const SizedBox(width: 25),
                  Expanded(
                    child: build3DDropdown(
                      'Condition',
                      ['New', 'Used'],
                      (value) => _selectedCondition = value,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 25),
              build3DTextField(
                'Username',
                controller: _userNameController,
              ),
              const SizedBox(height: 25),
              build3DTextField(
                'Contact',
                controller: _contactController,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Contact is required';
                  } else if (!_validateContact(value)) {
                    return 'Enter a valid email or phone number';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 25),
              build3DTextField(
                'Location',
                controller: _locationController,
              ),
              const SizedBox(height: 40),
              Center(
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: appButtonColor,
                    padding: const EdgeInsets.symmetric(
                        horizontal: 60, vertical: 15),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(25),
                    ),
                  ),
                  onPressed: () async {
                    if (_formKey.currentState!.validate()) {
                      // Ensure an image is selected
                      if (_selectedImage == null) {
                        setState(() {
                          _imageErrorMessage = 'Image is required';
                        });
                        return;
                      }

                      final String itemName = _itemNameController.text;
                      final String contact = _contactController.text;
                      final String location = _locationController.text;
                      final String? selectedColor = _selectedColor;
                      final String? selectedCondition = _selectedCondition;
                      final String slectedusername = _userNameController.text;

                      final donationData = {
                        'image': await _selectedImage!.readAsBytes(),
                        'title': itemName,
                        'color': selectedColor,
                        'condition': selectedCondition,
                        'contact': contact,
                        'location': location,
                        'username': slectedusername,
                      };
                      print("Preparing to insert user data into the database...");

                      int isInserted = await _DBUser_donationTable.insertRecord(donationData);

                      if (isInserted > 0) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('Donation added successfully!')),
                        );
                        _resetForm();
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('Failed to add donation')),
                        );
                      }
                    }
                  },
                  child: const Text(
                    'ADD',
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: const Footer(isOrganization: false),
    );
  }
}
