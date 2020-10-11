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

  test('SongsListBloc expects SongsListInitial as initial state', () {
    expect(songsListBloc.state, SongsListInitial());
  });
  blocTest<SongsListBloc, SongsListState>(
    'FetchSongs and ShuffleSongs emits [SongsListLoading, SongsListReady, SongsListReady] when successful and shuffles songs correctly',
    build: () {
      when(mockSongsRepository.fetchSongs())
          .thenAnswer((_) async => mockSongsList);
      return songsListBloc;
    },
    act: (bloc) {
      bloc.add(SongsListEvent.fetchSongs);
      bloc.add(SongsListEvent.shuffleSongs);
    },
    expect: [
      SongsListLoading(),
      SongsListReady(mockSongsList),
      isA<SongsListReady>(),
    ],
    verify: (_) {
      verify(mockSongsRepository.fetchSongs()).called(1);

      SongsListReady songsListAfterShuffle = songsListBloc.state;
      expect(hasAdjacentArtists(songsListAfterShuffle.songs), false);
    },
  );
  blocTest<SongsListBloc, SongsListState>(
    'FetchSongs and ShuffleSongs emits [SongsListLoading, SongsListReady] when empty list',
    build: () {
      when(mockSongsRepository.fetchSongs()).thenAnswer((_) async => []);
      return songsListBloc;
    },
    act: (bloc) {
      bloc.add(SongsListEvent.fetchSongs);
      bloc.add(SongsListEvent.shuffleSongs);
    },
    expect: [
      SongsListLoading(),
      SongsListReady([]),
    ],
    verify: (_) {
      verify(mockSongsRepository.fetchSongs()).called(1);
    },
  );
  blocTest<SongsListBloc, SongsListState>(
    'FetchSongs and ShuffleSongs emits [SongsListLoading, SongsListReady] when list is null',
    build: () {
      when(mockSongsRepository.fetchSongs()).thenAnswer((_) async => null);
      return songsListBloc;
    },
    act: (bloc) {
      bloc.add(SongsListEvent.fetchSongs);
      bloc.add(SongsListEvent.shuffleSongs);
    },
    expect: [
      SongsListLoading(),
      SongsListReady(null),
    ],
    verify: (_) {
      verify(mockSongsRepository.fetchSongs()).called(1);
    },
  );
  blocTest<SongsListBloc, SongsListState>(
    'FetchSongs emits [SongsListLoading, SongsListError] when failure',
    build: () {
      when(mockSongsRepository.fetchSongs()).thenThrow(Error());
      return SongsListBloc(mockSongsRepository);
    },
    act: (bloc) => bloc.add(SongsListEvent.fetchSongs),
    expect: [
      SongsListLoading(),
      SongsListError(),
    ],
    verify: (_) {
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
