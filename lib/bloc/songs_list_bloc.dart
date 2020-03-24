import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;
import 'package:meta/meta.dart';
import 'package:shuffle_songs/models/song.dart';
import 'package:shuffle_songs/network/songs_api.dart' as songsApi;

part 'songs_list_state.dart';

enum SongsListEvent { fetchSongs }

class SongsListBloc extends Bloc<SongsListEvent, SongsListState> {
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
          yield SongsListLoaded(await songsApi.fetchSongs(http.Client()));
        } catch (e) {
          yield SongsListError();
        }
        break;
    }
  }
}
