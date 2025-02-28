import 'package:calendar/custom_widgets/custom_appbar.dart';
import 'package:flutter/Material.dart';

class HistoryPage extends StatelessWidget {
  const HistoryPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(245, 247, 250, 1), //softBlueGray,
      appBar: CustomAppbar(title: 'History'),
      body: ListView(
        children: [
          _buildSectionHeader("Today"),
          GestureDetector(
            child: _buildHistoryCard(
              icon: Icons.calendar_today,
              title: "Bill pay reminder",
              date: "11 Feb, 2025",
              description: "You have a bill due on 20th February, 2025",
              extraText: "Coming Soon",
            ),
            onTap: () {
              showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return _ShowDialog(context);
                  });
            },
          ),
          _buildHistoryCard(
            icon: Icons.poll,
            title: "Poll Participation",
            date: "11 Feb, 2025",
            description: "You voted on the new design features poll.",
            extraText: "2 weeks ago",
          ),
          _buildHistoryCard(
            icon: Icons.event,
            title: "Event Reminder",
            date: "11 Feb, 2025",
            description: "Meeting with team at 3.00 PM",
            extraText: "3 days ago",
          ),
          SizedBox(height: 15),
          _buildSectionHeader("Yesterday"),
          _buildHistoryCard(
            icon: Icons.calendar_today,
            title: "Bill pay reminder",
            date: "11 Feb, 2025",
            description: "You have a bill due on 20th February, 2025",
            extraText: "Coming Soon",
          ),
          _buildHistoryCard(
            icon: Icons.poll,
            title: "Poll Participation",
            date: "11 Feb, 2025",
            description: "You voted on the new design features poll.",
            extraText: "2 weeks ago",
          ),
        ],
      ),
    );
  }

  Widget _buildHistoryCard({
    required IconData icon,
    required String title,
    required String date,
    required String description,
    required String extraText,
  }) {
    return Padding(
        padding: EdgeInsets.only(
          top: 20,
          left: 20,
          right: 20,
        ),
        child: Container(
          decoration: BoxDecoration(
              color: Colors.white, borderRadius: BorderRadius.circular(8)),
          height: 103,
          width: 353,
          child: Padding(
            padding: const EdgeInsets.symmetric(
                horizontal: 12, vertical: 12), // Ensures spacing
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Icon(icon, size: 24, color: Colors.black), // Leading icon
                SizedBox(width: 10), // Space between icon and text
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            title,
                            style: TextStyle(
                                fontSize: 16, fontWeight: FontWeight.w600),
                          ),
                          Text(
                            date,
                            style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w400,
                                color: Colors.black54),
                          ),
                        ],
                      ),
                      SizedBox(height: 5.5), // Small spacing
                      Text(
                        description,
                        style: TextStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.w400,
                            color: Colors.black54),
                      ),
                      SizedBox(height: 5),
                      Text(
                        extraText,
                        style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w500,
                            color: Color.fromRGBO(162, 0, 76, 1.0)),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ));
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

  Widget _ShowDialog(BuildContext context) {
    return AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        contentPadding: EdgeInsets.all(20),
        content: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Coming Soon",
                    style: TextStyle(
                        color: Color.fromRGBO(162, 0, 76, 1.0),
                        fontSize: 16,
                        fontWeight: FontWeight.w600),
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.of(context).pop();
                    },
                    child: Icon(Icons.close, size: 20, color: Colors.black),
                  ),
                ],
              ),
              SizedBox(height: 6),

              // Title
              Text(
                "Bill Pay Reminder",
                style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.black),
              ),
              SizedBox(height: 8),

              // Description
              Text(
                "Lorem ipsum,\n\n"
                "Ut porttitor libero sit amet diam ultrices, ac molestie urna tincidunt. Donec magna enim, viverra eu lacinia sit amet, ultrices ac ex. Etiam sit amet tellus rutrum, tincidunt eros vitae, accumsan est.\n\n"
                "Phasellus facilisis lorem eu fringilla fringilla. Nam et est tellus. Sed venenatis, risus quis vulputate cursus, arcu est auctor nibh, porta fringilla velit justo vel justo.\n\n"
                "Nam in dui et ex dictum aliquam. Class aptent taciti sociosqu ad litora torquent per conubia nostra, per inceptos himenaeos.\n\n"
                "Sed venenatis, risus quis vulputate cursus, arcu est auctor nibh."
                "",
                style:
                    TextStyle(fontSize: 14, color: Colors.black87, height: 1.5),
              ),
            ],
          ),
        ));
  }
}
