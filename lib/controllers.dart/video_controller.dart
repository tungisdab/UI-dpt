import 'package:get/get.dart';

class VideoController extends GetxController {
  var path = "".obs;
  
  void updatePaths (String newPath) {
    path.value = newPath;
  }
}