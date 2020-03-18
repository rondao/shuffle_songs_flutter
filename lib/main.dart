import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'models/song.dart';
import 'network/songsApi.dart' as songsApi;
import 'screens/songsList.dart';

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

class SongsList extends StatefulWidget {
  @override
  _SongsListState createState() => _SongsListState();
}

class _SongsListState extends State<SongsList> {
  Future<List<Song>> _songs;

  @override
  void initState() {
    _songs = songsApi.fetchSongs(http.Client());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Shuffle Songs"),
      ),
      backgroundColor: Theme.of(context).primaryColorDark,
      body: FutureBuilder<List<Song>>(
        future: _songs,
        builder: (context, snapshot) {
          if (snapshot.hasError) print(snapshot.error);

          return snapshot.hasData
              ? ListView.separated(
                  itemCount: snapshot.data.length,
                  itemBuilder: (context, index) {
                    return SongTile(snapshot.data[index].trackName,
                        snapshot.data[index].primaryGenreName);
                  },
                  separatorBuilder: (context, index) {
                    return SongsListDivider();
                  },
                )
              : Center(child: CircularProgressIndicator());
        },
      ),
    );
  }
}
