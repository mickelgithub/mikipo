import 'package:flutter/material.dart';
import 'package:mikipo/src/ui/common/colors.dart';

class LoginFooter extends StatelessWidget {

  final double FOOTER_HEIGHT = 100.0;
  final double FOOTER_WIDTH = 200.0;

  final double height;

  const LoginFooter({this.height});

  @override
  Widget build(BuildContext context) {
    Widget _buildFooter(Size size) {
      return Positioned(
        bottom: 0,
        left: 0,
        right: 0,
        child: Container(
          height: height,
          width: size.width,
          child: Stack(
            children: [
              Positioned(
                bottom: 0,
                left: 0,
                right: 0,
                child: Center(
                  child: Image.asset(
                    'assets/images/logo_lda.png',
                    height: FOOTER_HEIGHT,
                    width: FOOTER_WIDTH,
                  ),
                ),
              ),
              Positioned(
                bottom: 70,
                left: 20,
                child: Container(
                  child: Image.asset(
                    'assets/images/logo_penelope.gif',
                    height: 50,
                    width: 100,
                  ),
                ),
              ),
              Positioned(
                bottom: 70,
                right: 20,
                child: Container(
                  child: Image.asset(
                    'assets/images/logo_aprecio.png',
                    height: 50,
                    width: 100,
                  ),
                ),
              ),
              Positioned(
                bottom: 60,
                left: (size.width - 210) / 2,
                child: Container(
                  child: Image.asset(
                    'assets/images/logo_vivaz.png',
                    height: 70,
                    width: 210,
                  ),
                ),
              ),
              Positioned(
                bottom: 0,
                left: 0,
                right: 0,
                child: Container(
                  height: height,
                  decoration: BoxDecoration(
                    color: Palette.white.withOpacity(0.6),
                  ),
                ),
              )
            ],
          ),
        ),
      );
    }
  }
}
