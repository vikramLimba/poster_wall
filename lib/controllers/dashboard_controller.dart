import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:poster_wall/ui/screens/favorite_screen.dart';
import 'package:poster_wall/ui/screens/gallary_screen.dart';

class DashboardController extends GetxController {
  RxInt selectedIndex = 0.obs;

  final List<Widget> pages = [GalleryScreen(), FavoriteScreen()];

  void onTabSelected(int index) {
    selectedIndex.value = index;
  }
}
