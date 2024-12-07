import 'package:flutter/material.dart';
import '../../../themes/colors.dart';

class UserPostsScreen extends StatelessWidget {
  const UserPostsScreen({super.key});
    static const String pageRoute = '/user_post';


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
        title: const Text("My Posts", style: TextStyle(color: Colors.black)),
        centerTitle: true,
      ),
      backgroundColor: appBackgroundColor, 
      body: const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.note_alt_outlined, size: 80, color: Colors.grey),
            SizedBox(height: 10),
            Text(
              "No posts to display yet",
              style: TextStyle(color: Colors.grey, fontSize: 18),
            ),
          ],
        ),
      ),
    );
  }
}
