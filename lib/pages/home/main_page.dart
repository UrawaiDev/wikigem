import 'package:belajar_bloc/pages/home/bloc/bloc_games_bloc.dart';
import 'package:belajar_bloc/pages/home/bloc/favorite_bloc.dart';
import 'package:belajar_bloc/pages/platforms/detail_platform.dart';
import 'package:belajar_bloc/utils/const/font_const.dart';
import 'package:belajar_bloc/utils/functions/generalFunction.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MainPage extends StatefulWidget {
  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  final ScrollController _scrollController = ScrollController();
  int currentPage = 1;

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(() {
      if (_scrollController.offset >=
          _scrollController.position.maxScrollExtent) {
        print('scroll has reach bottom');
        BlocProvider.of<GamesBloc>(context).add(FetchMoreGames());
      }
    });
  }

  @override
  void dispose() {
    super.dispose();
    _scrollController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('RAWG.io Gaming API'),
        actions: <Widget>[
          Stack(
            children: <Widget>[
              Container(
                width: 50,
                height: 50,
                child: IconButton(
                    icon: Icon(Icons.shopping_cart),
                    iconSize: 25,
                    onPressed: () {
                      var state = BlocProvider.of<FavoriteBloc>(context).state;
                      if (state is FavoriteAdded)
                        state.gameName.forEach((data) => print(data));
                    }),
              ),
              BlocBuilder<FavoriteBloc, FavoriteState>(builder: (_, state) {
                if (state is FavoriteAdded) {
                  return (state is FavoriteAdded)
                      ? Positioned(
                          right: 0,
                          top: 0,
                          child: Container(
                            width: 25,
                            height: 25,
                            child: CircleAvatar(
                                backgroundColor: Colors.red,
                                child: Text(
                                  state.gameName.length.toString() ?? '0',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 12,
                                    fontWeight: FontWeight.bold,
                                  ),
                                )),
                          ),
                        )
                      : Container();
                }
                return Container();
              })
            ],
          ),
          IconButton(
              icon: Icon(
                Icons.clear,
                color: Colors.white,
                size: 25,
              ),
              onPressed: () {
                BlocProvider.of<FavoriteBloc>(context).add(ClearFavorite());
              })
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text(
                  'Game List:',
                  style: FontConst.kBoldFont_19,
                ),
                RaisedButton(
                  onPressed: () {
                    BlocProvider.of<GamesBloc>(context).add(FetchGames());
                  },
                  child: Text('Refresh'),
                ),
              ],
            ),
            BlocBuilder<GamesBloc, BlocGamesState>(
              builder: (context, state) {
                if (state is GamesLoaded) {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                          'Jumlah Data ' + state.gamesResult.length.toString()),
                      Text('Current Page : ${state.currentPage}' ?? '[null]'),
                    ],
                  );
                }
                return Container();
              },
            ),
            SizedBox(height: 20),
            Expanded(
              child: BlocBuilder<GamesBloc, BlocGamesState>(
                builder: (context, gamesState) {
                  if (gamesState is GamesIntial)
                    BlocProvider.of<GamesBloc>(context).add(FetchGames());

                  if (gamesState is GamesEmpty)
                    return Center(child: Text('No Games Result'));
                  else if (gamesState is GamesLoading)
                    return Center(child: CircularProgressIndicator());
                  else if (gamesState is GamesError)
                    return Center(child: Text(gamesState.message));

                  return gamesState is GamesLoaded
                      ? ListView.builder(
                          controller: _scrollController,
                          itemCount: (gamesState.hasReachMax)
                              ? gamesState.gamesResult.length
                              : gamesState.gamesResult.length + 1,
                          itemBuilder: (context, index) {
                            if (index >= gamesState.gamesResult.length)
                              return Center(child: CircularProgressIndicator());

                            return ExpansionTile(
                              leading: Container(
                                width: 100,
                                height: 200,
                                // margin: EdgeInsets.all(5),
                                decoration: BoxDecoration(
                                  color: Colors.grey.withOpacity(0.8),
                                ),
                                child: CachedNetworkImage(
                                  fit: BoxFit.cover,
                                  fadeInCurve: Curves.bounceIn,
                                  fadeOutCurve: Curves.easeInOut,
                                  imageUrl: gamesState.gamesResult[index]
                                          ?.backgroundImage ??
                                      'assets/images/icons/unknown.png',
                                  placeholder: (_, url) => Center(
                                      child: CupertinoActivityIndicator(
                                    radius: 18,
                                  )),
                                  errorWidget: (_, url, __) =>
                                      Center(child: Icon(Icons.error)),
                                ),
                              ),
                              title: Text(gamesState.gamesResult[index].name),
                              subtitle: Text(
                                  'Released on ${gamesState.gamesResult[index].platforms.length} Platforms'),
                              children: gamesState.gamesResult[index].platforms
                                  .map((data) => ListTile(
                                        leading: Container(
                                          width: 30,
                                          height: 30,
                                          child:
                                              GeneralFunction.getPlatformIcon(
                                                  data.platform.id),
                                        ),
                                        title: Text(data.platform.name),
                                        onTap: () {
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (_) =>
                                                      DetailPlatformPage(
                                                          gamesState
                                                                  .gamesResult[
                                                              index],
                                                          data)));
                                        },
                                      ))
                                  .toList(),
                            );
                          })
                      : Container();
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
