import 'package:animations/animations.dart';
import 'package:calendar/features/bottom_navigation_bar/controller/bottom_navigation_bar_controller.dart';
import 'package:calendar/features/calendar/screen/add_event.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../calendar/screen/calendar_screen.dart';
import '../settings/setting_page.dart';
import '../store/store_page.dart';

class CustomBottomNavigationBar extends StatelessWidget {
  final BottomNavigationBarController controller =
      Get.put(BottomNavigationBarController());

  CustomBottomNavigationBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Scaffold(
        extendBody: true,
        body: IndexedStack(
          index: controller.selectedIndex.value,
          children: [
            StorePage(),
            CalendarScreen(),
            SettingPage(),
          ],
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        floatingActionButton: OpenContainer(
          transitionDuration: Duration(milliseconds: 850),
          closedElevation: 0,
          closedShape: const CircleBorder(),
          closedColor: Colors.transparent,
          openBuilder: (context, _) => AddEvent(), // Your target page
          closedBuilder: (context, openContainer) => SizedBox(
            height: 65,
            width: 65,
            child: FittedBox(
              child: FloatingActionButton(
                backgroundColor: const Color(0xFFAA0055),
                elevation: 5,
                shape: const CircleBorder(),
                onPressed: openContainer, // Opens AddEvent page with animation
                child: const Icon(
                  Icons.add,
                  size: 30,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        )
        ,
        bottomNavigationBar: BottomAppBar(
          shape: const CircularNotchedRectangle(),
          color: Colors.white,
          notchMargin: 10,
          child: Container(
            height: 65,
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // Left side
                Expanded(
                  child: Row(
                    children: [
                      Expanded(
                        child: GestureDetector(
                          onTap: () => controller.selectedIndex.value = 0,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.shopping_cart_outlined,
                                color: controller.selectedIndex.value == 0
                                    ? const Color(0xFFAA0055)
                                    : const Color(0xFF9E9E9E),
                                size: 28,
                              ),
                              Text(
                                'Store',
                                style: TextStyle(
                                  color: controller.selectedIndex.value == 0
                                      ? const Color(0xFFAA0055)
                                      : const Color(0xFF9E9E9E),
                                  fontSize: 15,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                // Center text
                Expanded(
                  child: GestureDetector(
                    onTap: () => controller.selectedIndex.value = 1,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(top: 35.0),
                          child: Text(
                            'Home',
                            style: TextStyle(
                              color: controller.selectedIndex.value == 1
                                  ? const Color(0xFFAA0055)
                                  : const Color(0xFF9E9E9E),
                              fontSize: 15,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

                // Right side
                Expanded(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Expanded(
                        child: GestureDetector(
                          onTap: () => controller.selectedIndex.value = 2,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.person_outline,
                                color: controller.selectedIndex.value == 2
                                    ? const Color(0xFFAA0055)
                                    : const Color(0xFF9E9E9E),
                                size: 28,
                              ),
                              const SizedBox(height: 4),
                              Text(
                                'Settings',
                                style: TextStyle(
                                  color: controller.selectedIndex.value == 2
                                      ? const Color(0xFFAA0055)
                                      : const Color(0xFF9E9E9E),
                                  fontSize: 15,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
