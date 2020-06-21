import 'package:belajar_bloc/models/games.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';
import 'package:photo_view/photo_view_gallery.dart';

class DetailImage extends StatelessWidget {
  final List<ShortScreenshot> screenShoots;

  const DetailImage({@required this.screenShoots});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      appBar: AppBar(
        title: Text('Detail Image'),
      ),
      body: Container(
        alignment: Alignment.center,
        child: PhotoViewGallery.builder(
          scrollPhysics: const BouncingScrollPhysics(),
          itemCount: screenShoots.length,
          builder: (context, index) {
            return PhotoViewGalleryPageOptions(
              imageProvider: NetworkImage(screenShoots[index].image),
              initialScale: PhotoViewComputedScale.contained * 0.8,
              heroAttributes:
                  PhotoViewHeroAttributes(tag: screenShoots[index].id),
            );
          },
          loadingBuilder: (context, event) => Center(
            child: Container(
              width: 40,
              height: 40,
              child: CircularProgressIndicator(
                value: event == null
                    ? 0
                    : event.cumulativeBytesLoaded / event.expectedTotalBytes,
              ),
            ),
          ),
        ),
      ),
    ));
  }
}
