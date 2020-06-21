part of 'bloc_games_bloc.dart';

abstract class BlocGamesEvent extends Equatable {
  const BlocGamesEvent();
}

class FetchGames extends BlocGamesEvent {
  @override
  List<Object> get props => null;
}

class FetchMoreGames extends BlocGamesEvent {
  @override
  List<Object> get props => null;
}
