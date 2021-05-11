
import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';

import '../shared/util.dart';

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
