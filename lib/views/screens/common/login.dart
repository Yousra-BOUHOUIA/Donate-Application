
import 'package:donate_application/shared_preference/shared_prefs.dart';
import 'package:donate_application/views/screens/organization/org_homepage.dart';
import 'package:donate_application/views/screens/organization/signup_as_organization.dart';
import 'package:donate_application/views/screens/user/user_homepage.dart';
import 'package:flutter/material.dart';
import 'package:donate_application/databases/tables/organization.dart';
import 'package:donate_application/databases/tables/participant.dart';
import '../../../themes/colors.dart';
import 'package:donate_application/bloc/login_cubit.dart'; 

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});
  static const String pageRoute = '/login';

  @override
  Widget build(BuildContext context) {

    final LoginCubit loginCubit = LoginCubit(); 
    final TextEditingController emailController = TextEditingController();
    final TextEditingController passwordController = TextEditingController();
    final DBOrganizationTable organizationTable = DBOrganizationTable();
    final DBParticipantTable participantTable = DBParticipantTable();

    void showMessage(BuildContext context, String message, {bool isSuccess = false}) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(message),
          backgroundColor: isSuccess ? const Color.fromARGB(255, 110, 174, 113) : const Color.fromARGB(255, 230, 125, 118),
        ),
      );
    }

    Future<void>  handleLogin() async {
      String email = emailController.text.trim();
      String password = passwordController.text.trim();

      if (email.isEmpty || password.isEmpty) {
        showMessage(context, "Please enter both email and password.");
        return;
      }

      try {

        var org = await organizationTable.getRecord("email", email);
        if (org != null && org['password'] == password) {
          await UserPreferences.saveUserEmail(email.trim());
          Navigator.pushReplacement(
            // ignore: use_build_context_synchronously
            context,
            MaterialPageRoute(builder: (context) => const OrgHomePage()),
          );
          return;
        }
        print(email);
        print(password);
        var participant = await participantTable.getRecordByEmail(email);
        print(participant);
        if (participant != null && participant['password'] == password) {
          await UserPreferences.saveUserEmail(email.trim());
          Navigator.pushReplacement(
            // ignore: use_build_context_synchronously
            context,
            MaterialPageRoute(builder: (context) => const UserHomePage()),
          );
          return;
        }

        // ignore: use_build_context_synchronously
        showMessage(context, "Invalid email or password.");
      } catch (e) {
        // ignore: use_build_context_synchronously
        showMessage(context, "An error occurred: $e");
      }
    }

    return Scaffold(
      backgroundColor: appBackgroundColor,
      body: Stack(
        children: [
          Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  formGradientStart,
                  formGradientEnd,
                ],
                stops: [0.29, 0.98],
              ),
            ),
          ),

          ClipPath(
            clipper: WaveClipper(),
            child: Container(
              height: 300,
              color: backgroundColor,
            ),
          ),


Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Center(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      'Login',
                      style: TextStyle(
                        fontSize: 32,
                        fontWeight: FontWeight.bold,
                        color: textColor,
                      ),
                    ),
                    const SizedBox(height: 40),
                    TextField(
                      controller: emailController,
                      decoration: const InputDecoration(
                        prefixIcon: Icon(Icons.email, color: primaryColor),
                        labelText: 'Email',
                        labelStyle: TextStyle(color: labelColor),
                        border: UnderlineInputBorder(),
                      ),
                    ),
                    const SizedBox(height: 20),
                    StreamBuilder<bool>(
                      stream: loginCubit.obscurePasswordStream,
                      initialData: true,
                      builder: (context, snapshot) {
                        bool obscureText = snapshot.data ?? true;
                        return TextField(
                          controller: passwordController,
                          obscureText: obscureText,
                          decoration: InputDecoration(
                            prefixIcon: const Icon(Icons.lock, color: primaryColor),
                            labelText: 'Password',
                            labelStyle: const TextStyle(color: labelColor),
                            border: const UnderlineInputBorder(),
                            suffixIcon: IconButton(
                              icon: Icon(
                                obscureText ? Icons.visibility_off : Icons.visibility,
                                color: primaryColor,
                              ),
                              onPressed: () {
                                loginCubit.togglePasswordVisibility();
                              },
                            ),
                          ),
                        );
                      },
                    ),


const SizedBox(height: 10),
                    StreamBuilder<bool>(
                      stream: loginCubit.rememberMeStream,
                      initialData: false,
                      builder: (context, snapshot) {
                        return Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                Checkbox(
                                  value: snapshot.data,
                                  onChanged: (value) {
                                    loginCubit.rememberMeSink.add(value!);
                                  },
                                  activeColor: primaryColor,
                                ),
                                const Text(
                                  'Remember me',
                                  style: TextStyle(color: labelColor),
                                ),
                              ],
                            ),
                            TextButton(
                              onPressed: () {},
                              child: const Text(
                                'Forgot password?',
                                style: TextStyle(color: labelColor),
                              ),
                            ),
                          ],
                        );
                      },
                    ),
                    const SizedBox(height: 20),
                    ElevatedButton(
                      onPressed: handleLogin,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: buttonColor,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                        padding: const EdgeInsets.symmetric(
                            vertical: 15, horizontal: 80),
                      ),
                      child: const Text(
                        'LOGIN',
                        style: TextStyle(
                          color: buttonTextColor,
                          fontSize: 16,
                        ),
                      ),
                    ),
                    const SizedBox(height: 30),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                          "Don't have an account?",
                          style: TextStyle(color: textColor),
                        ),
                        TextButton(
                          onPressed: () {
                            Navigator.pushReplacementNamed(
                                context, '/signup_as_user');
                          },
                          child: const Text(
                            'Sign Up',
                            style: TextStyle(
                              color: primaryColor,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}