import 'package:flutter/material.dart';
import 'package:mikipo/src/ui/common/colors.dart';

class LoginHeader extends StatelessWidget {
  final double height;

  const LoginHeader({this.height});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    double topBackHeight = height;
    return Positioned(
      top: 0,
      left: 0,
      right: 0,
      height: topBackHeight,
      child: Stack(
        children: [
          Padding(
            padding: EdgeInsets.all(16.0),
            child: Image.asset(
              'assets/images/teamwork.png',
              fit: BoxFit.contain,
            ),
          ),
          Container(
            height: topBackHeight,
            width: size.width,
            decoration: BoxDecoration(
              color: Palette.penelopeColor.withOpacity(0.3),
            ),
          ),
        ],
      ),
    );
  }
}
