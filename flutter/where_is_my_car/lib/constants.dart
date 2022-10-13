import 'package:flutter/material.dart';

Color bgColor = const Color.fromRGBO(0, 39, 138, 1);

TextStyle primaryTitleStyle = const TextStyle(
  color: Colors.white,
  fontSize: 40,
);

Widget myAnimation({Widget? child}) => TweenAnimationBuilder(
      duration: const Duration(milliseconds: 750),
      tween: Tween(begin: .3, end: 1.0),
      curve: Curves.bounceOut,
      builder: (BuildContext context, dynamic value, Widget? childBuilder) {
        return Transform(
          transform: Matrix4.identity()..scale(value),
          alignment: Alignment.center,
          child: Opacity(
            opacity: value,
            child: child,
          ),
        );
      },
    );
