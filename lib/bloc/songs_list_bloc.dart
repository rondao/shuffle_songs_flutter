import 'dart:math';

import 'package:collection/collection.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'package:shuffle_songs/models/song.dart';
import 'package:shuffle_songs/repository/songs_repository.dart';

part 'songs_list_state.dart';

enum SongsListEvent { fetchSongs, shuffleSongs }

class SongsListBloc extends Bloc<SongsListEvent, SongsListState> {
  SongsRepository songsRepository;
  var _songs = <Song>[];

  SongsListBloc(this.songsRepository) : super(SongsListInitial()) {
    on<SongsListEvent>(((event, emit) async {
      switch (event) {
        case SongsListEvent.fetchSongs:
          emit(SongsListLoading());
          try {
            _songs = await songsRepository.fetchSongs();
            emit(SongsListReady(_songs));
          } catch (e) {
            emit(SongsListError());
          }
          break;
        case SongsListEvent.shuffleSongs:
          if (_songs != null && _songs.isNotEmpty) {
            _songs = shuffleSongs(_songs);
            emit(SongsListReady(_songs));
          }
          break;
      }
    }));
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
