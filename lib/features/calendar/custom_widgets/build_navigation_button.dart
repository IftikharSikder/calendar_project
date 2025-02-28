import 'package:flutter/material.dart';

class BuildNavigationButton extends StatelessWidget {
  const BuildNavigationButton({super.key, required this.icon});
  final IconData icon;
  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    return Material(
      elevation: 2,
      borderRadius: BorderRadius.circular(25),
      child: Container(
        width: screenWidth * 0.1,
        height: screenWidth * 0.1,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: Theme.of(context).brightness == Brightness.dark
              ? Colors.black
              : Colors.white,
          border: Border.all(
            color: Color(0xFF8F9BB3).withValues(alpha: .3),
            width: 1.5,
          ),
        ),
        child: Center(
          child: Icon(
            icon,
            size: screenWidth * 0.07,
            color: Color(0xFF8F9BB3),
          ),
        ),
      ),
    );
  }
}
