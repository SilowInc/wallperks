import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wallperks/api/WallpaperApiController.dart';

import 'HomeScreen.dart';
import 'SearchScreen.dart';
import 'VideoListScreen.dart';

class BottomNavBar extends GetView<WallpaperApiController> {
  const BottomNavBar({super.key});
  @override
  Widget build(BuildContext context) {
    WallpaperApiController wc = Get.find<WallpaperApiController>();
    return Obx(
      () => Scaffold(
        body: wc.currentIndex == 0
            ? const HomeScreen()
            : wc.currentIndex == 1
                ? const SearchScreen()
                : wc.currentIndex == 2
                    ? const VideoListScreen()
                    : const HomeScreen(),
        bottomNavigationBar: BottomNavigationBar(
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.search),
              label: 'Search',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.video_library_sharp),
              label: 'Videos',
            ),
          ],
          currentIndex: wc.currentIndex,
          onTap: (v) => wc.setNavigationIndex = v,
        ),
      ),
    );
  }
}
