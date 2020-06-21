part of 'bloc_games_bloc.dart';

abstract class BlocGamesState extends Equatable {
  const BlocGamesState();
}

class GamesIntial extends BlocGamesState {
  @override
  List<Object> get props => null;
}

class GamesEmpty extends BlocGamesState {
  @override
  List<Object> get props => null;
}

class GamesLoading extends BlocGamesState {
  @override
  List<Object> get props => null;
}

class GamesLoaded extends BlocGamesState {
  final Games gameList;
  final List<Result> gamesResult;
  final bool hasReachMax;
  final int currentPage;

  GamesLoaded(
      {this.gameList, this.gamesResult, this.hasReachMax, this.currentPage});

  @override
  List<Object> get props => [gameList];
}

class GamesError extends BlocGamesState {
  final String message;

  GamesError(this.message);

  @override
  List<Object> get props => [message];
}

class UnknownState extends BlocGamesState {
  @override
  List<Object> get props => [];

  @override
  String toString() {
    return '{Unknown State}';
  }
}
