import 'package:cloud_9_agent/models/image.dart';
import 'package:flutter/material.dart';


class MediaPreviewPage extends StatelessWidget {
  final ServiceImage media;

  const MediaPreviewPage({Key key, @required this.media}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Text(''),
        actions: [
          IconButton(icon: Icon(Icons.star_border), onPressed: () {}),
          IconButton(icon: Icon(Icons.share), onPressed: () {}),
          IconButton(icon: Icon(Icons.more_vert), onPressed: () {})
        ],
      ),
      backgroundColor: Colors.black,
      body: Center(
          child: Hero(
        tag: media.url,
        child: Image.network(media.url),
      )),
    );
  }
}
