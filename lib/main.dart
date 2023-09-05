import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:wallperks/api/VideoApiController.dart';
import 'package:wallperks/api/WallpaperApiController.dart';
import 'package:wallperks/view/BottomNavBar.dart';

void main() {
  Get.put(WallpaperApiController());
  Get.put(VideoApiController());
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'WallPerks',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        brightness: Brightness.dark,
        useMaterial3: true,
        textTheme: GoogleFonts.latoTextTheme(
          Theme.of(context).textTheme,
        ),
        fontFamily: 'Lato',
      ),
      themeMode: ThemeMode.system,
      home: const BottomNavBar(),
    );
  }
}
