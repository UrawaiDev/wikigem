import 'dart:async';

import 'package:belajar_bloc/cores/services/api_services.dart';
import 'package:belajar_bloc/models/game_trailers.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'bloc_gametrailer_event.dart';
part 'bloc_gametrailer_state.dart';

class BlocGametrailerBloc
    extends Bloc<BlocGametrailerEvent, BlocGametrailerState> {
  GamesApiClient _apiClient = GamesApiClient();
  @override
  BlocGametrailerState get initialState => BlocGametrailerInitial();

  @override
  Stream<BlocGametrailerState> mapEventToState(
    BlocGametrailerEvent event,
  ) async* {
    if (event is FetchGameTrailer) {
      try {
        yield GamesTrailerLoading();
        GameTrailers gamesTrailerLoaded =
            await _apiClient.getTrailers(gameId: event.gameId);

        yield GamesTrailerLoaded(gamesTrailerLoaded);
      } catch (e) {
        yield GamesTrailerError(e.toString());
      }
    }
  }
}
