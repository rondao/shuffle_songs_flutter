import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:shuffle_songs/bloc/songs_list_bloc.dart';
import 'package:shuffle_songs/models/song.dart';
import 'package:shuffle_songs/repository/songs_repository.dart';

import 'assets/songs_list_mock.dart';

class MockSongsRepository extends Mock implements SongsRepository {}

void main() {
  MockSongsRepository mockSongsRepository;
  SongsListBloc songsListBloc;

  setUp(() {
    mockSongsRepository = MockSongsRepository();
    songsListBloc = SongsListBloc(mockSongsRepository);
  });

  blocTest(
    'FetchSongs and ShuffleSongs emits [SongsListInitial, SongsListLoading, SongsListReady, SongsListReady] when successful and shuffles songs correctly',
    build: () async {
      when(mockSongsRepository.fetchSongs())
          .thenAnswer((_) async => mockSongsList);
      return songsListBloc;
    },
    act: (bloc) async {
      bloc.add(SongsListEvent.fetchSongs);
      bloc.add(SongsListEvent.shuffleSongs);
    },
    skip: 0,
    expect: [
      SongsListInitial(),
      SongsListLoading(),
      SongsListReady(mockSongsList),
      isA<SongsListReady>(),
    ],
    verify: (_) async {
      verify(mockSongsRepository.fetchSongs()).called(1);

      SongsListReady songsListAfterShuffle =
          await songsListBloc.firstWhere((element) => element is SongsListReady);
      expect(hasAdjacentArtists(songsListAfterShuffle.songs), false);
    },
  );
  blocTest(
    'FetchSongs and ShuffleSongs emits [SongsListInitial, SongsListLoading, SongsListReady] when empty list',
    build: () async {
      when(mockSongsRepository.fetchSongs()).thenAnswer((_) async => []);
      return songsListBloc;
    },
    act: (bloc) async {
      bloc.add(SongsListEvent.fetchSongs);
      bloc.add(SongsListEvent.shuffleSongs);
    },
    skip: 0,
    expect: [
      SongsListInitial(),
      SongsListLoading(),
      SongsListReady([]),
    ],
    verify: (_) async {
      verify(mockSongsRepository.fetchSongs()).called(1);
    },
  );
  blocTest(
    'FetchSongs and ShuffleSongs emits [SongsListInitial, SongsListLoading, SongsListReady] when list is null',
    build: () async {
      when(mockSongsRepository.fetchSongs()).thenAnswer((_) async => null);
      return songsListBloc;
    },
    act: (bloc) async {
      bloc.add(SongsListEvent.fetchSongs);
      bloc.add(SongsListEvent.shuffleSongs);
    },
    skip: 0,
    expect: [
      SongsListInitial(),
      SongsListLoading(),
      SongsListReady(null),
    ],
    verify: (_) async {
      verify(mockSongsRepository.fetchSongs()).called(1);
    },
  );
  blocTest(
    'FetchSongs emits [SongsListLoading, SongsListError] when failure',
    build: () async {
      when(mockSongsRepository.fetchSongs()).thenThrow(Error());
      return SongsListBloc(mockSongsRepository);
    },
    act: (bloc) => bloc.add(SongsListEvent.fetchSongs),
    expect: [
      SongsListLoading(),
      SongsListError(),
    ],
    verify: (_) async {
      verify(mockSongsRepository.fetchSongs()).called(1);
    },
  );
}

bool hasAdjacentArtists(List<Song> songs) {
  Song previousSong = songs.first;
  for (final song in songs.skip(1)) {
    if (previousSong.artistId == song.artistId) return true;
    previousSong = song;
  }
  return false;
}
