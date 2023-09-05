import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:get/get.dart';
import 'package:video_player/video_player.dart';
import 'package:wallperks/api/VideoApiController.dart';

class VideoListScreen extends GetView<VideoApiController> {
  const VideoListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    VideoApiController vController = Get.find<VideoApiController>();
    return Obx(
      () => Scaffold(
        appBar: AppBar(
          title: const Text('Videos'),
          centerTitle: false,
          actions: [
            Text(
              'items (${vController.videoCount})',
              style: const TextStyle(fontSize: 20),
            ),
          ],
        ),
        body: vController.isLoading == false
            ? Padding(
                padding: const EdgeInsets.all(2.0),
                child: StaggeredGridView.countBuilder(
                  crossAxisCount: 2,
                  mainAxisSpacing: 2,
                  crossAxisSpacing: 2,
                  itemCount: vController.videos.length,
                  controller: vController.scrollController,
                  physics: const BouncingScrollPhysics(),
                  itemBuilder: (BuildContext context, int index) {
                    var item = vController.videos[index];
                    return GestureDetector(
                      onTap: () {
                        Get.to(() => VideoFullScreen(videoPlayerController: item.videoPlayerController!));
                      },
                      child: Hero(
                        tag: item.url!,
                        child: Stack(
                          fit: StackFit.expand,
                          children: [
                            CachedNetworkImage(
                              imageUrl: item.image!.toString(),
                              placeholder: (context, url) => Container(
                                color: Colors.grey[300],
                              ),
                              errorWidget: (context, url, error) => const Icon(Icons.error),
                              fit: BoxFit.cover,
                            ),
                            const Positioned(
                              top: 10,
                              right: 10,
                              child: Icon(
                                Icons.play_circle_fill,
                              ),
                            )
                          ],
                        ),
                      ),
                    );
                  },
                  staggeredTileBuilder: (int index) => StaggeredTile.count(1, index.isEven ? 1 : 2),
                ),
              )
            : const Center(child: CircularProgressIndicator()),
      ),
    );
  }
}

class VideoFullScreen extends StatelessWidget {
  final VideoPlayerController videoPlayerController;

  const VideoFullScreen({super.key, required this.videoPlayerController});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: videoPlayerController.value.isInitialized
              ? AspectRatio(
                  aspectRatio: videoPlayerController.value.aspectRatio,
                  child: VideoPlayer(videoPlayerController),
                )
              : const Center(child: CircularProgressIndicator()),
        ),
      ),
    );
  }
}
