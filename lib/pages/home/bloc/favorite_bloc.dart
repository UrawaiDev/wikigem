import 'package:flutter_bloc/flutter_bloc.dart';

class FavoriteBloc extends Bloc<FavoriteEvents, FavoriteState> {
  List<String> _games = [];

  @override
  get initialState => FavoriteEmpty();

  @override
  Stream<FavoriteState> mapEventToState(FavoriteEvents event) async* {
    if (event is AddFavorite) {
      _games.add(event.gamesName);

      yield FavoriteAdded(_games);
    }

    if (event is ClearFavorite) {
      _games.clear();
      yield FavoriteEmpty();
    }
  }
}

abstract class FavoriteState {}

class FavoriteAdded extends FavoriteState {
  List<String> gameName;

  FavoriteAdded(this.gameName);

  @override
  String toString() {
    return '{current length: $gameName }';
  }
}

class FavoriteEmpty extends FavoriteState {}

abstract class FavoriteEvents {}

class AddFavorite extends FavoriteEvents {
  final String gamesName;

  AddFavorite(this.gamesName);
}

class ClearFavorite extends FavoriteEvents {}
