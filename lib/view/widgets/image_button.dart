import 'package:flutter/material.dart';

// ignore: must_be_immutable
class ImageButton extends StatelessWidget {
  double height;
  double width;
  double elevation;
  void Function()? onTap;
  double radius;
  String assetImage;
  ImageButton({required this.height,required this.width,required this.elevation,required this.onTap,required this.radius,required this.assetImage});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Card(
        elevation:elevation ,
        child: Container(
          height: height,
          width: width,
          decoration: BoxDecoration(
            image: DecorationImage(image: AssetImage(assetImage)),
            borderRadius: BorderRadius.circular(radius),
          ),
        ),
      ),
    );
  }
}