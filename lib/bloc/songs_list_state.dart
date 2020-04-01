part of 'songs_list_bloc.dart';

@immutable
abstract class SongsListState extends Equatable {
  const SongsListState();

  @override
  List<Object> get props => [];
}

class SongsListInitial extends SongsListState {}

class SongsListLoading extends SongsListState {}

class SongsListReady extends SongsListState {
  final List<Song> songs;
  SongsListReady(this.songs);

  @override
  List<Object> get props => [songs];
}

class SongsListError extends SongsListState {}
