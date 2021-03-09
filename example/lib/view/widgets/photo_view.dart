import 'package:cached_network_image/cached_network_image.dart';
import 'package:example/view/shared/util.dart';
import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';

class PhotoViewWidget extends StatefulWidget {
  final String img;
  PhotoViewWidget({this.img});
  @override
  _PhotoViewWidgetState createState() => _PhotoViewWidgetState();
}

class _PhotoViewWidgetState extends State<PhotoViewWidget> {
  @override
  Widget build(BuildContext context) {
    Size size = Util.getSize(context);
    return Scaffold(
      body: PhotoView(
        imageProvider: NetworkImage(widget.img),
      ),
    );
  }
}
