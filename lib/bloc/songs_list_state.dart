part of 'songs_list_bloc.dart';

@immutable
abstract class SongsListState {}

class SongsListLoading extends SongsListState {}

class SongsListLoaded extends SongsListState {
  final List<Song> songs;
  SongsListLoaded(this.songs);
}

class SongsListError extends SongsListState {}
