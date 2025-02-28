import 'package:calendar/features/feedback/feedback_page.dart';
import 'package:calendar/features/history/history_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../bottom_navigation_bar/controller/bottom_navigation_bar_controller.dart';

class SettingPage extends StatelessWidget {
  const SettingPage({super.key});

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    double widgetWidthHead = 393; // Relative to a 393px width screen
    double widgetHeightHead =
        screenHeight * (150 / 852); // Assuming 852px as base height
    final BottomNavigationBarController controller =
        Get.put(BottomNavigationBarController());
    return Scaffold(
      backgroundColor: Color(0xFFE0E9EE),
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(35), // Set custom height
        child: AppBar(
          automaticallyImplyLeading: false,
          backgroundColor: Color.fromRGBO(162, 0, 76, 1.0),
          elevation: 0,
        ),
      ),
      body: SafeArea(
        child: Column(
          children: [
            Align(
              alignment: Alignment.topCenter,
              child: Container(
                height: widgetHeightHead,
                width: double.infinity,
                decoration:
                    BoxDecoration(color: Color.fromRGBO(162, 0, 76, 1.0)),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    CircleAvatar(
                      radius: 38,
                      backgroundImage: NetworkImage(
                          'https://letsenhance.io/static/73136da51c245e80edc6ccfe44888a99/1015f/MainBefore.jpg'),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      //crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          "syedmashruk@gmail.com",
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                              letterSpacing: 0.8,
                              fontWeight: FontWeight.w800),
                        ),
                        SizedBox(
                          width: 3.5,
                        ),
                        Image.asset(
                          'assets/images/email.png',
                          height: 18,
                          width: 18,
                        )
                      ],
                    ),
                    Text(
                      'Your profile is incomplete',
                      style: TextStyle(color: Colors.white, fontSize: 14),
                    )
                  ],
                ),
              ),
            ),
            SizedBox(
              height: 15,
            ),
            Padding(
                padding: EdgeInsets.only(left: 17),
                child: Row(
                  children: [
                    Text(
                      "List 1",
                      style: TextStyle(
                          color: Color.fromRGBO(162, 0, 76, 1.0),
                          fontSize: 19,
                          fontWeight: FontWeight.w700,
                          letterSpacing: 1),
                    )
                  ],
                )),
            SizedBox(
              height: 16,
            ),
            Align(
              alignment: Alignment.center,
              child: Container(
                width: screenWidth * (359 / 393),
                decoration: BoxDecoration(
                  color: Color.fromRGBO(255, 255, 255, 1.0),
                  borderRadius: BorderRadius.circular(18),
                ),
                child: Column(
                  children: [
                    ListTile(
                      leading: Icon(
                        Icons.calendar_month,
                        size: 24,
                        color: Colors.grey,
                      ),
                      trailing: Switch(
                          value: true,
                          onChanged: null,
                          activeColor: Colors.white60,
                          inactiveTrackColor: Colors.grey),
                      title: Text(
                        '24-Hour Time',
                        style: TextStyle(
                            fontSize: 15, fontWeight: FontWeight.w500),
                      ),
                    ),
                    Divider(),
                    ListTile(
                      onTap: () {
                        Get.to(HistoryPage());
                      },
                      leading: Icon(
                        Icons.calendar_month,
                        size: 24,
                        color: Colors.grey,
                      ),
                      trailing: Icon(
                        Icons.arrow_forward_ios,
                        color: Colors.grey,
                        size: 20,
                      ),
                      title: Text(
                        'History',
                        style: TextStyle(
                            fontSize: 15, fontWeight: FontWeight.w500),
                      ),
                    ),
                    Divider(),
                    ListTile(
                      onTap: () {
                        Get.to(
                          FeedBackPage(),
                        );
                      },
                      leading: Icon(
                        Icons.calendar_month,
                        size: 24,
                        color: Colors.grey,
                      ),
                      trailing: Icon(
                        Icons.arrow_forward_ios,
                        color: Colors.grey,
                        size: 20,
                      ),
                      title: Text(
                        'Feedback',
                        style: TextStyle(
                            fontSize: 15, fontWeight: FontWeight.w500),
                      ),
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
