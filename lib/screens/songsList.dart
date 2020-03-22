import 'dart:math';

import 'package:collection/collection.dart';
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
            onPressed: () => setState(() {
              _songs = shuffleSongs(_songs);
            }),
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

Future<List<Song>> shuffleSongs(Future<List<Song>> songs) async {
  final songsByArtist =
      groupBy<Song, int>(await songs, (song) => song.artistId);

  final priorityQueue = PriorityQueue<List<Song>>(songsListCompare);
  priorityQueue.addAll(songsByArtist.values);

  final shuffledSongs = <Song>[];

  var previousList = priorityQueue.removeFirst();
  while (priorityQueue.isNotEmpty) {
    final currentList = priorityQueue.removeFirst();
    shuffledSongs
        .add(currentList.removeAt(Random().nextInt(currentList.length)));

    if (previousList.isNotEmpty) priorityQueue.add(previousList);
    previousList = currentList;
  }

  if (previousList.isNotEmpty) shuffledSongs.addAll(previousList);

  return shuffledSongs;
}

int songsListCompare(List<Song> list1, List<Song> list2) {
  final diff = list2.length - list1.length;
  return diff * 10 + Random().nextInt(10);
}
