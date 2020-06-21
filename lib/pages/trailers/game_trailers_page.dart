import 'package:belajar_bloc/pages/trailers/bloc/bloc_gametrailer_bloc.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:video_player/video_player.dart';

class GameTrailerPage extends StatefulWidget {
  final int gameId;
  final String gameName;

  GameTrailerPage(this.gameId, this.gameName);
  @override
  _GameTrailerPageState createState() => _GameTrailerPageState();
}

class _GameTrailerPageState extends State<GameTrailerPage> {
  VideoPlayerController _videoPlayerController;

  String trailerTitle = '';

  @override
  void initState() {
    super.initState();
    BlocProvider.of<BlocGametrailerBloc>(context)
        .add(FetchGameTrailer(widget.gameId));
  }

  @override
  void dispose() {
    if (_videoPlayerController != null) {
      _videoPlayerController.dispose();
      print('Video player Disposed');
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      appBar: AppBar(title: Text(widget.gameName)),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text(
                  'Game Trailers:',
                  style: TextStyle(fontSize: 20),
                ),
                RaisedButton(
                    child: Text('Refresh'),
                    onPressed: () =>
                        BlocProvider.of<BlocGametrailerBloc>(context)
                            .add(FetchGameTrailer(widget.gameId)))
              ],
            ),
            SizedBox(height: 30),
            Text(
              'Title: $trailerTitle',
              style: TextStyle(fontSize: 18),
            ),
            Expanded(
              flex: 1,
              child: Container(
                alignment: Alignment.center,
                // color: Colors.blue,
                child: _videoPlayerController != null
                    ? AspectRatio(
                        aspectRatio: _videoPlayerController.value.aspectRatio,
                        child: Stack(
                          alignment: Alignment.bottomCenter,
                          children: <Widget>[
                            VideoPlayer(_videoPlayerController),
                            playPauseOverlay(_videoPlayerController),
                            VideoProgressIndicator(
                              _videoPlayerController,
                              allowScrubbing: true,
                            )
                          ],
                        ),
                      )
                    : Text('Video is Not Ready'),
              ),
            ),
            Text(
              'Trailers List: ',
              style: TextStyle(fontSize: 18),
            ),
            SizedBox(height: 10),
            BlocBuilder<BlocGametrailerBloc, BlocGametrailerState>(
                builder: (_, state) {
              if (state is GamesTrailerLoading)
                return Expanded(
                    child: Center(child: CircularProgressIndicator()));
              if (state is GamesTrailerError)
                return Expanded(
                  child: Center(
                    child: Text(state.message,
                        style: TextStyle(fontSize: 20, color: Colors.red)),
                  ),
                );

              if (state is GamesTrailerLoaded) {
                if (state.gameTrailers.results.isEmpty)
                  return Expanded(
                      child: Center(
                    child: Text('No Trailers Available'),
                  ));
                else
                  return Expanded(
                    child: ListView.builder(
                        itemCount: state.gameTrailers.results.length,
                        itemBuilder: (context, index) {
                          var trailer = state.gameTrailers.results[index];
                          return ListTile(
                            leading: Container(
                              width: 100,
                              height: 200,
                              margin: EdgeInsets.all(5),
                              decoration: BoxDecoration(
                                color: Colors.grey.withOpacity(0.8),
                              ),
                              child: CachedNetworkImage(
                                fit: BoxFit.cover,
                                fadeInCurve: Curves.bounceIn,
                                fadeOutCurve: Curves.easeInOut,
                                imageUrl: trailer?.preview ??
                                    'assets/images/icons/no_image.png',
                                placeholder: (_, url) => Center(
                                    child: CupertinoActivityIndicator(
                                  radius: 18,
                                )),
                                errorWidget: (_, url, __) =>
                                    Center(child: Icon(Icons.error)),
                              ),
                            ),
                            title: Text(trailer.name),
                            onTap: () async {
                              if (_videoPlayerController != null) {
                                if (_videoPlayerController.value.isPlaying)
                                  _videoPlayerController.pause();
                              }

                              _videoPlayerController =
                                  VideoPlayerController.network(
                                      trailer.data.the480);
                              await _videoPlayerController.initialize();
                              trailerTitle = trailer.name;

                              setState(() {});
                            },
                          );
                        }),
                  );
              }

              return Container();
            })
          ],
        ),
      ),
    ));
  }

  Widget playPauseOverlay(VideoPlayerController controller) {
    return Stack(
      children: <Widget>[
        AnimatedSwitcher(
          duration: Duration(milliseconds: 50),
          reverseDuration: Duration(milliseconds: 200),
          child: controller.value.isPlaying
              ? SizedBox.shrink()
              : Container(
                  color: Colors.black26,
                  child: Center(
                    child: Icon(
                      Icons.play_arrow,
                      color: Colors.white,
                      size: 100.0,
                    ),
                  ),
                ),
        ),
        GestureDetector(
          onTap: () {
            setState(() {
              controller.value.isPlaying
                  ? controller.pause()
                  : controller.play();
            });
          },
        ),
      ],
    );
  }
}
