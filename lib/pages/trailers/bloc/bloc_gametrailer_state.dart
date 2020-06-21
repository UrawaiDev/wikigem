part of 'bloc_gametrailer_bloc.dart';

abstract class BlocGametrailerState extends Equatable {
  const BlocGametrailerState();
}

class BlocGametrailerInitial extends BlocGametrailerState {
  @override
  List<Object> get props => [];
}

class GamesTrailerLoading extends BlocGametrailerState {
  @override
  List<Object> get props => null;
}

class GamesTrailerLoaded extends BlocGametrailerState {
  final GameTrailers gameTrailers;

  GamesTrailerLoaded(this.gameTrailers);

  @override
  List<Object> get props => [gameTrailers];
}

class GamesTrailerError extends BlocGametrailerState {
  final String message;

  GamesTrailerError(this.message);

  @override
  List<Object> get props => [message];
}
