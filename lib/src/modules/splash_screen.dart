import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:mawad/src/modules/main.page.dart';
import 'package:mawad/src/presentation/routes/app_routes.dart';
import 'package:mawad/src/presentation/sharedwidgets/button/app_button.dart';

import '../presentation/theme/app_color.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColorTheme.white,
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: ClipPath(
                clipper: CustomClipPath(),
                child: Container(
                  color: AppColorTheme.yellow,
                  child: Center(
                    child: SvgPicture.asset('assets/svg/splash.svg'),
                  ),
                ),
              ),
            ),
            Expanded(
              child: Container(
                width: Get.width,
                color: Colors.white,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const SizedBox(height: 16),
                    const Text(
                      'All the materials you need \nYour home right in one place!',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.normal,
                        color: Colors.black,
                      ),
                    ),
                    const SizedBox(height: 35),
                    AppButton(
                      color: AppColorTheme.yellow,
                      radius: 20,
                      width: Get.width * 0.8,
                      onPressed: () {
                        Get.to(const MainPage());
                      },
                      text: 'Get Started',
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class CustomClipPath extends CustomClipper<Path> {
  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return false;
  }

  @override
  Path getClip(Size size) {
    double width = size.width;
    double height = size.height;

    final path = Path();

    path.lineTo(0, height); // Start from the bottom-left corner

    // Use negative value for the control point to make the curve outside
    path.quadraticBezierTo(width * 0.5, height - 100, width, height);

    path.lineTo(width, 0); // Draw a line to the top-right corner

    path.lineTo(0, 0); // Draw a line to the top-left corner

    path.close(); // Close the path

    return path;
  }
}

Widget _buildCircleImage(Color color, double fraction) {
  double circleSize = Get.size.width * fraction;

  return Container(
    width: circleSize,
    height: circleSize,
    decoration: BoxDecoration(
      color: color,
      shape: BoxShape.circle,
    ),
  );
}
