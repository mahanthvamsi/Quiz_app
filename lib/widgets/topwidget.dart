import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';

class TopWidget extends StatelessWidget {
  const TopWidget({super.key});

  @override
  Stack build(BuildContext context) {
    return Stack(
      children: [
        Container(
          height: 820,
        ),
        Container(
          decoration: BoxDecoration(
              color: Color(0xffA76AE4),
              borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(30),
                  bottomRight: Radius.circular(30)
              )
          ),
          height: 445,
          width: double.infinity,
        ),
        SvgPicture.asset("assets/Ellipse 7_3_3.svg"),
        Positioned(
          left: 130,
          child: SvgPicture.asset("assets/Ellipse 10_3_6.svg"),
        ),
        Positioned(
          top: 30,
          left: 280,
          child: SvgPicture.asset("assets/Ellipse 9_3_5.svg"),
        ),
        Positioned(
            top: 180,
            right:-10,
            height: 200,
            child: SvgPicture.asset("assets/Ellipse 8_3_4.svg")
        ),
        Positioned(
          top: 60,
          left: 35,
          child: SvgPicture.asset("assets/Ellipse 6_2_2.svg"),
        ),
        Positioned(
          left: 66,
          top: 85,
          child: SvgPicture.asset("assets/Ellipse 11_3_7.svg"),
        ),
        Positioned(
          left: 95,
          top: 108,
          child: SvgPicture.asset("assets/Ellipse 12_3_8.svg"),
        ),
        Positioned(
          left: 124,
          top: 130,
          height: 95,
          child: Image.asset("assets/quiz 1_3_119.png"
          ),
        ),

      ],
    );
  }
}
