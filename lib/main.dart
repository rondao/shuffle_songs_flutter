import 'package:flutter/material.dart';
import 'package:shuffle_songs/ui/songsList.dart';

void main() => runApp(ShuffleSongs());

class ShuffleSongs extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Shuffle Songs',
      theme: ThemeData(
        accentColor: Color(0xFF783F4F),
        primaryColor: Color(0xFF452E3E),
        primaryColorDark: Color(0xFF362436),
        textTheme: TextTheme(
          headline5: TextStyle(color: Colors.red, fontSize: 18),
          bodyText1: TextStyle(color: Colors.white),
        ),
      ),
      home: SongsList(),
    );
  }
}
