import 'dart:io';

import 'package:calendar/features/auth/screens/otp_screen.dart';
import 'package:calendar/features/auth/screens/user_details.dart';
import 'package:calendar/features/calendar/screen/calendar_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';

import '../../../data/profile_data/put_data.dart';

class AuthController extends GetxController {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  var isLoading = false.obs;
  var verificationId = ''.obs;
  var errorMessage = ''.obs;
  var phone = ''.obs;
  var selectedDate = Rxn<DateTime>();
  var phoneController = TextEditingController().obs;
  var nameController = TextEditingController().obs;
  var emailController = TextEditingController().obs;
  Rxn<File> profileImage = Rxn<File>();
  final ImagePicker _picker = ImagePicker();

  Future<void> pickImage() async {
    try {
      // Request only necessary permissions
      if (Platform.isAndroid) {
        final status = await Permission.camera.request();
        if (status.isGranted) {
          showImageSourceBottomSheet();
        } else {
          handlePermissionDenied();
        }
      } else {
        // For iOS
        final status = await Permission.camera.request();
        final photosStatus = await Permission.photos.request();

        if (status.isGranted && photosStatus.isGranted) {
          showImageSourceBottomSheet();
        } else {
          handlePermissionDenied();
        }
      }
    } catch (e) {
      print('Error in pickImage: $e');
      Get.snackbar(
        'Error',
        'Failed to handle image picking',
        backgroundColor: Theme.of(Get.context!).primaryColor.withOpacity(0.3),
        snackPosition: SnackPosition.TOP,
        duration: Duration(seconds: 3),
      );
    }
  }

  void showImageSourceBottomSheet() {
    Get.bottomSheet(
      Container(
        color: Theme.of(Get.context!).scaffoldBackgroundColor,
        child: Wrap(
          children: <Widget>[
            ListTile(
              leading: Icon(Icons.photo_library),
              title: Text('Choose from Gallery'),
              onTap: () async {
                Get.back();
                try {
                  final XFile? image = await _picker.pickImage(
                    source: ImageSource.gallery,
                    imageQuality: 70,
                    maxWidth: 1000,
                    maxHeight: 1000,
                  );
                  if (image != null) {
                    profileImage.value = File(image.path);
                  }
                } catch (e) {
                  print('Error picking gallery image: $e');
                  Get.snackbar(
                    'Error',
                    'Failed to pick image from gallery',
                    backgroundColor:
                        Theme.of(Get.context!).primaryColor.withOpacity(0.3),
                    snackPosition: SnackPosition.TOP,
                  );
                }
              },
            ),
            ListTile(
              leading: Icon(Icons.photo_camera),
              title: Text('Take a Photo'),
              onTap: () async {
                Get.back();
                try {
                  final XFile? image = await _picker.pickImage(
                    source: ImageSource.camera,
                    imageQuality: 70,
                    maxWidth: 1000,
                    maxHeight: 1000,
                  );
                  if (image != null) {
                    profileImage.value = File(image.path);
                  }
                } catch (e) {
                  print('Error taking photo: $e');
                  Get.snackbar(
                    'Error',
                    'Failed to take photo',
                    backgroundColor:
                        Theme.of(Get.context!).primaryColor.withOpacity(0.3),
                    snackPosition: SnackPosition.TOP,
                  );
                }
              },
            ),
          ],
        ),
      ),
    );
  }

  void handlePermissionDenied() {
    Get.snackbar(
      'Permission Required',
      'Camera and storage permissions are required to select a profile picture',
      backgroundColor: Theme.of(Get.context!).primaryColor.withOpacity(0.3),
      snackPosition: SnackPosition.TOP,
      duration: Duration(seconds: 3),
    );
  }

  String? validateEmail(String? email) {
    RegExp emailRegExp = RegExp(r'^[\w\.-]+@[\w-]+\.\w{2,3}(\.\w{2,3})?$');
    final isEmailValid = emailRegExp.hasMatch(email ?? '');
    if (!isEmailValid) {
      return 'Please enter a valid email';
    } else {
      return null;
    }
  }

  void clearAllFields() {
    nameController.value.clear();
    emailController.value.clear();
    phoneController.value.clear();
    selectedDate.value = null;
  }

  @override
  void dispose() {
    nameController.value.dispose();
    emailController.value.dispose();
    phoneController.value.dispose();
    super.dispose();
  }

// In AuthController.dart, update the signUp method:

  Future<void> signUp({
    required Color? textColor,
    required bool isLightMode,
  }) async {
    try {
      isLoading.value = true;

      // Validate required fields
      if (nameController.value.text.isEmpty ||
          emailController.value.text.isEmpty ||
          phoneController.value.text.isEmpty ||
          selectedDate.value == null) {
        Get.snackbar(
          'Error',
          'Please fill all required fields',
          backgroundColor:
              Theme.of(Get.context!).primaryColor.withValues(alpha: 0.3),
          colorText: textColor,
          snackPosition: SnackPosition.TOP,
          duration: Duration(seconds: 3),
        );
        return;
      }

      CollectionReference users = FirebaseFirestore.instance.collection('User');
      QuerySnapshot emailQuery = await users
          .where('email', isEqualTo: emailController.value.text)
          .get();

      if (emailQuery.docs.isNotEmpty) {
        Get.snackbar(
          'Signup Failed!',
          'Email already exists',
          backgroundColor:
              Theme.of(Get.context!).primaryColor.withValues(alpha: 0.3),
          colorText: textColor,
          snackPosition: SnackPosition.TOP,
          duration: Duration(seconds: 3),
        );
        return;
      }

      await putData(
        name: nameController.value.text,
        email: emailController.value.text,
        phoneNumber: phone.value,
        dateOfBirth: selectedDate.value,
        profileImage: profileImage.value,
      );

      Get.snackbar(
        'Success!',
        'Registration completed successfully',
        backgroundColor:
            Theme.of(Get.context!).primaryColor.withValues(alpha: 0.3),
        colorText: textColor,
        snackPosition: SnackPosition.TOP,
        duration: Duration(seconds: 3),
      );

      // Clear fields and navigate to homepage
      clearAllFields();
      Get.offAll(
          () => CalendarScreen()); // Using proper navigation with named route
    } catch (e) {
      print(
          '====================================Error in signUp: $e ===================================='); // Added error logging
      Get.snackbar(
        'Error',
        'Something went wrong. Please try again.',
        backgroundColor:
            Theme.of(Get.context!).primaryColor.withValues(alpha: 0.3),
        colorText: textColor,
        snackPosition: SnackPosition.TOP,
        duration: Duration(seconds: 3),
      );
    } finally {
      isLoading.value = false;
    }
  }

  // Method to send OTP
  Future<void> sendOTP({
    required String phoneNumber,
    required Color primaryColor,
    required Color textColor,
  }) async {

    try {
      isLoading.value = true;
      errorMessage.value = '';

      await _auth.verifyPhoneNumber(
        phoneNumber: phoneNumber,
        verificationCompleted: (PhoneAuthCredential credential) async {
          // Auto verification (not used in test mode)
          await _auth.signInWithCredential(credential);
          Get.offAll(
            OTPScreen(
              phoneNumber: phoneNumber,
            ),
            transition: Transition.rightToLeft,
            duration: Duration(milliseconds: 700),
          );
        },
        verificationFailed: (FirebaseAuthException e) {
          isLoading.value = false;
          errorMessage.value = e.message ?? 'Verification Failed';
        },
        codeSent: (String verId, int? resendToken) {
          verificationId.value = verId;
          isLoading.value = false;
          Get.to(
            OTPScreen(
              phoneNumber: phoneNumber,
            ),
          );
          Get.snackbar(
            'Success', // title
            'OTP Sent Successfully',
            // message
            backgroundColor: primaryColor.withValues(alpha: 0.3),
            colorText: textColor,
            snackPosition: SnackPosition.TOP,
            duration: Duration(seconds: 3),
          );
        },
        codeAutoRetrievalTimeout: (String verId) {
          verificationId.value = verId;
          isLoading.value = false;
        },
        timeout: const Duration(seconds: 60),
      );
    } catch (e) {
      Get.snackbar(
        'Failed', // title
        'Failed to send OTP',
        // message
        backgroundColor: primaryColor.withValues(alpha: 0.3),
        colorText: textColor,
        snackPosition: SnackPosition.TOP,
        duration: Duration(seconds: 3),
      );
      isLoading.value = false;
      errorMessage.value = e.toString();
    }
  }

  Future<void> verifyOTP({
    required String otp,
    required Color primaryColor,
    required Color textColor,
  }) async {
    try {
      isLoading.value = true;
      errorMessage.value = '';

      PhoneAuthCredential credential = PhoneAuthProvider.credential(
        verificationId: verificationId.value,
        smsCode: otp,
      );
      await _auth.signInWithCredential(credential);

      CollectionReference users = FirebaseFirestore.instance.collection('User');
      QuerySnapshot phoneQuery =
          await users.where('phoneNumber', isEqualTo: phone.value).get();

      if (phoneQuery.docs.isNotEmpty) {
        Get.snackbar(
          'Success',
          'Successfully logged in',
          backgroundColor: primaryColor.withValues(alpha: 0.3),
          colorText: textColor,
          snackPosition: SnackPosition.TOP,
          duration: Duration(seconds: 3),
        );
        Get.offAll(CalendarScreen());
      } else {
        Get.snackbar(
          'Please SignUp',
          'Enter Your Details',
          backgroundColor: primaryColor.withValues(alpha: 0.3),
          colorText: textColor,
          snackPosition: SnackPosition.TOP,
          duration: Duration(seconds: 3),
        );
        Get.offAll(UserDetails());
      }
      isLoading.value = false;
    } catch (e) {
      Get.snackbar(
        'SignUp Failed',
        'Otp does not match',
        backgroundColor: primaryColor.withValues(alpha: 0.3),
        colorText: textColor,
        snackPosition: SnackPosition.TOP,
        duration: Duration(seconds: 3),
      );
      isLoading.value = false;
      errorMessage.value = e.toString();
    }
  }
}
