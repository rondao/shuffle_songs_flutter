import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shuffle_songs/bloc/songs_list_bloc.dart';
import 'package:shuffle_songs/network/songs_api.dart';
import 'package:shuffle_songs/ui/songs_list.dart';

void main() => runApp(ShuffleSongs());

class ShuffleSongs extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Shuffle Songs',
      theme: ThemeData(
        primaryColor: Color(0xFF452E3E),
        primaryColorDark: Color(0xFF362436),
        textTheme: TextTheme(
          headline5: TextStyle(color: Colors.red, fontSize: 18),
          bodyText1: TextStyle(color: Colors.white),
        ),
        colorScheme:
            ColorScheme.fromSwatch().copyWith(secondary: Color(0xFF783F4F)),
      ),
      home: BlocProvider(
          create: (_) => SongsListBloc(SongsNetworkRepository()),
          child: SongsList()),
    );
  }
}
