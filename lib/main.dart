import 'package:belajar_bloc/pages/home/bloc/bloc_games_bloc.dart';
import 'package:belajar_bloc/pages/home/bloc/favorite_bloc.dart';
import 'package:belajar_bloc/pages/home/main_page.dart';
import 'package:belajar_bloc/pages/trailers/bloc/bloc_gametrailer_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

import 'cores/simple_bloc_delegate.dart';

void main() {
  BlocSupervisor.delegate = SimpleBlocDelegate();

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => GamesBloc()),
        BlocProvider(create: (_) => FavoriteBloc()),
        BlocProvider(create: (_) => BlocGametrailerBloc()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'WikiGem',
        theme: ThemeData(
          textTheme: GoogleFonts.latoTextTheme(),
          primarySwatch: Colors.blue,
        ),
        home: MainPage(),
      ),
    );
  }
}
