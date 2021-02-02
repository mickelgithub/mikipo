import 'package:flutter/material.dart';
import 'package:mikipo/src/ui/common/colors.dart';
import 'package:mikipo/src/util/log/simple_log_printer.dart';

class SplashScreen extends StatelessWidget {

  static final _logger= getLogger((SplashScreen).toString());

  static const _SPLASH_IMAGE_WIDTH= 100.0;
  static const _SPLASH_IMAGE_HEIGHT= 100.0;

  const SplashScreen();

  @override
  Widget build(BuildContext context) {
    _logger.d('build...');
    return Scaffold(
      backgroundColor: Palette.white,
      body: Center(
          child: _body(),
        ),
      );
  }

  Widget _body() {
    return Image.asset('assets/images/team.png',
    width: _SPLASH_IMAGE_WIDTH,
    height: _SPLASH_IMAGE_HEIGHT,);
  }

}
