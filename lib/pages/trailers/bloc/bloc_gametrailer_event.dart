part of 'bloc_gametrailer_bloc.dart';

abstract class BlocGametrailerEvent extends Equatable {
  const BlocGametrailerEvent();
}

class FetchGameTrailer extends BlocGametrailerEvent {
  final int gameId;

  FetchGameTrailer(this.gameId);
  @override
  List<Object> get props => [gameId];
}
