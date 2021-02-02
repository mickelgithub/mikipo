import 'package:flutter/material.dart';
import 'package:mikipo/src/ui/common/colors.dart';

class MatiasFeedback extends StatelessWidget {

  final String feedback;

  const MatiasFeedback({this.feedback});

  @override
  Widget build(BuildContext context) {

    final size= MediaQuery.of(context).size;
    final top= (size.height- 226)/2;

    return Stack(
      children: [
        Positioned(
          left: 20,
          right: 20,
          top: top,
          child: Image.network(
            'https://mikipo-8f9a7.web.app/images/indicacion.jpg',
            width: 400,
            height: 226,
            fit: BoxFit.cover,
          ),
        ),
        Positioned(
          right: 20,
          width: 250,
          top: top - 140,
          height: 150,
          child: Container(
            padding: EdgeInsets.only(left: 50, top: 30),
            decoration: BoxDecoration(
              image: DecorationImage(
                image: NetworkImage(
                  'https://mikipo-8f9a7.web.app/images/bubble.png',
                ),
              ),
            ),
            child: Text(
              feedback,
              style:
                  TextStyle(color: Palette.white, fontWeight: FontWeight.bold),
            ),
          ),
        ),
      ],
    );
  }
}
