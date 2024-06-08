import 'package:flutter/material.dart';

class VideoPaths {
  static ValueNotifier<List<String>> paths = ValueNotifier([]);
  static ValueNotifier<bool> isLoading = ValueNotifier(true);

  static void updatePaths(List<String> newPaths) {
    paths.value = newPaths;
    isLoading.value = false;
    print(paths.value[0] +" " + paths.value[1]);
    print(paths.value[3] +" " + paths.value[4]);
    print(paths.value[6] +" " + paths.value[7]);
    print("------------------------------------");
    print("------------------------------------");
  }

  static void setLoading(bool loading) {
    isLoading.value = loading;
  }
}
