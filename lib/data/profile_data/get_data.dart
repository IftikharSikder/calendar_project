import 'package:cloud_firestore/cloud_firestore.dart';

Future<Map<String, dynamic>?> getUserDataByEmail(String email) async {
  try {
    CollectionReference users = FirebaseFirestore.instance.collection('User');
    QuerySnapshot querySnapshot =
        await users.where('email', isEqualTo: email).limit(1).get();

    if (querySnapshot.docs.isEmpty) {
      return null;
    }
    Map<String, dynamic> userData =
        querySnapshot.docs.first.data() as Map<String, dynamic>;
    return {
      'name': userData['name'] ?? '',
      'email': userData['email'] ?? '',
      'phoneNumber': userData['phoneNo'] ?? '',
    };
  } catch (e) {
    print('Error fetching user data: $e');
    return null;
  }
}
