import 'package:get/get.dart';

class TopNavBarController extends GetxController {
  final _selectedIndex = 2.obs;

  get selectedIndex => _selectedIndex.value;

  void changeIndex(int index) {
    _selectedIndex.value = index;
  }
}
