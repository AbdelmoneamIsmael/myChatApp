import 'package:flutter/material.dart';

class CustomButtom extends StatelessWidget {
  const CustomButtom({super.key, required this.onTap, required this.widget});
  final void Function()? onTap;

  final Widget widget;
  @override
  Widget build(BuildContext context) {
    return MaterialButton(
        height: 60,
        shape:
            ContinuousRectangleBorder(borderRadius: BorderRadius.circular(20)),
        minWidth: double.infinity,
        color: Colors.black,
        onPressed: onTap,
        child: widget);
  }
}
