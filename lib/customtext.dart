import 'package:flutter/material.dart';
import 'package:flutter_application_1/configs/constant.dart';


class Customtext extends StatelessWidget {
  final String label;
  final Color labelColor;
  final double fontsize;
  const Customtext({super.key, required this.label, this.labelColor= appGrey, this.fontsize= 20, required FontWeight fontWeight, });

  @override
  Widget build(BuildContext context) {
    return Text(
      label,
      style:
          // ignore: prefer_const_constructors
          TextStyle(color: labelColor , fontSize: 15, fontWeight: FontWeight.w700),
    );
  }
}