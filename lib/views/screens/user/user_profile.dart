import 'package:flutter/material.dart';
import 'package:donate_application/views/widgets/build3DSection.dart';
import 'package:donate_application/views/widgets/footer.dart';
class UserProfilePage extends StatelessWidget {
  const UserProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: GradientHeader(
          gradientStartColor: Color(0xFF0E1B48), // Start color
          gradientEndColor: Color(0xFF87A7D0),   // End color
          child: UserProfileContent(),
        ),
        bottomNavigationBar: Footer(), // Added Footer here
      ),
    );
  }
}

class UserProfileContent extends StatelessWidget {
  const UserProfileContent({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Spacing to align content below the profile picture
        const SizedBox(height: 10),
        const Text(
          "Full Name",
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        const Text(
          "youremail@domain.com",
          style: TextStyle(fontSize: 14, color: Colors.grey),
        ),
        const SizedBox(height: 20),
        // Action Buttons Section
        Expanded(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                children: [
                  // Section for Information details, Edit profile information, My posts
                  build3DSection(
                    children: [
                      const ProfileActionButton(
                        icon: Icons.info,
                        text: "Information details",
                      ),
                      const ProfileActionButton(
                        icon: Icons.edit,
                        text: "Edit profile information",
                      ),
                      const ProfileActionButton(
                        icon: Icons.post_add,
                        text: "My posts",
                      ),
                    ],
                  ),
                  //const Divider(height: 30),
                  const SizedBox(height: 30,),
                  // Section for Language, Contact us, Terms and Policies
                  build3DSection(
                    children: [
                      const ProfileActionButton(
                        icon: Icons.language,
                        text: "Language",
                        // ignore: prefer_const_constructors
                        trailing: Text(
                          "English",
                          style: TextStyle(color: Colors.blue),),
                      ),
                      const ProfileActionButton(
                        icon: Icons.contact_support,
                        text: "Contact us",
                      ),
                      const ProfileActionButton(
                        icon: Icons.policy,
                        text: "Terms and Policies",
                      ),
                    ],
                  ),
                  //const Divider(height: 30),
                  const SizedBox(height: 30,),
                  // Section for Change password and Log out
                  build3DSection(
                    children: [
                      const ProfileActionButton(
                        icon: Icons.password,
                        text: "Change password",
                      ),
                      const ProfileActionButton(
                        icon: Icons.logout,
                        text: "Log out",
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }

  
}

class ProfileActionButton extends StatelessWidget {
  final IconData icon;
  final String text;
  final Widget? trailing;

  const ProfileActionButton({super.key, 
    required this.icon,
    required this.text,
    this.trailing,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        children: [
          Icon(icon, color: Colors.black),
          const SizedBox(width: 16),
          Expanded(
            child: Text(
              text,
              style: const TextStyle(fontSize: 16),
            ),
          ),
          if (trailing != null) trailing!,
        ],
      ),
    );
  }
}




class GradientHeader extends StatelessWidget {
  final Color gradientStartColor;
  final Color gradientEndColor;
  final Widget child;

  const GradientHeader({super.key, 
    required this.gradientStartColor,
    required this.gradientEndColor,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Column(
          children: [
            // The custom gradient header
            CustomPaint(
              size: const Size(double.infinity, 250),
              painter: GradientHeaderPainter(
                gradientStartColor: gradientStartColor,
                gradientEndColor: gradientEndColor,
              ),
            ),
            // White background below gradient
            Expanded(
              child: Container(color: Colors.white),
            ),
          ],
        ),
        // Profile Picture Circle Positioned at the intersection
        Positioned(
          top: 180, // Adjust to fine-tune position
          left: MediaQuery.of(context).size.width / 2 - 50, // Center horizontally
          child: const CircleAvatar(
            radius: 50,
            backgroundImage: AssetImage('assets/images/user_profile.png'), // Replace with your image
          ),
        ),
        // Content Below Gradient and Profile Picture
        Positioned.fill(
          top: 280,
          child: child,
        ),
      ],
    );
  }
}

class GradientHeaderPainter extends CustomPainter {
  final Color gradientStartColor;
  final Color gradientEndColor;

  GradientHeaderPainter({
    required this.gradientStartColor,
    required this.gradientEndColor,
  });

  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()
      ..shader = LinearGradient(
        colors: [gradientStartColor, gradientEndColor],
        stops: const [0.0, 0.8], // First color takes 30%, second color takes 70%
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ).createShader(Rect.fromLTWH(0, 0, size.width, size.height));

    Path path = Path();
    path.lineTo(0, size.height * 0.75);
    path.quadraticBezierTo(
      size.width * 0.5,
      size.height * 1.1,
      size.width,
      size.height * 0.75,
    );
    path.lineTo(size.width, 0);
    path.close();

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}
