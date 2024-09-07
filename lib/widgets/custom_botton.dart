import 'package:flutter/material.dart';

class CustomBotton extends StatelessWidget {
  CustomBotton({super.key, required this.titel, this.onTap});
  String titel;
  VoidCallback? onTap;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 40,
        width: double.infinity,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Center(child: Text(titel)),
      ),
    );
  }
}
