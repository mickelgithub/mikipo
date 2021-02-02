import 'package:flutter/material.dart';
import 'package:mikipo/src/ui/common/colors.dart';
import 'package:mikipo/src/ui/login/login_screen.dart';
import 'package:mikipo/src/util/constants/image_constants.dart';
import 'package:mikipo/src/util/log/simple_log_printer.dart';

class LoginFooterWidget extends StatelessWidget {

  static final _logger= getLogger((LoginFooterWidget).toString());

  static final double FOOTER_HEIGHT = 100.0;
  static final double FOOTER_WIDTH = 200.0;

  const LoginFooterWidget();

  @override
  Widget build(BuildContext context) {
    _logger.d('build...');
    final size= MediaQuery.of(context).size;
    double height= size.height * HEADER_HEIGHT_FACTOR / 2;
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
                  child: Image.network(
                    ImageConstants.LOGO_LDA_URL,
                    height: FOOTER_HEIGHT,
                    width: FOOTER_WIDTH,
                  ),
                ),
              ),
              Positioned(
                bottom: 70,
                left: 20,
                child: Container(
                  child: Image.network(
                    ImageConstants.LOGO_PENELOPE_URL,
                    height: 50,
                    width: 100,
                  ),
                ),
              ),
              Positioned(
                bottom: 70,
                right: 20,
                child: Container(
                  child: Image.network(
                    ImageConstants.LOGO_APRECIO_URL,
                    height: 50,
                    width: 100,
                  ),
                ),
              ),
              Positioned(
                bottom: 60,
                left: (size.width - 210) / 2,
                child: Container(
                  child: Image.network(
                    ImageConstants.LOGO_VIVAZ_URL,
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
