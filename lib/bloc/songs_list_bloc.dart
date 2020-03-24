import 'dart:async';
import 'dart:math';

import 'package:collection/collection.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;
import 'package:meta/meta.dart';
import 'package:shuffle_songs/models/song.dart';
import 'package:shuffle_songs/network/songs_api.dart' as songsApi;

part 'songs_list_state.dart';

enum SongsListEvent { fetchSongs, shuffleSongs }

class SongsListBloc extends Bloc<SongsListEvent, SongsListState> {
  var _songs = <Song>[];

  @override
  SongsListState get initialState => SongsListLoading();

  @override
  Stream<SongsListState> mapEventToState(
    SongsListEvent event,
  ) async* {
    switch (event) {
      case SongsListEvent.fetchSongs:
        yield SongsListLoading();
        try {
          _songs = await songsApi.fetchSongs(http.Client());
          yield SongsListReady(_songs);
        } catch (e) {
          yield SongsListError();
        }
        break;
      case SongsListEvent.shuffleSongs:
        if (_songs.isNotEmpty) {
          _songs = shuffleSongs(_songs);
          yield SongsListReady(_songs);
        }
        break;
    }
  }

  List<Song> shuffleSongs(List<Song> songs) {
    final songsByArtist = groupBy<Song, int>(songs, (song) => song.artistId);

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
}
