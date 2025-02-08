import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:donate_application/bloc/language_cubit.dart';
import 'package:donate_application/shared_preference/shared_prefs.dart';
import '../../widgets/build3DSection.dart';
import '../../widgets/footer.dart';

import '../../../imports/common_barrel.dart';
import '../../../imports/organization_barrel.dart';

class OrgProfilePage extends StatelessWidget {
  const OrgProfilePage({super.key});
  static const String pageRoute = '/org_settings';

  @override
  Widget build(BuildContext context) {
    String languageCode = context.watch<LanguageCubit>().state.locale.languageCode;

    // Translations for different languages
    Map<String, Map<String, String>> translations = {
      "en": {
        "full_name": "Hilla Ahmer",
        "email": "Hilla Ahmer@domain.com",
        "info": "Information details",
        "edit": "Edit profile information",
        "posts": "My posts",
        "language": "Language",
        "contact": "Contact us",
        "terms": "Terms and Policies",
        "password": "Change password",
        "logout": "Log out",
      },
      "ar": {
        "full_name": " الهلال الاحمر",
        "email": "Hilla Ahmer@domain.com",
        "info": "تفاصيل المعلومات",
        "edit": "تحرير معلومات الملف الشخصي",
        "posts": "منشوراتي",
        "language": "اللغة",
        "contact": "اتصل بنا",
        "terms": "الشروط والسياسات",
        "password": "تغيير كلمة المرور",
        "logout": "تسجيل الخروج",
      }
    };

    return Scaffold(
      body: GradientHeader(
        gradientStartColor: const Color(0xFF0E1B48),
        gradientEndColor: const Color(0xFF87A7D0),
        child: OrgProfileContent(translations: translations, languageCode: languageCode),
      ),
      bottomNavigationBar: const Footer(isOrganization: true),
    );
  }
}

class OrgProfileContent extends StatelessWidget {
  final Map<String, Map<String, String>> translations;
  final String languageCode;

  const OrgProfileContent({
    super.key,
    required this.translations,
    required this.languageCode,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: 10),
        Text(
          translations[languageCode]?["full_name"] ?? "Full Name",
          style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        Text(
          translations[languageCode]?["email"] ?? "youremail@domain.com",
          style: const TextStyle(fontSize: 14, color: Colors.grey),
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
                        text: translations[languageCode]?["info"] ?? "Information details",
                        onTap: () {
                          Navigator.pushNamed(context, OrgProfileDetailsScreen.pageRoute);
                        },
                      ),
                      ProfileActionButton(
                        icon: Icons.edit,
                        text: translations[languageCode]?["edit"] ?? "Edit profile information",
                        onTap: () {
                          Navigator.pushNamed(context, EditOrgProfileScreen.pageRoute);
                        },
                      ),
                      ProfileActionButton(
                        icon: Icons.post_add,
                        text: translations[languageCode]?["posts"] ?? "My posts",
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
                        text: translations[languageCode]?["language"] ?? "Language",
                        trailing: Text(
                          languageCode == "en" ? "English" : "العربية",
                          style: const TextStyle(color: Colors.blue),
                        ),
                        onTap: () {
                          Navigator.pushNamed(context, LanguageSelectionScreen.pageRoute);
                        },
                      ),
                      ProfileActionButton(
                        icon: Icons.contact_support,
                        text: translations[languageCode]?["contact"] ?? "Contact us",
                        onTap: () {
                          Navigator.pushNamed(context, ContactUsScreen.pageRoute);
                        },
                      ),
                      ProfileActionButton(
                        icon: Icons.policy,
                        text: translations[languageCode]?["terms"] ?? "Terms and Policies",
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
                        text: translations[languageCode]?["password"] ?? "Change password",
                        onTap: () {
                          MaterialPageRoute(
                            builder: (ctx) => const ChangePasswordScreen(isOrganization: true),
                          );
                        },
                      ),
                      ProfileActionButton(
                        icon: Icons.logout,
                        text: translations[languageCode]?["logout"] ?? "Log out",
                        onTap: () async {
                          Navigator.pushNamed(context, LoginPage.pageRoute);
                          await UserPreferences.clearUserEmail();
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
            Expanded(child: Container(color: Colors.white)),
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
        Positioned.fill(top: 280, child: child),
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

    Path path = Path()
      ..lineTo(0, size.height * 0.75)
      ..quadraticBezierTo(size.width * 0.5, size.height * 1.1, size.width, size.height * 0.75)
      ..lineTo(size.width, 0)
      ..close();

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
