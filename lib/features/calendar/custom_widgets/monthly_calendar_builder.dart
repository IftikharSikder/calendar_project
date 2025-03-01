import 'package:calendar/features/calendar/custom_widgets/triangle_painter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:get/get.dart';

import '../../../data/models/event_model.dart';
import '../../../theme/controller/theme_controller.dart';
import '../controller/calendar_controller.dart';
import 'build_navigation_button.dart';

class MonthlyCalendarBuilder extends StatelessWidget {
  MonthlyCalendarBuilder({super.key});

  final List<String> _months = [
    'January',
    'February',
    'March',
    'April',
    'May',
    'June',
    'July',
    'August',
    'September',
    'October',
    'November',
    'December'
  ];

  final ThemeController themeController = Get.put(ThemeController());

  void _showMonthYearPicker(
      BuildContext context, CalendarController controller) {
    final textColor = Theme.of(context).textTheme.bodyLarge?.color;
    final isLightMode = Theme.of(context).brightness == Brightness.light;
    final selectedMonth = controller.focusedDate.value.month.obs;
    final selectedYear = controller.focusedDate.value.year.obs;
    final yearController = TextEditingController(
      text: selectedYear.value.toString(),
    );

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Obx(() => AlertDialog(
          backgroundColor:
          isLightMode ? Colors.grey[200] : Colors.grey[800],
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20.0)),
          title: Text(
            'Select Month and Year',
            style: TextStyle(color: textColor, fontWeight: FontWeight.bold),
            textAlign: TextAlign.center,
          ),
          content: SizedBox(
            width: double.maxFinite,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 12),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(color: textColor ?? Colors.black),
                  ),
                  child: DropdownButton<int>(
                    value: selectedMonth.value,
                    isExpanded: true,
                    dropdownColor:
                    isLightMode ? Colors.grey[200] : Colors.grey[800],
                    style: TextStyle(color: textColor, fontSize: 16),
                    underline: SizedBox(),
                    items: List.generate(12, (index) {
                      return DropdownMenuItem(
                        value: index + 1,
                        child: Text(_months[index]),
                      );
                    }),
                    onChanged: (int? value) {
                      if (value != null) {
                        selectedMonth.value = value;
                      }
                    },
                  ),
                ),
                SizedBox(height: 20),
                TextField(
                  controller: yearController,
                  keyboardType: TextInputType.number,
                  style: TextStyle(color: textColor),
                  decoration: InputDecoration(
                    labelText: 'Year',
                    labelStyle: TextStyle(color: textColor),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide:
                      BorderSide(color: textColor ?? Colors.black),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide:
                      BorderSide(color: textColor ?? Colors.black),
                    ),
                  ),
                  onChanged: (value) {
                    if (value.isNotEmpty && int.tryParse(value) != null) {
                      selectedYear.value = int.parse(value);
                    }
                  },
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              child: Text('Cancel', style: TextStyle(color: textColor)),
              onPressed: () => Navigator.pop(context),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: textColor,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8.0),
                ),
              ),
              child: Text(
                'Apply',
                style: TextStyle(
                  color: !isLightMode ? Colors.black : Colors.white,
                ),
              ),
              onPressed: () {
                controller.setDate(
                    DateTime(selectedYear.value, selectedMonth.value));
                Navigator.pop(context);
              },
            ),
          ],
        ));
      },
    );
  }

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
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
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
            ...events.map((event) => _buildEventItem(context, event)).toList(),
          ],
        ),
      ),
    );
  }

  Widget _buildEventItem(BuildContext context, Event event) {
    final screenWidth = MediaQuery.of(context).size.width;
    return Container(
      margin: EdgeInsets.only(bottom: screenWidth * 0.02),
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

    return Obx(() {
      final days = calendarController.daysInMonth;
      const int crossAxisCount = 7;
      final int rowCount = (days.length / crossAxisCount).ceil();
      final double childAspectRatio = 1.0;
      final double itemHeight = screenWidth / crossAxisCount * childAspectRatio;
      final double gridHeight = itemHeight * rowCount;

      return Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.015),
            child: Column(
              mainAxisSize: MainAxisSize.min, // Added to make height automatic
              children: [
                Padding(
                  padding: EdgeInsets.only(
                      left: screenWidth * 0.04,
                      right: screenWidth * 0.04,
                      //top: screenWidth * 0.04,
                      bottom: screenWidth * 0.015),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      InkWell(
                        onTap: calendarController.previousMonth,
                        child: BuildNavigationButton(
                          icon: Icons.keyboard_arrow_left_rounded,
                        ),
                      ),
                      InkWell(
                        onTap: () =>
                            _showMonthYearPicker(context, calendarController),
                        child: Container(
                          padding: EdgeInsets.symmetric(
                              horizontal: screenWidth * 0.04,
                              vertical: screenWidth * 0.02),
                          decoration: BoxDecoration(
                            borderRadius:
                            BorderRadius.circular(screenWidth * 0.02),
                          ),
                          child: Obx(() {
                            return Row(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              textBaseline: TextBaseline.alphabetic,
                              children: [
                                Text(
                                  '${_months[calendarController.focusedDate.value.month - 1]}, ${calendarController.focusedDate.value.year}',
                                  style: Theme.of(context)
                                      .textTheme
                                      .titleLarge
                                      ?.copyWith(
                                    fontWeight: FontWeight.bold,
                                    fontSize: screenWidth * 0.045,
                                    color: primaryColor,
                                  ),
                                ),
                                Transform.rotate(
                                  angle: 270 * 3.14159 / 180,
                                  child: CustomPaint(
                                    size: Size(screenWidth * 0.025,
                                        screenWidth * 0.025),
                                    painter: TrianglePainter(
                                      color: primaryColor,
                                      isFilled: true,
                                    ),
                                  ),
                                ),
                              ],
                            );
                          }),
                        ),
                      ),
                      InkWell(
                        onTap: calendarController.nextMonth,
                        child: BuildNavigationButton(
                            icon: Icons.keyboard_arrow_right_rounded),
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
                  children: ['MO', 'TU', 'WE', 'TH', 'FR', 'SA', 'SU']
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
                Padding(
                  padding: EdgeInsets.symmetric(
                      horizontal: screenWidth * 0.04,
                      vertical: screenWidth * 0.02),
                  child: SizedBox( // Changed Container to SizedBox and added height
                    height: gridHeight,
                    child: AnimationLimiter(
                      child: GridView.builder(
                        shrinkWrap: false, // Set to false to fill SizedBox
                        physics: const NeverScrollableScrollPhysics(),
                        gridDelegate:
                        SliverGridDelegateWithFixedCrossAxisCount(
                          mainAxisSpacing: 0,
                          crossAxisSpacing: 0,
                          crossAxisCount: crossAxisCount,
                          childAspectRatio: childAspectRatio,
                        ),
                        itemCount: days.length,
                        itemBuilder: (context, index) {
                          return AnimationConfiguration.staggeredGrid(
                            position: index,
                            columnCount: 7,
                            child: ScaleAnimation(
                              duration: Duration(milliseconds: 700),
                              child: FadeInAnimation(
                                child: Material(
                                  color: Colors.white,
                                  elevation: 10,
                                  shadowColor: Colors.white,
                                  child: GetBuilder<CalendarController>(
                                    builder: (controller) {
                                      final today = DateTime.now();
                                      final day = days[index];
                                      final isSelected =
                                      controller.isSelectedDate(day);
                                      final isCurrentMonth = day.month ==
                                          controller.focusedDate.value.month;
                                      final isSunday = index % 7 == 6;
                                      final isSaturday = index % 7 == 5;
                                      final isToday = day.year == today.year &&
                                          day.month == today.month &&
                                          day.day == today.day;
                                      final events =
                                      controller.getEventsForDate(day);

                                      return InkWell(
                                        onTap: () => controller.selectDate(day),
                                        child: Container(
                                          padding: EdgeInsets.symmetric(
                                              vertical: 2, horizontal: 5),
                                          decoration: BoxDecoration(
                                            border: isToday
                                                ? Border.all(
                                              width: 2.5,
                                              color: primaryColor,
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
                                                      .withOpacity(0.4)
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
                                      );
                                    },
                                  ),
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                ),
              ],
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
          SizedBox(
            height: 12,
          ),
          Obx(() {
            final selectedDateEvents = calendarController
                .getEventsForDate(calendarController.selectedDate.value);
            return _buildEventList(context, selectedDateEvents);
          }),
        ],
      );
    });
  }
}