import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../themes/colors.dart';
import '../../../bloc/PasswordVisibility_cubit.dart'; 

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});
  static const String pageRoute = '/login';

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool rememberMe = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: appBackgroundColor,
      body: Stack(
        children: [
          // Gradient background
          Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  formGradientStart, 
                  formGradientEnd,  
                ],
                stops: [
                  0.29,
                  0.98, 
                ],
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
                    // Email input field
                    const TextField(
                      decoration: InputDecoration(
                        prefixIcon: Icon(Icons.email, color: primaryColor),
                        labelText: 'Email',
                        labelStyle: TextStyle(color: labelColor),
                        border: UnderlineInputBorder(),
                      ),
                    ),
                    const SizedBox(height: 20),

                    BlocProvider(
                      create: (_) => PasswordVisibilityCubit(),
                      child: BlocConsumer<PasswordVisibilityCubit, bool>(
                        listener: (context, state) {},
                        builder: (context, obscurePassword) {
                          return TextField(
                            obscureText: obscurePassword,
                            decoration: InputDecoration(
                              prefixIcon: const Icon(Icons.lock, color: primaryColor),
                              labelText: 'Password',
                              labelStyle: const TextStyle(color: labelColor),
                              border: const UnderlineInputBorder(),
                              suffixIcon: IconButton(
                                icon: Icon(
                                  obscurePassword ? Icons.visibility_off : Icons.visibility,
                                  color: primaryColor,
                                ),
                                onPressed: () {

                                  context.read<PasswordVisibilityCubit>().togglePasswordVisibility();
                                },
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                    const SizedBox(height: 10),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Checkbox(
                              value: rememberMe,
                              onChanged: (value) {
                                setState(() {
                                  rememberMe = value!;
                                });
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
                    ),
                    const SizedBox(height: 20),

                    ElevatedButton(
                      onPressed: () {},
                      style: ElevatedButton.styleFrom(
                        backgroundColor: buttonColor, // Button color
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                        padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 80),
                      ),
                      child: const Text(
                        'LOGIN',
                        style: TextStyle(color: buttonTextColor, fontSize: 16), 
                      ),
                    ),
                    const SizedBox(height: 30),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                          "Don't have an account ?",
                          style: TextStyle(color: textColor),
                        ),
                        TextButton(
                          onPressed: () {
                            Navigator.pushReplacementNamed(context, '/signup_as_user');
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

class WaveClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    var path = Path();
    path.lineTo(0, size.height * 0.6); 

    var firstControlPoint = Offset(size.width * 0.2, size.height * 0.2); 
    var firstEndPoint = Offset(size.width * 0.5, size.height * 0.3); 
    path.quadraticBezierTo(
        firstControlPoint.dx, firstControlPoint.dy, firstEndPoint.dx, firstEndPoint.dy);

    var secondControlPoint = Offset(size.width * 0.8, size.height * 0.4); 
    var secondEndPoint = Offset(size.width, 0); 
    path.quadraticBezierTo(
        secondControlPoint.dx, secondControlPoint.dy, secondEndPoint.dx, secondEndPoint.dy);

    path.lineTo(size.width, 0); 
    path.lineTo(0, 0);
    path.close();

    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) => false;
}
