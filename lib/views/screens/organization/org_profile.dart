import 'package:flutter/material.dart';
import '/views/widgets/build3DSection.dart';
import '/views/widgets/footer.dart';

import 'package:donate_application/views/screens/common/change_password.dart';
import 'package:donate_application/views/screens/common/term_and_policies.dart';
import 'package:donate_application/views/screens/common/contact_us.dart';
import 'package:donate_application/views/screens/common/language.dart';
import 'package:donate_application/views/screens/common/login.dart';

import '/views/screens/organization/org_edit_profile.dart';
import '/views/screens/organization/org_post.dart';
import '/views/screens/organization/org_profile_detail.dart';

class OrgProfilePage extends StatelessWidget {
  const OrgProfilePage({super.key});
  static const pageRoute = '/org_settings';
  
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: GradientHeader(
        gradientStartColor: Color(0xFF0E1B48), // Start color
        gradientEndColor: Color(0xFF87A7D0),   // End color
        child: OrgProfileContent(),
      ),
      bottomNavigationBar: Footer(),
    );
  }
}

class OrgProfileContent extends StatelessWidget {
  const OrgProfileContent({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
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
        Expanded(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                children: [
                  build3DSection(
                    children: [
                      ProfileActionButton(
                        icon: Icons.info,
                        text: "Information details",
                        onTap: () {
                          Navigator.pushNamed(context, OrgProfileDetailsScreen.pageRoute);
                        },
                      ),
                      ProfileActionButton(
                        icon: Icons.edit,
                        text: "Edit profile information",
                        onTap: () {
                          Navigator.pushNamed(context, EditOrgProfileScreen.pageRoute);
                        },
                      ),
                      ProfileActionButton(
                        icon: Icons.post_add,
                        text: "My posts",
                        onTap: () {
                          Navigator.pushNamed(context, OrgPostsScreen.pageRoute);
                        },
                      ),
                    ],
                  ),
                  const SizedBox(height: 30),
                  build3DSection(
                    children: [
                      ProfileActionButton(
                        icon: Icons.language,
                        text: "Language",
                        trailing: const Text(
                          "English",
                          style: TextStyle(color: Colors.blue),
                        ),
                        onTap: () {
                          Navigator.pushNamed(context, LanguageSelectionScreen.pageRoute);
                        },
                      ),
                      ProfileActionButton(
                        icon: Icons.contact_support,
                        text: "Contact us",
                        onTap: () {
                          Navigator.pushNamed(context, ContactUsScreen.pageRoute);
                        },
                      ),
                      ProfileActionButton(
                        icon: Icons.policy,
                        text: "Terms and Policies",
                        onTap: () {
                          Navigator.pushNamed(context, TermsAndPoliciesScreen.pageRoute);
                        },
                      ),
                    ],
                  ),
                  const SizedBox(height: 30),
                  build3DSection(
                    children: [
                      ProfileActionButton(
                        icon: Icons.password,
                        text: "Change password",
                        onTap: () {
                          Navigator.pushNamed(context, ChangePasswordApp.pageRoute);
                        },
                      ),
                      ProfileActionButton(
                        icon: Icons.logout,
                        text: "Log out",
                        onTap: () {
                          Navigator.pushNamed(context, LoginPage.pageRoute); // Example for logging out
                        },
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
  final VoidCallback onTap;

  const ProfileActionButton({
    super.key,
    required this.icon,
    required this.text,
    this.trailing,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Padding(
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
      ),
    );
  }
}

class GradientHeader extends StatelessWidget {
  final Color gradientStartColor;
  final Color gradientEndColor;
  final Widget child;

  const GradientHeader({
    super.key,
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
            CustomPaint(
              size: const Size(double.infinity, 250),
              painter: GradientHeaderPainter(
                gradientStartColor: gradientStartColor,
                gradientEndColor: gradientEndColor,
              ),
            ),
            Expanded(
              child: Container(color: Colors.white),
            ),
          ],
        ),
        Positioned(
          top: 180,
          left: MediaQuery.of(context).size.width / 2 - 50,
          child: const CircleAvatar(
            radius: 50,
            backgroundImage: AssetImage('assets/images/org_profile.jpg'),
          ),
        ),
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
        stops: const [0.0, 0.8],
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
