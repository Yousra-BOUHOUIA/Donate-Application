import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import '/views/widgets/build3DDropdown.dart';
import '/views/widgets/build3DTextField.dart';
import 'dart:io';
import '/themes/colors.dart';
import '/views/widgets/footer.dart';




class AddDonationScreen extends StatefulWidget {
  const AddDonationScreen({super.key});

  @override
  State<AddDonationScreen> createState() => _AddDonationScreenState();
}

class _AddDonationScreenState extends State<AddDonationScreen> {
  final ImagePicker _picker = ImagePicker();
  final _formKey = GlobalKey<FormState>();
  final _contactController = TextEditingController();
  final _itemNameController = TextEditingController();
  final _userNameController = TextEditingController();
  final _locationController = TextEditingController();

  // ignore: unused_field
  String? _selectedColor;
  // ignore: unused_field
  String? _selectedCondition;
  XFile? _selectedImage;

  Future<void> _pickImage() async {
    final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
    setState(() {
      _selectedImage = image;
    });
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
    });
    _formKey.currentState?.reset();
  }

  bool _validateContact(String value) {
    // Regular expressions for email and phone validation
    final emailRegex = RegExp(r"^[a-zA-Z0-9.]+@[a-zA-Z0-9]+\.[a-zA-Z]+");
    final phoneRegex = RegExp(r"^\d{10,15}$");

    return emailRegex.hasMatch(value) || phoneRegex.hasMatch(value);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: appBackgroundColor,
      appBar: AppBar(
        backgroundColor:appBarColor,
        elevation: 0,
        title: const Text(
          'Add Donation',
          style: TextStyle(color: Colors.black),
        ),
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () {},
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
                  child: _selectedImage == null
                      ? const Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.image, size: 50, color: Colors.grey),
                            SizedBox(height: 10),
                            Text(
                              'Upload pictures',
                              style: TextStyle(color: Colors.grey),
                            ),
                          ],
                        )
                      : Image.file(
                          File(_selectedImage!.path),
                          fit: BoxFit.cover,
                        ),
                ),
              ),
              const SizedBox(height: 25),
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
                      ['black', 'white', 'grey','brown'],
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
                'User name',
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
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      // Logic to save data goes here (e.g., send to a database).
                      _resetForm(); // Reset form for now
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Form submitted')),
                      );
                    }
                  },
                  child: const Text(
                       'ADD',
                        style: TextStyle(
                            color: Colors.white, // Use Colors.white for white color
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
