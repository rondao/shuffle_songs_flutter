import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'package:shuffle_songs/models/song.dart';
import 'package:shuffle_songs/network/songsApi.dart' as songsApi;
import 'package:shuffle_songs/screens/components/songTile.dart';

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
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.shuffle),
            onPressed: () {},
          )
        ],
      ),
      backgroundColor: Theme.of(context).primaryColorDark,
      body: FutureBuilder<List<Song>>(
        future: _songs,
        builder: (context, snapshot) {
          if (snapshot.hasError)
            return Center(
              child: Icon(
                Icons.cloud_off,
                color: Colors.white70,
                size: 128,
              ),
            );

          return snapshot.hasData
              ? ListView.separated(
                  itemCount: snapshot.data.length,
                  itemBuilder: (context, index) {
                    return SongTile(snapshot.data[index]);
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

class SongsListDivider extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Divider(
      color: Colors.grey,
      thickness: 0.3,
    );
  }
}
