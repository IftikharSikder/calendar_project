import 'package:calendar/features/calendar/controller/top_nav_bar_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class TopNavigationPage extends StatelessWidget {
  TopNavigationPage({
    super.key,
    required this.screenWidth,
    required this.screenHeight,
  });
  final double screenWidth;
  final double screenHeight;

  final TopNavBarController controller = Get.put(TopNavBarController());
  @override
  Widget build(BuildContext context) {
    final isLightMode = Theme.of(context).brightness == Brightness.light;
    final primaryColor = Theme.of(context).primaryColor;
    final textColor = Theme.of(context).textTheme.bodyLarge?.color;

    return Container(
      margin: EdgeInsets.symmetric(
        horizontal: screenWidth * 0.01,
        vertical: screenWidth * 0.01,
      ),
      padding: EdgeInsets.symmetric(
        vertical: screenWidth * 0.03,
        horizontal: screenWidth * 0.04,
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(screenWidth * 0.03),
        color: Color(0xFFC3005B),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          _buildFilterButton(
            "Today",
            index: 0,
            primaryColor: primaryColor,
            textColor: textColor!,
            isLightMode: isLightMode,
            screenWidth: screenWidth,
          ),
          Container(
            height: screenWidth * 0.06,
            width: 2,
            color: Colors.white,
            margin: EdgeInsets.symmetric(
              vertical: screenWidth * 0.02,
              horizontal: screenWidth * 0.015,
            ),
          ),
          _buildFilterButton(
            "Week",
            index: 1,
            primaryColor: primaryColor,
            textColor: textColor,
            isLightMode: isLightMode,
            screenWidth: screenWidth,
          ),
          Container(
            height: screenWidth * 0.06,
            width: 2,
            color: Colors.white,
            margin: EdgeInsets.symmetric(
              vertical: screenWidth * 0.02,
              horizontal: screenWidth * 0.015,
            ),
          ),
          _buildFilterButton(
            "Month",
            index: 2,
            primaryColor: primaryColor,
            textColor: textColor,
            isLightMode: isLightMode,
            screenWidth: screenWidth,
          ),
        ],
      ),
    );
  }

  Widget _buildFilterButton(
    String title, {
    required int index,
    required Color primaryColor,
    required Color textColor,
    required bool isLightMode,
    required double screenWidth,
  }) {
    final TopNavBarController controller = Get.put(TopNavBarController());
    return Obx(() {
      final isSelected = controller.selectedIndex == index;
      return Expanded(
        child: InkWell(
          onTap: () => controller.changeIndex(index),
          borderRadius: BorderRadius.circular(screenWidth * 0.02),
          child: Container(
            padding: EdgeInsets.symmetric(vertical: screenWidth * 0.028),
            decoration: BoxDecoration(
              color: isSelected ? Colors.white : Colors.transparent,
              borderRadius: BorderRadius.circular(screenWidth * 0.02),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.1),
                  blurRadius: 8,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.calendar_month_outlined,
                  color: isSelected ? primaryColor : Colors.white,
                  size: screenWidth * 0.05,
                ),
                SizedBox(width: screenWidth * 0.015),
                Text(
                  title,
                  style: TextStyle(
                    color: isSelected ? primaryColor : Colors.white,
                    fontWeight: FontWeight.w500,
                    fontSize: screenWidth * 0.04,
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    });
  }
}
