import 'package:flutter/material.dart';

class ContainerButtonModel extends StatelessWidget {

  final Color? bgColor;
  final double? containerWidth;
  final String itext;

  const ContainerButtonModel({super.key, this.bgColor, this.containerWidth, required this.itext});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 60,
      width: 120,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: bgColor
      ),
      child: Center(
        child: Text(
        "Comprar",
        style: TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.bold,
          fontSize: 18
        ),),
      ),
    );
  }
}