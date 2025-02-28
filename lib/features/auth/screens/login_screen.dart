import 'package:calendar/features/auth/screens/otp_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl_phone_field/intl_phone_field.dart';

import '../../../theme/controller/theme_controller.dart';
import '../controller/auth_controller.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final GlobalKey<FormState> _formKey =
      GlobalKey<FormState>(); // Ensuring it is properly initialized
  late ThemeController themeController;
  late AuthController controller;

  @override
  void initState() {
    super.initState();
    themeController = Get.put(ThemeController());
    controller = Get.put(AuthController());
  }

  @override
  Widget build(BuildContext context) {
    final isLightMode = Theme.of(context).brightness == Brightness.light;
    final primaryColor = Theme.of(context).primaryColor;
    final textColor = Theme.of(context).textTheme.bodyLarge?.color;

    return Scaffold(
      body: SafeArea(
        child: Form(
          key: _formKey, // Ensuring Form key is attached properly
          child: Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: 24.0, vertical: 24.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: Get.height * 0.05),
                Align(
                  alignment: Alignment.center,
                  child: Image.asset(
                    'assets/images/forget_password_screen_icon.png',
                    height: Get.height * 0.2,
                  ),
                ),
                const SizedBox(height: 40),
                Text(
                  'Welcome',
                  style: TextStyle(
                      fontSize: 34,
                      fontWeight: FontWeight.bold,
                      color: textColor),
                ),
                const SizedBox(height: 8),
                Text(
                  'Please login to continue our app',
                  style: TextStyle(
                      color: textColor?.withOpacity(0.5), fontSize: 16),
                ),
                const SizedBox(height: 36),

                /// Phone Input Field
                IntlPhoneField(
                  keyboardType: TextInputType.phone,
                  focusNode: FocusNode(),
                  dropdownTextStyle: const TextStyle(fontSize: 18),
                  style: const TextStyle(fontSize: 18),
                  dropdownIcon: Icon(Icons.arrow_drop_down,
                      size: 28, color: primaryColor),
                  decoration: InputDecoration(
                    labelText: 'Phone Number',
                    contentPadding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 18),
                    border: const OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(12))),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: const BorderRadius.all(Radius.circular(12)),
                      borderSide: BorderSide(color: textColor ?? Colors.grey),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: const BorderRadius.all(Radius.circular(12)),
                      borderSide: BorderSide(color: primaryColor, width: 2),
                    ),
                  ),
                  initialCountryCode: 'BD',
                  controller: controller.phoneController.value,
                  onChanged: (phone) {
                    controller.phone.value = phone.completeNumber;
                  },
                  validator: (phone) {
                    if (phone == null || phone.number.isEmpty) {
                      return 'Phone number is required';
                    }
                    return null;
                  },
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                ),

                const SizedBox(height: 20),

                /// Submit Button
                Obx(
                  () => ElevatedButton(
                    onPressed: () {
                      Get.to(OTPScreen(phoneNumber: ''),transition: Transition.fadeIn,duration: Duration(milliseconds: 600),);
                    },
                    // onPressed: controller.isLoading.value
                    //     ? null
                    //     : () {
                    //         if (_formKey.currentState != null &&
                    //             _formKey.currentState!.validate() &&
                    //             controller.phone.value.isNotEmpty) {
                    //           controller.sendOTP(
                    //             phoneNumber: controller.phone.value,
                    //             primaryColor: primaryColor,
                    //             textColor: textColor!,
                    //           );
                    //         } else {
                    //           Get.snackbar(
                    //             'Error',
                    //             'Invalid phone number',
                    //             backgroundColor: primaryColor.withOpacity(0.3),
                    //             colorText: textColor,
                    //           );
                    //         }
                    //       },
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.all(4),
                      backgroundColor: primaryColor,
                      minimumSize: const Size.fromHeight(50),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10)),
                    ),
                    child: controller.isLoading.value
                        ? CircularProgressIndicator(
                            color: isLightMode ? primaryColor : Colors.black)
                        : Text(
                            'Send OTP',
                            style: TextStyle(
                              fontSize: 16,
                              color: isLightMode ? Colors.white : Colors.black,
                            ),
                          ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
