import 'package:flutter/material.dart';
import '../../themes/colors.dart';



class SimpleGradientApp extends StatelessWidget {
  const SimpleGradientApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: GradientPage(
        gradientStartColor: topGradientStart,
        gradientEndColor: topGradientEnd,
        pageTitle: "All",
        child: Center(
          
        ),
      ),
    );
  }
}

/// GradientPage Widget
class GradientPage extends StatelessWidget {
  final Color gradientStartColor;
  final Color gradientEndColor;
  final String pageTitle;
  final Widget child;

  const GradientPage({super.key, 
    required this.gradientStartColor,
    required this.gradientEndColor,
    required this.pageTitle,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [gradientStartColor, gradientEndColor],
            stops: const [
              0.0,
              0.3
            ], // First color will take 30%, second will take 70%
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 40, left: 16, right: 16),
              child: Row(
                children: [
                  IconButton(
                    icon: const Icon(Icons.arrow_back, color: topBarColor),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  ),
                  Expanded(
                    child: Text(
                      pageTitle,
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        color: topBarColor,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  const SizedBox(width: 48),
                ],
              ),
            ),
            Expanded(
              child: child,
            ),
          ],
        ),
      ),
    );
  }
}
