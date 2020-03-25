import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:shuffle_songs/bloc/songs_list_bloc.dart';
import 'package:shuffle_songs/repository/songs_repository.dart';

import 'assets/songs_list_mock.dart';

class MockSongsRepository extends Mock implements SongsRepository {}

void main() {
  MockSongsRepository mockSongsRepository;

  setUp(() {
    mockSongsRepository = MockSongsRepository();
  });

  blocTest(
    'FechSongs and ShuffleSongs emits [SongsListInitial, SongsListLoading, SongsListReady, SongsListReady] when successful',
    build: () async {
      when(mockSongsRepository.fetchSongs())
          .thenAnswer((_) async => mockSongsList);
      return SongsListBloc(mockSongsRepository);
    },
    act: (bloc) async {
      bloc.add(SongsListEvent.fetchSongs);
      bloc.add(SongsListEvent.shuffleSongs);
    },
    skip: 0,
    expect: [
      SongsListInitial(), // Do not skip initial state.
      SongsListLoading(),
      SongsListReady(mockSongsList),
      isA<SongsListReady>(),
    ],
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
  );
}
