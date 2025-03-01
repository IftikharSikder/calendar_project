import 'package:calendar/features/calendar/custom_widgets/build_navigation_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:get/get.dart';
import '../../../data/models/event_model.dart';
import '../controller/calendar_controller.dart';

class WeeklyCalendarBuilder extends StatelessWidget {
  WeeklyCalendarBuilder({super.key});

  final List<String> _days = ['MO', 'TU', 'WE', 'TH', 'FR', 'SA', 'SU'];

  Widget _buildEventList(BuildContext context, List<Event> events) {
    final isLightMode = Theme.of(context).brightness == Brightness.light;
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
    final CalendarController calendarController = Get.put(CalendarController());
    final primaryColor = Theme.of(context).primaryColor;
    final isLightMode = Theme.of(context).brightness == Brightness.light;
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.015),
          child: Container(
            height: screenHeight * .229,
            padding: EdgeInsets.only(bottom: screenWidth * 0.03),
            decoration: BoxDecoration(
              color: Colors.white,
              //borderRadius: BorderRadius.circular(screenWidth * 0.04),
            ),
            child: Column(
              children: [
                Padding(
                  padding: EdgeInsets.only(
                      left: screenWidth * 0.04,
                      right: screenWidth * 0.04,
                      top: screenWidth * 0.04,
                      bottom: screenWidth * 0.015),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      InkWell(
                        onTap: () {
                          final newDate = calendarController.selectedDate.value
                              .subtract(Duration(days: 7));
                          calendarController.selectDate(newDate);
                        },
                        child: BuildNavigationButton(icon: Icons.chevron_left),
                      ),
                      Obx(() {
                        final startOfWeek = calendarController
                            .selectedDate.value
                            .subtract(Duration(
                                days: calendarController
                                        .selectedDate.value.weekday -
                                    1));
                        final endOfWeek = startOfWeek.add(Duration(days: 6));
                        return Text(
                          '${startOfWeek.day} ${_getMonthName(startOfWeek.month)} - ${endOfWeek.day} ${_getMonthName(endOfWeek.month)}',
                          style: TextStyle(
                            fontSize: screenWidth * 0.045,
                            fontWeight: FontWeight.bold,
                            color: primaryColor,
                          ),
                        );
                      }),
                      InkWell(
                        onTap: () {
                          final newDate = calendarController.selectedDate.value
                              .add(Duration(days: 7));
                          calendarController.selectDate(newDate);
                        },
                        child: BuildNavigationButton(icon: Icons.chevron_right),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(
                    right: screenWidth * 0.03,
                    left: screenWidth * 0.03,
                    bottom: screenWidth * 0.015,
                    top: screenWidth * 0.01,
                  ),
                  child: Divider(
                    thickness: 1.0,
                    color: isLightMode ? Color(0xFF8F9BB3) : Colors.grey,
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: _days
                      .map((day) => Text(
                            day,
                            style: TextStyle(
                              color: Color(0xFF8F9BB3),
                              fontWeight: FontWeight.bold,
                              fontSize: screenWidth * 0.035,
                            ),
                          ))
                      .toList(),
                ),
                Expanded(
                  child: Obx(() {
                    // Calculate the start of the week based on selected date
                    final startOfWeek = calendarController.selectedDate.value
                        .subtract(Duration(
                            days:
                                calendarController.selectedDate.value.weekday -
                                    1));

                    // Generate a list of 7 days for the week
                    final daysInWeek = List.generate(
                      7,
                      (index) => startOfWeek.add(Duration(days: index)),
                    );

                    return Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: screenWidth * 0.04,
                          vertical: screenWidth * 0.02),
                      child: AnimationLimiter(
                        child: GridView.builder(
                          physics: NeverScrollableScrollPhysics(),
                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 7,
                            childAspectRatio: 1,
                          ),
                          itemCount: 7,
                          itemBuilder: (context, index) {
                            final day = daysInWeek[index];
                            final today = DateTime.now();
                            final isToday = day.year == today.year &&
                                day.month == today.month &&
                                day.day == today.day;
                            final isSelected =
                                calendarController.isSelectedDate(day);
                            final isCurrentMonth = day.month ==
                                calendarController.focusedDate.value.month;
                            final isSunday = index == 6;
                            final isSaturday = index == 5;
                            final events =
                                calendarController.getEventsForDate(day);

                            return AnimationConfiguration.staggeredGrid(
                              position: index,
                              columnCount: 7,
                              duration: Duration(milliseconds: 500),
                              child: ScaleAnimation(
                                child: FadeInAnimation(
                                  child: InkWell(
                                    onTap: () =>
                                        calendarController.selectDate(day),
                                    child: Material(
                                      color: Colors.white,
                                      elevation: 5,
                                      shadowColor: Colors.white,
                                      child: Container(
                                        padding: EdgeInsets.symmetric(
                                            vertical: 2, horizontal: 5),
                                        decoration: BoxDecoration(
                                          border: isToday
                                              ? Border.all(
                                                  width: 2.5,
                                                  color: Theme.of(context)
                                                      .primaryColor, // Red border for today
                                                )
                                              : Border.all(
                                                  width: .35,
                                                  color: Color(0xFF8F9BB3),
                                                ),
                                          color: isToday
                                              ? Colors.transparent
                                              : isSelected
                                                  ? primaryColor
                                                  : isSaturday || isSunday
                                                      ? Color(0xFFF6F7F9)
                                                      : Colors.transparent,
                                        ),
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              '${day.day}',
                                              style: TextStyle(
                                                color: isToday
                                                    ? isLightMode
                                                        ? Colors.black
                                                        : Colors.white
                                                    : isSelected
                                                        ? Theme.of(context)
                                                            .colorScheme
                                                            .onPrimary
                                                        : (isSunday ||
                                                                    isSaturday) &&
                                                                isCurrentMonth
                                                            ? primaryColor
                                                            : (isSunday ||
                                                                        isSaturday) &&
                                                                    !isCurrentMonth
                                                                ? primaryColor
                                                                    .withOpacity(
                                                                        0.4)
                                                                : isCurrentMonth
                                                                    ? Theme.of(
                                                                            context)
                                                                        .textTheme
                                                                        .bodyLarge
                                                                        ?.color
                                                                    : Theme.of(
                                                                            context)
                                                                        .textTheme
                                                                        .bodyLarge
                                                                        ?.color
                                                                        ?.withOpacity(
                                                                            0.5),
                                                fontWeight:
                                                    isSelected || isToday
                                                        ? FontWeight.bold
                                                        : FontWeight.normal,
                                                fontSize: screenWidth * 0.035,
                                              ),
                                            ),
                                            if (events.isNotEmpty)
                                              Column(
                                                children: [
                                                  ...events.take(1).map(
                                                    (event) {
                                                      return Text(
                                                        event.title,
                                                        maxLines: 1,
                                                        overflow: TextOverflow
                                                            .ellipsis,
                                                        style: TextStyle(
                                                          color: isSelected
                                                              ? Colors.white
                                                              : primaryColor,
                                                          fontSize:
                                                              screenWidth *
                                                                  0.03,
                                                        ),
                                                      );
                                                    },
                                                  ),
                                                ],
                                              ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                    );
                  }),
                ),
              ],
            ),
          ),
        ),
        Container(
          color: Color(0xFFE0E9EE),
          height: screenWidth * .15,
          child: Row(
            children: [
              SizedBox(
                width: 15,
              ),
              Image.asset(
                'assets/images/todo-list_icon.png',
                height: 40,
                width: 40,
              ),
              SizedBox(
                width: 5,
              ),
              Text('To-Do List', style: TextStyle(fontSize: 24))
            ],
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

  String _getMonthName(int month) {
    final months = [
      'Jan',
      'Feb',
      'Mar',
      'Apr',
      'May',
      'Jun',
      'Jul',
      'Aug',
      'Sep',
      'Oct',
      'Nov',
      'Dec'
    ];
    return months[month - 1];
  }
}
