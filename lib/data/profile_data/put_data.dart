import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';

Future<void> putData({
  required String name,
  required String email,
  required String phoneNumber,
  required DateTime? dateOfBirth,
  File? profileImage, // New parameter
}) async {
  try {
    if (name.isEmpty || email.isEmpty || phoneNumber.isEmpty) {
      throw ArgumentError('Required fields cannot be empty');
    }

    CollectionReference users = FirebaseFirestore.instance.collection('User');
    String? profileImageUrl;

    if (profileImage != null) {
      final storageRef = FirebaseStorage.instance.ref();
      final imageRef = storageRef.child(
          'profile_images/${DateTime.now().millisecondsSinceEpoch}_${email}');

      await imageRef.putFile(profileImage);
      profileImageUrl = await imageRef.getDownloadURL();
    }

    final userData = {
      'name': name.trim(),
      'email': email.trim().toLowerCase(),
      'phoneNumber': phoneNumber.trim(),
      'dateOfBirth': dateOfBirth?.toIso8601String(),
      'profileImageUrl': profileImageUrl,
      'createdAt': FieldValue.serverTimestamp(),
      'updatedAt': FieldValue.serverTimestamp(),
    };

    await users.add(userData);
    print(
        'User data successfully stored in Firebase: $userData ==============================');
  } catch (e) {
    print('Error adding user to Firebase: $e');
    throw Exception(
        'Failed to store user data: $e ======================================');
  }
}
