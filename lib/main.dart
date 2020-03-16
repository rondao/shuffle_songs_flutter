import 'package:flutter/material.dart';

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
      ),
      home: SongsList(title: 'Shuffle Songs'),
    );
  }
}

class SongsList extends StatefulWidget {
  SongsList({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _SongsListState createState() => _SongsListState();
}

class _SongsListState extends State<SongsList> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      backgroundColor: Theme.of(context).primaryColorDark,
      body: Center(
        child: Text('Sample text!'),
      ),
    );
  }
}
