import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CustomAppbar extends StatelessWidget implements PreferredSizeWidget {
  CustomAppbar({super.key, required this.title});
  String title = '';
  @override
  Widget build(BuildContext context) {
    final isLightMode = Theme.of(context).brightness == Brightness.light;

    return PreferredSize(
      preferredSize: const Size.fromHeight(56),
      child: AppBar(
        centerTitle: true,
        title: Text(
          title,
          style: TextStyle(
            fontFamily: 'DM Sans',
            fontWeight: FontWeight.w700,
            fontSize: 20,
          ),
        ),
        leading: Container(
          margin: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: isLightMode ? Color(0xFFF5F7FA) : Colors.grey,
            borderRadius: BorderRadius.circular(20),
          ),
          child: IconButton(
            icon: Icon(
              Icons.arrow_back,
              size: 24,
              color: isLightMode ? Colors.black : Colors.white,
              weight: 500,
            ),
            onPressed: () => Get.back(),
          ),
        ),
      ),
    );
  }

  @override
  Size get preferredSize => Size(MediaQuery.of(Get.context!).size.width, 56);
}
