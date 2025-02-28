import 'package:calendar/features/auth/screens/user_details.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pinput/pinput.dart';

import '../../../custom_widgets/custom_appbar.dart';
import '../controller/auth_controller.dart';

class OTPScreen extends StatelessWidget {
  final AuthController _authController = Get.put(AuthController());
  final String phoneNumber;

  OTPScreen({
    super.key,
    required this.phoneNumber,
  });

  @override
  Widget build(BuildContext context) {
    final primaryColor = Theme.of(context).primaryColor;
    final textColor = Theme.of(context).textTheme.bodyLarge?.color;

    final defaultPinTheme = PinTheme(
      width: 50,
      height: 50,
      textStyle: TextStyle(
        fontSize: 20,
        color: textColor,
        fontWeight: FontWeight.w600,
      ),
      decoration: BoxDecoration(
        color: textColor?.withOpacity(0.05),
        borderRadius: BorderRadius.circular(12),
      ),
    );

    return Scaffold(
      appBar: CustomAppbar(title: 'OTP Verification'),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Padding(
                  padding: EdgeInsets.only(
                    left: 24,
                    right: 24,
                    bottom: MediaQuery.of(context).viewInsets.bottom,
                  ),
                  child: Column(
                    children: [
                      SizedBox(height: Get.height * 0.05),
                      Image.asset(
                        'assets/images/forget_password_screen_icon.png',
                        height: Get.height * 0.15,
                        alignment: Alignment.center,
                      ),
                      const SizedBox(height: 40),
                      Text(
                        'Enter OTP',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: textColor,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        'We have send you a code to verify your phone number',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: textColor?.withOpacity(0.6),
                        ),
                      ),
                      const SizedBox(height: 32),
                      Pinput(
                        length: 6,
                        defaultPinTheme: defaultPinTheme,
                        focusedPinTheme: defaultPinTheme.copyWith(
                          decoration: defaultPinTheme.decoration?.copyWith(
                            border: Border.all(color: primaryColor, width: 2),
                          ),
                        ),
                        onCompleted: (pin) => _authController.verifyOTP(
                          otp: pin,
                          primaryColor: primaryColor,
                          textColor: textColor!,
                        ),
                      ),
                      const SizedBox(height: 24),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "Didn't you receive the OTP? ",
                            style: TextStyle(
                              color: textColor?.withOpacity(0.6),
                            ),
                          ),
                          Obx(() => TextButton(
                                onPressed: _authController.isLoading.value
                                    ? null
                                    : () => _authController.sendOTP(
                                          phoneNumber: phoneNumber,
                                          primaryColor: primaryColor,
                                          textColor: textColor!,
                                        ),
                                child: Text(
                                  'Resend OTP',
                                  style: TextStyle(
                                    color: primaryColor,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              )),
                        ],
                      ),
                      SizedBox(height: Get.height * 0.1),
                    ],
                  ),
                ),
              ),
            ),
            Obx(
              () => SizedBox(
                height: Get.height * 0.072,
                child: ElevatedButton(
                  onPressed: () {
                    Get.to(UserDetails(),transition: Transition.leftToRight,duration: Duration(milliseconds: 900),);
                  }, //_authController.isLoading.value ? null : () {},
                  style: ElevatedButton.styleFrom(
                    backgroundColor: primaryColor,
                    minimumSize: const Size.fromHeight(50),
                    shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.zero,
                    ),
                  ),
                  child: _authController.isLoading.value
                      ? CircularProgressIndicator(
                          color: primaryColor,
                        )
                      : const Text(
                          'Confirm',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                          ),
                        ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
