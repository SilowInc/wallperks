import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';

class PhotoViewer extends StatefulWidget {
  final String imageUrl;
  const PhotoViewer(this.imageUrl, {super.key});

  @override
  State<PhotoViewer> createState() => _PhotoViewerState();
}

class _PhotoViewerState extends State<PhotoViewer> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        elevation: 0,
      ),
      body: SizedBox(
        height: double.infinity,
        child: Hero(
          tag: widget.imageUrl,
          child: PhotoView(
            imageProvider: NetworkImage(widget.imageUrl),
          ),
        ),
      ),
    );
  }
}
