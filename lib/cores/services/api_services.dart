import 'dart:convert';
import 'dart:io';

import 'package:belajar_bloc/models/game_trailers.dart';
import 'package:belajar_bloc/models/games.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

class GamesApiClient {
  static const basicUrl = 'https://api.rawg.io/api/games?page=';

  Future<Games> loadGames({@required int page}) async {
    var result;
    print(basicUrl + '$page');
    http.Response response = await http.get(basicUrl + '$page',
        headers: {HttpHeaders.userAgentHeader: 'applications/rawg.io_flutter'});
    if (response.statusCode == 200) {
      result = jsonDecode(response.body);
    }

    return Games.fromJson(result);
  }

  Future<GameTrailers> getTrailers({@required int gameId}) async {
    var result;
    http.Response response = await http.get(
        'https://api.rawg.io/api/games/$gameId/movies',
        headers: {HttpHeaders.userAgentHeader: 'applications/rawg.io_flutter'});
    print('https://api.rawg.io/api/games/$gameId/movies');
    if (response.statusCode == 200) {
      result = jsonDecode(response.body);
    }
    return GameTrailers.fromJson(result);
  }
}
