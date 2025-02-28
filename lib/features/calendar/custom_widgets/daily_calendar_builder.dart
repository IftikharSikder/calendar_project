import 'package:calendar/features/calendar/custom_widgets/build_navigation_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../../data/models/event_model.dart';
import '../controller/calendar_controller.dart';

class DailyCalendarBuilder extends StatelessWidget {
  DailyCalendarBuilder({super.key});

  Widget _buildEventList(BuildContext context, List<Event> events) {
    final isLightMode = Theme.of(context).brightness == Brightness.light;
    final primaryColor = Theme.of(context).primaryColor;
    final screenWidth = MediaQuery.of(context).size.width;

    if (events.isEmpty) {
      return Card(
        elevation: 2,
        margin: EdgeInsets.symmetric(
            horizontal: screenWidth * 0.04, vertical: screenWidth * 0.02),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(screenWidth * 0.03),
          side: BorderSide(
            color: Colors.grey.withOpacity(0.25),
          ),
        ),
        child: Container(
          padding: EdgeInsets.all(screenWidth * 0.03),
          decoration: BoxDecoration(
            color: isLightMode ? Colors.white : Colors.grey[800],
            borderRadius: BorderRadius.circular(screenWidth * 0.03),
          ),
          child: Center(
            child: Text(
              'No events for this date',
              style: TextStyle(
                color: Colors.grey,
                fontSize: screenWidth * 0.04,
              ),
            ),
          ),
        ),
      );
    }

    return AnimationLimiter(
      child: ListView.builder(
        shrinkWrap: true,
        physics: NeverScrollableScrollPhysics(),
        itemCount: events.length,
        itemBuilder: (context, index) {
          return AnimationConfiguration.staggeredList(
            position: index,
            duration: Duration(milliseconds: 500),
            child: SlideAnimation(
              verticalOffset: 50.0,
              child: FadeInAnimation(
                child: _buildEventItem(context, events[index]),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildEventItem(BuildContext context, Event event) {
    final screenWidth = MediaQuery.of(context).size.width;
    return Container(
      margin: EdgeInsets.symmetric(
          horizontal: screenWidth * 0.04, vertical: screenWidth * 0.02),
      padding: EdgeInsets.all(screenWidth * 0.03),
      decoration: BoxDecoration(
        color: event.color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(screenWidth * 0.03),
        border: Border.all(
          color: event.color.withOpacity(0.3),
        ),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: screenWidth * 0.03,
            height: screenWidth * 0.03,
            margin: EdgeInsets.only(top: screenWidth * 0.01),
            decoration: BoxDecoration(
              color: event.color,
              shape: BoxShape.circle,
            ),
          ),
          SizedBox(width: screenWidth * 0.03),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  event.title,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: screenWidth * 0.04,
                  ),
                ),
                if (event.description.isNotEmpty)
                  Padding(
                    padding: const EdgeInsets.only(top: 4),
                    child: Text(
                      event.description,
                      style: TextStyle(
                        color: Colors.grey[600],
                        fontSize: screenWidth * 0.035,
                      ),
                    ),
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final CalendarController calendarController =
        Get.find<CalendarController>();
    final primaryColor = Theme.of(context).primaryColor;
    final isLightMode = Theme.of(context).brightness == Brightness.light;
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Card(
          margin: EdgeInsets.symmetric(horizontal: screenWidth * 0.04),
          elevation: 2,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(screenWidth * 0.03),
            side: BorderSide(
              color: Colors.grey.withOpacity(0.25),
            ),
          ),
          child: Container(
            height: screenHeight * 0.12,
            padding: EdgeInsets.all(screenWidth * 0.03),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(screenWidth * 0.04),
            ),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    InkWell(
                      onTap: () {
                        final newDate = calendarController.selectedDate.value
                            .subtract(Duration(days: 1));
                        calendarController.selectDate(newDate);
                      },
                      child: BuildNavigationButton(icon: Icons.chevron_left),
                    ),
                    Obx(() {
                      final selectedDate =
                          calendarController.selectedDate.value;
                      final isToday =
                          selectedDate.year == DateTime.now().year &&
                              selectedDate.month == DateTime.now().month &&
                              selectedDate.day == DateTime.now().day;

                      return Column(
                        children: [
                          Text(
                            DateFormat('EEEE').format(selectedDate),
                            style: TextStyle(
                              fontSize: screenWidth * 0.045,
                              fontWeight: FontWeight.bold,
                              color: primaryColor,
                            ),
                          ),
                          Text(
                            DateFormat('MMMM d, y').format(selectedDate),
                            style: TextStyle(
                              fontSize: screenWidth * 0.035,
                              color: Colors.grey[600],
                            ),
                          ),
                          if (isToday)
                            Container(
                              margin: EdgeInsets.only(top: 4),
                              padding: EdgeInsets.symmetric(
                                  horizontal: 8, vertical: 2),
                              decoration: BoxDecoration(
                                color: primaryColor.withOpacity(0.1),
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: Text(
                                'Today',
                                style: TextStyle(
                                  color: primaryColor,
                                  fontSize: screenWidth * 0.03,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                        ],
                      );
                    }),
                    InkWell(
                      onTap: () {
                        final newDate = calendarController.selectedDate.value
                            .add(Duration(days: 1));
                        calendarController.selectDate(newDate);
                      },
                      child: BuildNavigationButton(icon: Icons.chevron_right),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
        SizedBox(height: screenWidth * 0.04),
        Card(
          margin: EdgeInsets.symmetric(horizontal: screenWidth * 0.04),
          elevation: 2,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(screenWidth * 0.03),
            side: BorderSide(
              color: Colors.grey.withOpacity(0.25),
            ),
          ),
          child: Container(
            padding: EdgeInsets.all(screenWidth * 0.03),
            decoration: BoxDecoration(
              color: isLightMode ? Colors.white : Colors.grey[800],
              borderRadius: BorderRadius.circular(screenWidth * 0.03),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Events',
                  style: TextStyle(
                    fontSize: screenWidth * 0.045,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
                SizedBox(height: screenWidth * 0.02),
                Obx(() {
                  final selectedDateEvents = calendarController
                      .getEventsForDate(calendarController.selectedDate.value);
                  return _buildEventList(context, selectedDateEvents);
                }),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
