import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:wallperks/Model/VideoModel.dart';

class VideoApiController extends GetxController {
  ///services
  final GetConnect connect = Get.put(GetConnect());

  ///variables
  final Rx<VideoModel> _videoModel = VideoModel().obs;
  final Rx<VideoModel> _currentVideosResponse = VideoModel().obs;
  final ScrollController scrollController = ScrollController();
  final RxInt _pageNo = 1.obs;
  final RxInt _perPageData = 8.obs;
  final RxInt _videoCount = 0.obs;

  /// getters
  List<Videos> get videos => _videoModel.value.videos!;
  bool get isLoading => _videoModel.value.videos == null ? true : false;
  int get videoCount => _videoCount.value;

  getVideosApi() async {
    try {
      Response response = await connect.get(
          'https://api.pexels.com/videos/popular?per_page=$_perPageData&page=$_pageNo',
          headers: {'Authorization': "gd2me73qDWOYifSnm1S4zCxqBei2aiCjTyqJv1G9ttpuQmP0j6r0AnuS"});
      if (response.statusCode == 200) {
        _currentVideosResponse.value = VideoModel.fromJson(response.body);
        if (_videoModel.value.videos == null) {
          _videoModel.value = _currentVideosResponse.value;
          for (var value in _currentVideosResponse.value.videos!) {
            _videoCount.value++;
          }
        } else {
          for (var value in _currentVideosResponse.value.videos!) {
            _videoCount.value++;
          }
          _videoModel.value.videos!.addAll(_currentVideosResponse.value.videos!);
        }
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
    getVideosApi();
    scrollController.addListener(() async {
      if (scrollController.position.pixels == scrollController.position.maxScrollExtent) {
        _pageNo.value++;
        await getVideosApi();
      }
    });
  }
}
