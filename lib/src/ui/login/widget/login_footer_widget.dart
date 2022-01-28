import 'package:flutter/material.dart';
import 'package:mikipo/src/ui/common/colors.dart';
import 'package:mikipo/src/ui/login/login_screen.dart';
import 'package:mikipo/src/util/constants/image_constants.dart';
import 'package:mikipo/src/util/log/simple_log_printer.dart';

class LoginFooterWidget extends StatelessWidget {
  static final _logger = getLogger((LoginFooterWidget).toString());

  static const double LDA_LOGO_HEIGHT = 100.0;
  static const double LDA_LOGO_WIDTH = 200.0;

  static const double PG5_LOGO_HEIGHT = 50.0;
  static const double PG5_LOGO_WIDTH = 100.0;

  static const double APRECIO_LOGO_HEIGHT = 50.0;
  static const double APRECIO_LOGO_WIDTH = 100.0;

  static const double VIVAZ_LOGO_HEIGHT = 70.0;
  static const double VIVAZ_LOGO_WIDTH = 210.0;

  final double width;
  final double height;

  const LoginFooterWidget(this.width, this.height);

  @override
  Widget build(BuildContext context) {

    _logger.d('build...LoginFooterWidget$hashCode');
    final size = MediaQuery.of(context).size;
    //double height = size.height * HEADER_HEIGHT_FACTOR / 2;
    return Container(
        height: height,
        width: width,
        child: Stack(
          children: [
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: Center(
                child: Image.network(
                  ImageConstants.LOGO_LDA_URL,
                  height: LDA_LOGO_HEIGHT,
                  width: LDA_LOGO_WIDTH,
                ),
              ),
            ),
            Positioned(
              bottom: 70,
              left: 20,
              child: Container(
                child: Image.network(
                  ImageConstants.LOGO_PENELOPE_URL,
                  height: PG5_LOGO_HEIGHT,
                  width: PG5_LOGO_WIDTH,
                ),
              ),
            ),
            Positioned(
              bottom: 70,
              right: 20,
              child: Container(
                child: Image.network(
                  ImageConstants.LOGO_APRECIO_URL,
                  height: APRECIO_LOGO_HEIGHT,
                  width: APRECIO_LOGO_WIDTH,
                ),
              ),
            ),
            Positioned(
              bottom: 60,
              left: (size.width - 210) / 2,
              child: Container(
                child: Image.network(
                  ImageConstants.LOGO_VIVAZ_URL,
                  height: VIVAZ_LOGO_HEIGHT,
                  width: VIVAZ_LOGO_WIDTH,
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
      );
  }
}
