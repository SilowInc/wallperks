import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:get/get.dart';
import 'package:wallperks/api/WallpaperApiController.dart';

import 'PhotoViewer.dart';

class HomeScreen extends GetView<WallpaperApiController> {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    WallpaperApiController wController = Get.find<WallpaperApiController>();
    return Obx(
      () => Scaffold(
        appBar: AppBar(
          title: const Text('WallPerks'),
          centerTitle: false,
          actions: [
            Text(
              'items (${wController.wallpaperCount})',
              style: const TextStyle(fontSize: 20),
            ),
          ],
        ),
        body: wController.isLoading == false
            ? Padding(
                padding: const EdgeInsets.all(2.0),
                child: StaggeredGridView.countBuilder(
                  crossAxisCount: 2,
                  mainAxisSpacing: 2,
                  crossAxisSpacing: 2,
                  itemCount: wController.wallpapers.length,
                  controller: wController.scrollController,
                  physics: const BouncingScrollPhysics(),
                  itemBuilder: (BuildContext context, int index) {
                    var item = wController.wallpapers[index];
                    return GestureDetector(
                      onTap: () {
                        Get.to(() => PhotoViewer(item.src!.portrait.toString()));
                      },
                      child: Hero(
                        tag: item.src!.portrait.toString(),
                        child: CachedNetworkImage(
                          imageUrl: item.src!.portrait.toString(),
                          placeholder: (context, url) => Container(
                            color: Colors.grey[300],
                          ),
                          errorWidget: (context, url, error) => const Icon(Icons.error),
                          fit: BoxFit.cover,
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
