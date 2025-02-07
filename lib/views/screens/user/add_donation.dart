import 'dart:typed_data';

import 'package:donate_application/bloc/add_donation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import '../../../databases/tables/user_donation.dart';  // Import the donation table database class
import '../../widgets/build3DDropdown.dart';
import '../../widgets/build3DTextField.dart';
import 'package:image/image.dart' as img;
import 'dart:io';
import '../../../themes/colors.dart';
import '../../widgets/footer.dart';

class AddDonationScreen extends StatefulWidget {
  const AddDonationScreen({super.key});
  static const String pageRoute = 'add_donation';

  @override
  _AddDonationScreenState createState() => _AddDonationScreenState();
}

class _AddDonationScreenState extends State<AddDonationScreen> {
  final _formKey = GlobalKey<FormState>();
  final _contactController = TextEditingController();
  final _itemNameController = TextEditingController();
  final _userNameController = TextEditingController();
  final _locationController = TextEditingController();
  XFile? _selectedImage;
  final ImagePicker _picker = ImagePicker();
  bool _isLoading = false;  // Add a loading state variable

  Future<void> _pickImage() async {
    final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      setState(() {
        _selectedImage = image;
      });
    }
  }

  Future<Uint8List> compressImage(File file) async {
    final bytes = await file.readAsBytes();
    final image = img.decodeImage(bytes)!;
    final compressed = img.encodeJpg(image, quality: 50); // Reduce quality
    return Uint8List.fromList(compressed);
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
          child: BlocBuilder<AddDonationCubit, AddDonationState>(
            builder: (context, state) {
              final cubit = context.read<AddDonationCubit>();

              return Column(
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
                          ['black', 'white', 'grey', 'brown'],
                          (value) => cubit.setSelectedColor(value),
                        ),
                      ),
                      const SizedBox(width: 25),
                      Expanded(
                        child: build3DDropdown(
                          'Condition',
                          ['New', 'Used'],
                          (value) => cubit.setSelectedCondition(value),
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
                      onPressed: _isLoading
                          ? null  // Disable button while loading
                          : () async {
                              setState(() {
                                _isLoading = true;  // Set loading state to true
                              });

                              if (_formKey.currentState!.validate()) {
                                final String itemName = _itemNameController.text;
                                final String contact = _contactController.text;
                                final String username = _userNameController.text;
                                final String location = _locationController.text;
                                final String? selectedColor = cubit.selectedColor;
                                final String? selectedCondition = cubit.selectedCondition;

                                Uint8List compressedImage = await compressImage(File(_selectedImage!.path));
                                final donationData = {
                                  'image': compressedImage,
                                  'title': itemName,
                                  'color': selectedColor,
                                  'condition': selectedCondition,
                                  'contact': contact,
                                  'location': location,
                                  'username': username,
                                };

                                final dbTable = DBUser_donationTable();
                                int isInserted = await dbTable.insertRecord(donationData);

                                setState(() {
                                  _isLoading = false;  // Set loading state back to false
                                });

                                if (isInserted > 0) {
                                  cubit.resetForm();
                                  Navigator.pop(context); 
                                } else {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(content: Text('Failed to add donation')),
                                  );
                                }
                              }
                            },
                      child: _isLoading
                          ? const CircularProgressIndicator(
                              valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                            )
                          : const Text(
                              'ADD',
                              style: TextStyle(
                                color: Colors.white,
                              ),
                            ),
                    ),
                  ),
                ],
              );
            },
          ),
        ),
      ),
      bottomNavigationBar: const Footer(isOrganization: false),
    );
  }
}
