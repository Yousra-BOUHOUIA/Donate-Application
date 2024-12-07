import 'package:flutter/material.dart';
import '../../themes/colors.dart';

void main() {
  runApp(const GradientHeaderApp());
}

class GradientHeaderApp extends StatelessWidget {
  const GradientHeaderApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: GradientHeader(
          gradientStartColor: topGradientStart,
          gradientEndColor: topGradientEnd,
          child: Center(),
        ),
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
        CustomPaint(
          size: const Size(double.infinity, 250),
          painter: GradientHeaderPainter(
            gradientStartColor: gradientStartColor,
            gradientEndColor: gradientEndColor,
          ),
        ),
        Positioned(
          top: 40,
          left: 16,
          child: IconButton(
            icon: const Icon(Icons.arrow_back, color: topBarColor),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ),
        Positioned.fill(
          top: 250,
          child: child,
        ),
      ],
    );
  }
}

/// GradientHeaderPainter Class
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
        stops: const [
          0.0,
          0.8
        ], // First color takes 30%, second color takes 70%
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
