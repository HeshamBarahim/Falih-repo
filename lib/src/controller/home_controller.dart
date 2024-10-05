import 'package:get/get.dart';

class HomeController extends GetxController {
  // test precentage of progress bar
  var percentage = 0.50.obs;
  var myIndex = 0.obs;

  // test the list images for ads
  final images = [
    'assets/images/test_ads.png',
    'assets/images/test_ads.png',
    'assets/images/test_ads.png',
  ].obs;
}
