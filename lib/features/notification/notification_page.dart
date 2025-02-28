import 'package:calendar/custom_widgets/custom_appbar.dart';
import 'package:flutter/material.dart';

class NotificationPage extends StatelessWidget {
  const NotificationPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppbar(title: 'Notification'),
      body: ListView(
        children: [
          _buildSectionHeader("Today"),
          UserList(context, 'assets/ok.png'),
          UserList(context, 'assets/wait.png'),
          SelectUserList(context, 'assets/ok2.png'),
          UserList(context, 'assets/wait.png'),
          UserList(context, 'assets/ok.png'),
          UserList(context, 'assets/wait.png'),
        ],
      ),
    );
  }

  Widget SelectUserList(BuildContext context, String ImagePath) {
    double screenWidth = MediaQuery.of(context).size.width;
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      child: Row(
        //crossAxisAlignment: CrossAxisAlignment.center, // Aligns items properly
        children: [
          Padding(
            padding: EdgeInsets.only(bottom: 140),
            child: Image.asset(
              ImagePath,
              height: screenWidth * 0.14, // Responsive image size
              width: screenWidth * 0.14,
            ),
          ),
          SizedBox(width: 20), // Reduce space slightly

          Expanded(
            child: Column(
              crossAxisAlignment:
                  CrossAxisAlignment.start, // Align text to left
              children: [
                RichText(
                  text: TextSpan(
                    style: TextStyle(fontSize: 16, color: Colors.black),
                    children: [
                      TextSpan(
                        text: 'Monica',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 17),
                      ),
                      TextSpan(
                          text: ' created a ', style: TextStyle(fontSize: 17)),
                      TextSpan(
                        text: 'Poll',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 17),
                      ),
                      TextSpan(
                          text: ' please click ',
                          style: TextStyle(fontSize: 17)),
                      TextSpan(text: '.'),
                    ],
                  ),
                ),
                SizedBox(height: 7),
                Text(
                  "Preferred Meeting Time",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                ),
                SizedBox(height: 7),
                Container(
                    height: 120,
                    width: 294,
                    decoration: BoxDecoration(
                        color: Color.fromRGBO(241, 204, 221, 1),
                        borderRadius: BorderRadius.circular(7)),
                    child: Padding(
                      padding: EdgeInsets.all(10),
                      child: Column(
                        children: [
                          pollOption(false, "Morning ( 9 AM - 12 AM )"),
                          pollOption(true, "Afternoon ( 1 AM - 3 AM )"),
                          pollOption(false, "Evening ( 5 AM - 7 AM )"),
                        ],
                      ),
                    )), // Reduce extra space

                /// Make Row responsive
                SizedBox(
                  height: 5,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Friday, 2:30 PM',
                      style: TextStyle(fontSize: 12, color: Colors.black54),
                      overflow: TextOverflow.ellipsis, // Prevents text overflow
                    ),
                    Padding(
                      padding: EdgeInsets.only(right: 10),
                      child: Text(
                        "12 Feb, 2025",
                        style: TextStyle(fontSize: 12, color: Colors.black54),
                        overflow: TextOverflow.ellipsis,
                      ),
                    )
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
    ;
  }

  Widget pollOption(bool selected, String text) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        children: [
          Icon(
            selected ? Icons.check_box : Icons.check_box_outline_blank,
            color: selected ? Colors.pink : Colors.black54,
          ),
          SizedBox(width: 8),
          Text(
            text,
            style: TextStyle(fontSize: 14, color: Colors.black),
          ),
        ],
      ),
    );
  }
}

Widget UserList(BuildContext context, String ImagePath) {
  double screenWidth = MediaQuery.of(context).size.width;
  return Container(
    height: 80,
    width: 404,
    padding: EdgeInsets.symmetric(horizontal: 16, vertical: 10),
    // Adjust padding dynamically
    child: Row(
      children: [
        Padding(
          padding: EdgeInsets.only(top: 10, bottom: 10),
          child: Image.asset(ImagePath,
              height: screenWidth * 0.14, // Responsive image size
              width: screenWidth * 0.14),
        ),
        SizedBox(width: 20),
        Flexible(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              RichText(
                text: TextSpan(
                  style: TextStyle(fontSize: 16, color: Colors.black),
                  children: [
                    TextSpan(
                      text: 'Monica',
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 17),
                    ),
                    TextSpan(
                        text: ' sends a portfolio to ',
                        style: TextStyle(fontSize: 17)),
                    TextSpan(
                      text: 'Company',
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 17),
                    ),
                    TextSpan(
                      text: '.',
                    ),
                  ],
                ),
              ),
              SizedBox(height: 6.5), // Space between message & date-time
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Friday, 2:30 PM',
                    style: TextStyle(fontSize: 12, color: Colors.black54),
                    overflow: TextOverflow.ellipsis, // Prevents text overflow
                  ),
                  Padding(
                    padding: EdgeInsets.only(right: 10),
                    child: Text(
                      "12 Feb, 2025",
                      style: TextStyle(fontSize: 12, color: Colors.black54),
                      overflow: TextOverflow.ellipsis,
                    ),
                  )
                ],
              ),
            ],
          ),
        )
      ],
    ),
  );
}

Widget _buildSectionHeader(String title) {
  return Container(
    height: 50,
    width: double.infinity,
    color: Color(0xFFE0E9EE),
    child: Align(
      alignment: Alignment.centerLeft,
      child: Padding(
        padding: EdgeInsets.only(left: 15),
        child: Text(
          title,
          style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w800,
              color: Colors.black87,
              letterSpacing: 1),
        ),
      ),
    ),
  );
}
