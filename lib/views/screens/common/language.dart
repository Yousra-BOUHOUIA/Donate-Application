import 'package:donate_application/themes/colors.dart';
import 'package:flutter/material.dart';

class LanguageSelectionScreen extends StatelessWidget {
  final String selectedLanguage = "Arabic"; // Example of selected language

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: appBarColor,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: const Text("Language", style: TextStyle(color: Colors.black)),
        centerTitle: true,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.all(16.0),
            child: Text(
              "Suggested",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
          ),
          _buildLanguageTile("English (US)", selectedLanguage == "English (US)"),
          _buildLanguageTile("Arabic", selectedLanguage == "Arabic"),
        ],
      ),
    );
  }

  Widget _buildLanguageTile(String language, bool isSelected) {
    return ListTile(
      title: Text(language, style: const TextStyle(fontSize: 16)),
      trailing: Radio(
        value: language,
        groupValue: isSelected ? language : null,
        onChanged: (value) {},
        activeColor: Colors.blue,
      ),
      onTap: () {
        // Handle language selection
      },
    );
  }
}
