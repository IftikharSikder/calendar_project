import 'package:animations/animations.dart';
import 'package:calendar/features/calendar/custom_widgets/top_nav_bar.dart';
import 'package:calendar/features/calendar/custom_widgets/weekly_calendar_builder.dart';
import 'package:calendar/features/search/search_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../../data/models/event_model.dart';
import '../controller/calendar_controller.dart';
import '../controller/top_nav_bar_controller.dart';
import '../custom_widgets/daily_calendar_builder.dart';
import '../custom_widgets/monthly_calendar_builder.dart';

class CalendarScreen extends StatelessWidget {
  CalendarScreen({super.key});
  final TopNavBarController controller = Get.put(TopNavBarController());
  @override
  Widget build(BuildContext context) {
    final isLightMode = Theme.of(context).brightness == Brightness.light;
    final primaryColor = Theme.of(context).primaryColor;
    final textColor = Theme.of(context).textTheme.bodyLarge?.color;
    final screenWidth = Get.width;
    final screenHeight = Get.height;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(0),
        child: AppBar(
          automaticallyImplyLeading: false,
          backgroundColor: Color.fromRGBO(162, 0, 76, 1.0),
          elevation: 0,
        ),
      ),
      body: Column(
        children: [
          _buildHeader(
            primaryColor: primaryColor,
            textColor: textColor!,
            isLightMode: isLightMode,
            screenWidth: screenWidth,
            screenHeight: screenHeight,
          ),
          Expanded(
            child: SingleChildScrollView(
              padding: EdgeInsets.only(bottom: 120,),
              child: Column(
                children: [
                  _buildWeatherInfo(
                    primaryColor: primaryColor,
                    textColor: textColor,
                    isLightMode: isLightMode,
                    city: 'Dhaka',
                    dateTime: DateTime.now(),
                    temperature: 22,
                    screenWidth: screenWidth,
                  ),
                  Divider(
                    color: Color(0xFFE0E9EE),
                    thickness: 6,
                  ),
                  SizedBox(
                    height: screenHeight * 0.01,
                  ),
                  Obx(() => buildBody()),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget _buildHeader(
      {required Color primaryColor,
      required Color textColor,
      required bool isLightMode,
      required double screenWidth,
      required double screenHeight}) {
    return Container(
      padding: EdgeInsets.only(
        top: screenWidth * 0.03,
        left: screenWidth * 0.04,
        right: screenWidth * 0.04,
        bottom: screenWidth * 0.04,
      ),
      decoration: BoxDecoration(
        color: primaryColor,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  CircleAvatar(
                    radius: screenWidth * 0.07,
                    backgroundImage: NetworkImage(
                      'https://letsenhance.io/static/73136da51c245e80edc6ccfe44888a99/1015f/MainBefore.jpg',
                    ),
                  ),
                  SizedBox(width: screenWidth * 0.03),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Good Morning",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: screenWidth * 0.045,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      Text(
                        "Syed Mohtasib Mashruk",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: screenWidth * 0.035,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              SizedBox(
                height: screenWidth * 0.04,
              ),
              Row(
                children: [
                  OpenContainer(
                    transitionDuration: Duration(milliseconds: 850),
                    closedElevation: 0,
                    closedShape: CircleBorder(),
                    closedColor: Colors.transparent,
                    openBuilder: (context, _) => SearchPage(),
                    closedBuilder: (context, openContainer) => IconButton(
                      icon: Icon(Icons.search, color: Colors.white),
                      onPressed: openContainer, // Opens Search Page with animation
                    ),
                  ),


                  SizedBox(width: screenWidth * 0.02),
                  IconButton(
                    onPressed: () {

                    },
                    icon: Icon(
                      Icons.notifications_none,
                      color: Colors.white,
                      size: screenWidth * 0.07,
                    ),
                  ),
                ],
              )
            ],
          ),
          SizedBox(height: screenWidth * 0.03),
          TopNavigationPage(
            screenWidth: screenWidth,
            screenHeight: screenHeight,
          ),
        ],
      ),
    );
  }

  Widget _buildWeatherInfo({
    required Color primaryColor,
    required Color textColor,
    required bool isLightMode,
    required String city,
    required DateTime dateTime,
    required double temperature,
    required double screenWidth,
  }) {
    return Padding(
      padding: EdgeInsets.only(
          top: screenWidth * 0.025,
          left: screenWidth * 0.025,
          right: screenWidth * 0.025,
          bottom: screenWidth * 0.015),
      child: Card(
        elevation: 2,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(screenWidth * 0.04),
          side: BorderSide(
            color: Colors.grey.withValues(alpha: .25),
          ),
        ),
        child: Container(
          padding: EdgeInsets.all(screenWidth * 0.035),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(screenWidth * 0.04),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              // City name
              Text(
                city,
                style: TextStyle(
                  fontSize: screenWidth * 0.035,
                  color: Color(0xFF666B7A),
                  fontWeight: FontWeight.w400,
                ),
              ),
              // Date
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    DateFormat('d MMM, yyyy').format(dateTime).toUpperCase(),
                    style: TextStyle(
                      fontSize: screenWidth * 0.045,
                      color: Color(0xFF1A1B4B),
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Row(
                    children: [
                      Icon(
                        Icons.cloudy_snowing,
                        color: Colors.amber,
                        size: screenWidth * 0.045,
                      ),
                      SizedBox(width: screenWidth * 0.015),
                      Text(
                        '${temperature.round()}° C',
                        style: TextStyle(
                          fontSize: screenWidth * 0.045,
                          color: Color(0xFF1A1B4B),
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ],
              ),

              // Time and Day
              Text(
                '${DateFormat('hh : mm a').format(dateTime)} | ${DateFormat('EEEE').format(dateTime)}',
                style: TextStyle(
                  fontSize: screenWidth * 0.035,
                  color: Color(0xFF666B7A),
                  fontWeight: FontWeight.w400,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void showAddEventDialog(BuildContext context) {
    final CalendarController controller = Get.find();
    final titleController = TextEditingController();
    final descriptionController = TextEditingController();
    final selectedColor = Rx<Color>(Colors.blue);
    final screenWidth = MediaQuery.of(context).size.width;

    Get.dialog(
      AlertDialog(
        title: Text('Add Event'),
        content: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: titleController,
                decoration: InputDecoration(
                  labelText: 'Event Title',
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(height: screenWidth * 0.03),
              TextField(
                controller: descriptionController,
                decoration: InputDecoration(
                  labelText: 'Event Description',
                  border: OutlineInputBorder(),
                ),
                maxLines: 3,
              ),
              SizedBox(height: screenWidth * 0.03),
              Row(
                children: [
                  Text('Event Color: '),
                  SizedBox(width: screenWidth * 0.015),
                  Obx(() => Container(
                        width: screenWidth * 0.05,
                        height: screenWidth * 0.05,
                        decoration: BoxDecoration(
                          color: selectedColor.value,
                          shape: BoxShape.circle,
                        ),
                      )),
                  TextButton(
                    onPressed: () {
                      showDialog(
                        context: context,
                        builder: (context) => AlertDialog(
                          title: Text('Select Color'),
                          content: SingleChildScrollView(
                            child: BlockPicker(
                              pickerColor: selectedColor.value,
                              onColorChanged: (Color color) {
                                selectedColor.value = color;
                                Navigator.pop(context);
                              },
                            ),
                          ),
                        ),
                      );
                    },
                    child: Text('Select Color'),
                  ),
                ],
              ),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Get.back(),
            child: Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              if (titleController.text.isNotEmpty) {
                controller.addEvent(
                  Event(
                    title: titleController.text,
                    description: descriptionController.text,
                    date: controller.selectedDate.value,
                    color: selectedColor.value,
                  ),
                );
                Get.back();
              }
            },
            child: Text('Add'),
          ),
        ],
      ),
    );
  }

  Widget buildBody() {
    switch (controller.selectedIndex) {
      case 0:
        return DailyCalendarBuilder();
      case 1:
        return WeeklyCalendarBuilder();
      case 2:
        return MonthlyCalendarBuilder();
      default:
        return const SizedBox.shrink();
    }
  }
}
