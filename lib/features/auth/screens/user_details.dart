import 'package:calendar/features/bottom_navigation_bar/custom_bottom_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../../theme/controller/theme_controller.dart';
import '../controller/auth_controller.dart';

final _formKey = GlobalKey<FormState>();

class UserDetails extends GetView<AuthController> {
  const UserDetails({super.key});

  @override
  Widget build(BuildContext context) {
    final primaryColor = Theme.of(context).primaryColor;
    final textColor = Theme.of(context).textTheme.bodyLarge?.color;
    final isLightMode = Theme.of(context).brightness == Brightness.light;

    Get.put(AuthController()); // Initialize controller
    Get.put(ThemeController()); // Initialize theme controller

    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Form(
                  key: _formKey,
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: 50),
                        Text(
                          'Welcome',
                          style: TextStyle(
                              fontSize: 34,
                              fontWeight: FontWeight.bold,
                              color: textColor),
                        ),

                        const SizedBox(height: 8),
                        Text(
                          'Please provide the following details to login to continue our app',
                          style: TextStyle(
                              color: textColor?.withOpacity(0.5), fontSize: 16),
                        ),
                        const SizedBox(height: 30),
                        Obx(() => Center(
                              child: Stack(
                                children: [
                                  Container(
                                    width: 120,
                                    height: 120,
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      border: Border.all(
                                        color: primaryColor,
                                        width: 2,
                                      ),
                                    ),
                                    child: ClipOval(
                                      child: controller.profileImage.value !=
                                              null
                                          ? Image.file(
                                              controller.profileImage.value!,
                                              fit: BoxFit.cover,
                                            )
                                          : Icon(
                                              Icons.person,
                                              size: 80,
                                              color:
                                                  textColor?.withOpacity(0.5),
                                            ),
                                    ),
                                  ),
                                  Positioned(
                                    bottom: 0,
                                    right: 0,
                                    child: GestureDetector(
                                      onTap: controller.pickImage,
                                      child: Container(
                                        padding: EdgeInsets.all(8),
                                        decoration: BoxDecoration(
                                          color: primaryColor,
                                          shape: BoxShape.circle,
                                        ),
                                        child: Icon(
                                          Icons.camera_alt,
                                          color: Colors.white,
                                          size: 20,
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            )),
                        SizedBox(height: 30),
                        // Name TextField
                        TextFormField(
                          controller: controller.nameController.value,
                          decoration: InputDecoration(
                            labelText: 'Full Name',
                            prefixIcon: Icon(
                              Icons.person,
                              size: 22,
                              color: textColor,
                            ),
                            hintText: 'Full Name',
                            contentPadding: EdgeInsets.symmetric(
                                horizontal: 20, vertical: 18),
                            border: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(12)),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(12)),
                              borderSide:
                                  BorderSide(color: textColor ?? Colors.grey),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(12)),
                              borderSide:
                                  BorderSide(color: primaryColor, width: 2),
                            ),
                          ),
                          validator: (name) => name!.length < 3
                              ? 'Name should be at least 3 characters'
                              : null,
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                        ),
                        const SizedBox(height: 20),
                        // Email TextField
                        TextFormField(
                          controller: controller.emailController.value,
                          decoration: InputDecoration(
                            labelText: 'Email',
                            prefixIcon: Icon(
                              Icons.email,
                              size: 22,
                              color: textColor,
                            ),
                            hintText: 'Email',
                            contentPadding: EdgeInsets.symmetric(
                                horizontal: 20, vertical: 18),
                            border: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(12)),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(12)),
                              borderSide:
                                  BorderSide(color: textColor ?? Colors.grey),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(12)),
                              borderSide:
                                  BorderSide(color: primaryColor, width: 2),
                            ),
                          ),
                          validator: controller.validateEmail,
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                        ),
                        const SizedBox(height: 20),
                        // Date of Birth TextField
                        Obx(
                          () => TextFormField(
                            readOnly: true,
                            decoration: InputDecoration(
                              labelText: 'Date of Birth',
                              prefixIcon: Icon(
                                Icons.calendar_month,
                                size: 22,
                                color: textColor,
                              ),
                              hintText: controller.selectedDate.value == null
                                  ? 'Select Date of Birth'
                                  : DateFormat('dd/MM/yyyy')
                                      .format(controller.selectedDate.value!),
                              contentPadding: EdgeInsets.symmetric(
                                  horizontal: 20, vertical: 18),
                              border: OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(12)),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(12)),
                                borderSide:
                                    BorderSide(color: textColor ?? Colors.grey),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(12)),
                                borderSide:
                                    BorderSide(color: primaryColor, width: 2),
                              ),
                            ),
                            onTap: () async {
                              final DateTime? picked = await showDatePicker(
                                context: context,
                                initialDate: DateTime.now()
                                    .subtract(const Duration(days: 6570)),
                                firstDate: DateTime(1900),
                                lastDate: DateTime.now(),
                                builder: (context, child) {
                                  return Theme(
                                    data: Theme.of(context).copyWith(
                                      colorScheme: ColorScheme.light(
                                        primary: primaryColor,
                                      ),
                                    ),
                                    child: child!,
                                  );
                                },
                              );
                              if (picked != null) {
                                controller.selectedDate.value = picked;
                              }
                            },
                            validator: (value) =>
                                controller.selectedDate.value == null
                                    ? 'Please select your date of birth'
                                    : null,
                            autovalidateMode:
                                AutovalidateMode.onUserInteraction,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),

            Obx(
              () => SizedBox(
                height: Get.height * 0.072,
                child: ElevatedButton(
                  onPressed: () {
                    Get.to(CustomBottomNavigationBar());
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: primaryColor,
                    minimumSize: const Size.fromHeight(50),
                    shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.zero,
                    ),
                  ),
                  child: controller.isLoading.value
                      ? CircularProgressIndicator(
                          color: Colors
                              .white, // Changed to white for better visibility on colored button
                        )
                      : const Text(
                          'Register',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                          ),
                        ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
