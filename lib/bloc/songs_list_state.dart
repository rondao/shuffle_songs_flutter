part of 'songs_list_bloc.dart';

@immutable
abstract class SongsListState {}

class SongsListLoading extends SongsListState {}

class SongsListReady extends SongsListState {
  final List<Song> songs;
  SongsListReady(this.songs);
}

class SongsListError extends SongsListState {}
