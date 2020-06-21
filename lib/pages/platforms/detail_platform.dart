import 'package:belajar_bloc/models/games.dart';
import 'package:belajar_bloc/pages/trailers/game_trailers_page.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:belajar_bloc/utils/functions/generalFunction.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:intl/intl.dart';

import 'detail_image_screenShot.dart';

class DetailPlatformPage extends StatelessWidget {
  final Result selectedGame;
  final PlatformElement selectedPlatform;
  DetailPlatformPage(this.selectedGame, this.selectedPlatform);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      appBar: AppBar(
          title: Text(
              '${selectedGame.name} - ${selectedPlatform.platform.name} ')),
      body: Container(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        "${selectedPlatform.platform.name}",
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        "Released at ${DateFormat("d-MMMM-yyyy").format(selectedPlatform?.releasedAt) ?? '[null]'}",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: <Widget>[
                      Container(
                        width: 35,
                        height: 35,
                        child: GeneralFunction.getPlatformIcon(
                            selectedPlatform.platform.id),
                      ),
                      SizedBox(width: 15),
                      GestureDetector(
                        child: Container(
                          width: 35,
                          height: 35,
                          child: Icon(
                            Icons.play_circle_filled,
                            color: Colors.red,
                            size: 33,
                          ),
                        ),
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (_) => GameTrailerPage(
                                      selectedGame.id, selectedGame.name)));
                        },
                      ),
                    ],
                  )
                ],
              ),
              SizedBox(height: 10),
              Text('Tags:',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w500,
                  )),
              Container(
                width: double.infinity,
                height: 80,
                child: ListView(
                    scrollDirection: Axis.horizontal,
                    children: selectedGame.tags
                        .map((tag) => Padding(
                              padding: const EdgeInsets.only(right: 10),
                              child: ChoiceChip(
                                label: Text(tag.name),
                                selected: false,
                              ),
                            ))
                        .toList()),
              ),
              Expanded(
                flex: 2,
                child: ListView(
                  children: <Widget>[
                    Text('Minimum Requirements:',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w500,
                        )),
                    Html(
                        data:
                            selectedPlatform.requirementsEn?.minimum ?? 'N/A'),
                    SizedBox(height: 10),
                    Text('Recommendation Requirements:',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w500,
                        )),
                    Html(
                        data: selectedPlatform.requirementsEn?.recommended ??
                            'N/A'),
                    SizedBox(height: 10),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 10.0),
                child: Text('Screen Shoots:',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w500,
                    )),
              ),
              Expanded(
                flex: 1,
                child: selectedGame.shortScreenshots.isEmpty
                    ? Text(
                        'No Screen Shots',
                        style: TextStyle(
                          fontSize: 20,
                        ),
                      )
                    : ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: selectedGame.shortScreenshots.length,
                        itemBuilder: (context, index) {
                          return Padding(
                            padding: const EdgeInsets.only(right: 10.0),
                            child: GestureDetector(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (_) => DetailImage(
                                              screenShoots:
                                                  selectedGame.shortScreenshots,
                                            )));
                              },
                              child: Hero(
                                tag: selectedGame.shortScreenshots[index].image,
                                child: CachedNetworkImage(
                                  fit: BoxFit.cover,
                                  imageUrl: selectedGame
                                      .shortScreenshots[index].image,
                                  fadeInCurve: Curves.bounceIn,
                                  fadeOutCurve: Curves.easeInOut,
                                  placeholder: (_, url) =>
                                      CupertinoActivityIndicator(
                                    radius: 25,
                                  ),
                                  errorWidget: (_, url, __) =>
                                      Center(child: Icon(Icons.error)),
                                ),
                              ),
                            ),
                          );
                        }),
              )
            ],
          ),
        ),
      ),
    ));
  }
}
