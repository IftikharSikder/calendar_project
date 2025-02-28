import 'package:calendar/custom_widgets/custom_appbar.dart';
import 'package:flutter/material.dart';

class StorePage extends StatelessWidget {
  const StorePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFE0E9EE),
      appBar: CustomAppbar(title: 'Store'),
      body: Center(
        child: Text(
          'Store Page',
          style: TextStyle(fontSize: 30),
        ),
      ),
    );
  }
}
