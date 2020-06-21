import 'dart:async';

import 'package:belajar_bloc/cores/services/api_services.dart';
import 'package:belajar_bloc/models/games.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'bloc_games_event.dart';
part 'bloc_games_state.dart';

class GamesBloc extends Bloc<BlocGamesEvent, BlocGamesState> {
  @override
  BlocGamesState get initialState => GamesIntial();

  @override
  Stream<BlocGamesState> mapEventToState(
    BlocGamesEvent event,
  ) async* {
    GamesApiClient _apiService = GamesApiClient();

    if (event is FetchGames) {
      yield GamesLoading();

      try {
        final Games gamesLoaded = await _apiService.loadGames(page: 1);

        yield GamesLoaded(
          gameList: gamesLoaded,
          gamesResult: gamesLoaded.results,
          hasReachMax: false,
          currentPage: 1,
        );
      } catch (e) {
        yield GamesError(e.toString());
      }
    } else if (event is FetchMoreGames) {
      print('Fetch more Called');
      if (state is GamesLoaded) {
        print('Fetch more Called and Stated is Games Loaded');

        final gameState = state as GamesLoaded;
        int currentPage = gameState.currentPage + 1;
        try {
          final Games gamesLoaded =
              await _apiService.loadGames(page: currentPage);
          yield gamesLoaded.next == null
              ? GamesLoaded(hasReachMax: true)
              : GamesLoaded(
                  gameList: gamesLoaded,
                  gamesResult: gameState.gamesResult + gamesLoaded.results,
                  hasReachMax: false,
                  currentPage: currentPage,
                );
        } catch (e) {
          yield GamesError(e.toString());
        }
      }
    }
  }
}
