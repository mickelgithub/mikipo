import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:mikipo/src/route/route_generator.dart';
import 'package:mikipo/src/ui/common/colors.dart';
import 'package:mikipo/src/ui/splash/splash_screen.dart';
import 'package:mikipo/src/util/constants/errors_constants.dart';
import 'package:mikipo/src/util/constants/size_constants.dart';

class InfoScreen extends StatelessWidget {

  static const _RETRY_LABEL = "Reintentar";

  final String message;

  const InfoScreen._({@required this.message});

  static Widget getInfoScreen({@required BuildContext context, message: String}) {
    return InfoScreen._(message: message);
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      body: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: DecoratedBox(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20.0),
                color: Palette.white,
              ),
              child: Image.asset(
                'assets/images/team.png',
                width: SizeConstants.SPLASH_IMAGE_WIDTH/2.5,
                height: SizeConstants.SPLASH_IMAGE_HEIGHT/2.5,
              ),
            ),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Center(
                child: Container(
                  width: size.width * 0.8,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20.0),
                      border: Border.all(color: Palette.white, width: 2.0)),
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Text(
                      message,
                      style: TextStyle(
                        color: Palette.white,
                        fontSize: 20,
                      ),
                    ),
                  ),
                ),
              ),
              if (_showButtonRetry())
              SizedBox(
                height: 20,
              ),
              if (_showButtonRetry())
              OutlinedButton(
                onPressed: () {
                  _reintentar(context);
                },
                style: OutlinedButton.styleFrom(
                    primary: Palette.white,
                    side: BorderSide(color: Palette.white),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8.0),
                    )),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24.0),
                  child: Text(
                    _RETRY_LABEL,
                    style: TextStyle(
                      fontSize: 16,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  void _reintentar(BuildContext context) {
    Navigator.of(context).pushReplacementNamed(RouteGenerator.SPLASH_ROUTE);
  }

  bool _showButtonRetry() => message== ErrorsConstants.NETWORK_ERROR_AND_TRY;

}
