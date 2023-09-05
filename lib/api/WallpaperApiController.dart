import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:wallperks/Model/WallpaperModel.dart';

class WallpaperApiController extends GetxController {
  ///services
  final GetConnect connect = Get.put(GetConnect());

  ///variables
  final Rx<WallpaperModel> _wallpapers = WallpaperModel().obs;
  final Rx<WallpaperModel> _currentWallpapersResponse = WallpaperModel().obs;
  final Rx<WallpaperModel> _searchWallpapers = WallpaperModel().obs;
  final ScrollController scrollController = ScrollController();
  final RxInt _currentNavigationIndex = 0.obs;
  final RxInt _pageNo = 1.obs;
  final RxInt _perPageData = 20.obs;
  final RxInt _searchPerPage = 10.obs;
  final RxString _query = ''.obs;
  final RxInt _wallpapersLength = 0.obs;

  /// getters
  int get currentIndex => _currentNavigationIndex.value;
  int get wallpaperCount => _wallpapersLength.value;
  List<Photos> get wallpapers => _wallpapers.value.photos!;
  List<Photos> get searchWallpapers => _searchWallpapers.value.photos!;
  bool get isLoading => _wallpapers.value.photos == null ? true : false;
  bool get isSearchWallpaperEmpty => _searchWallpapers.value.photos == null ? true : false;

  ///setters
  set setNavigationIndex(index) => _currentNavigationIndex.value = index;
  set setQuery(String value) => _query.value = value;

  /// get wallpapers api
  getWallpapers() async {
    try {
      Response response = await connect.get('https://api.pexels.com/v1/curated?page=$_pageNo&per_page=$_perPageData',
          headers: {'Authorization': "gd2me73qDWOYifSnm1S4zCxqBei2aiCjTyqJv1G9ttpuQmP0j6r0AnuS"});
      if (response.statusCode == 200) {
        _currentWallpapersResponse.value = WallpaperModel.fromJson(response.body);
        if (_wallpapers.value.photos == null) {
          _wallpapers.value = _currentWallpapersResponse.value;
          for (var value in _currentWallpapersResponse.value.photos!) {
            _wallpapersLength.value++;
          }
        } else {
          for (var value in _currentWallpapersResponse.value.photos!) {
            _wallpapersLength.value++;
          }
          _wallpapers.value.photos!.addAll(_currentWallpapersResponse.value.photos!);
        }
      } else {
        log('Request failed with status: ${response.body}');
      }
    } catch (e) {
      ErrorWidget(e.toString());
    }
  }

  searchWallpaperApi() async {
    try {
      Response response = await connect.get('https://api.pexels.com/v1/search?query=$_query&per_page=$_searchPerPage',
          headers: {'Authorization': "gd2me73qDWOYifSnm1S4zCxqBei2aiCjTyqJv1G9ttpuQmP0j6r0AnuS"});
      if (response.statusCode == 200) {
        _searchWallpapers.value = WallpaperModel.fromJson(response.body);
      } else {
        log('Request failed with status: ${response.body}');
      }
    } catch (e) {
      ErrorWidget(e.toString());
    }
  }

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    getWallpapers();
    scrollController.addListener(() async {
      if (scrollController.position.pixels == scrollController.position.maxScrollExtent) {
        _pageNo.value++;
        await getWallpapers();
      }
    });
  }

  void clearSearch() {
    _searchWallpapers.value = WallpaperModel();
  }
}
