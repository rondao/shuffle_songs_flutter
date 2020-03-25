part of 'songs_list_bloc.dart';

@immutable
abstract class SongsListState extends Equatable {
  const SongsListState();
}

class SongsListInitial extends SongsListState {
  const SongsListInitial();

  @override
  List<Object> get props => [];
}

class SongsListLoading extends SongsListState {
  const SongsListLoading();

  @override
  List<Object> get props => [];
}

class SongsListReady extends SongsListState {
  final List<Song> songs;
  SongsListReady(this.songs);

  @override
  List<Object> get props => [songs];
}

class SongsListError extends SongsListState {
  const SongsListError();

  @override
  List<Object> get props => [];
}
